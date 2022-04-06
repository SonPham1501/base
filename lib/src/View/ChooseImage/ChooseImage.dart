import 'dart:io';
export 'dart:io';

import 'package:CenBase/Common/Constant.dart';
import 'package:CenBase/Utils/FontUtil.dart';
import 'package:CenBase/Widget/LineBaseWidget.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

typedef VoidOnChooseImage = void Function(File image);

class ChooseImage {
  //Loading request permission
  Function? onShowLoading;
  Function? onActionTakePicture;
  Function? onHideLoading;
  VoidOnChooseImage? onChooseImage;
  Function(List<File> file)? onChooseMultiImage;

  final BuildContext context;
  var isCrop;
  var isMultiImage;
  String? title;

  ChooseImage({required this.context, this.onActionTakePicture, this.isCrop = false, this.isMultiImage = false});

  void show() async {
    showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        title ?? "",
                        style: TextStyle(
                          color: Constant.kColorBlackPrimary,
                          fontSize: 16,
                          fontFamily: FontUtil.bold,
                        ),
                      ),
                    ),
                    LineBaseWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(bc);
                        _chooseImage(ImageSource.camera);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "Chụp ảnh",
                          style: TextStyle(
                            color: Constant.kColorBlueLink,
                            fontSize: 16,
                            fontFamily: FontUtil.semiBold,
                          ),
                        ),
                      ),
                    ),
                    LineBaseWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(bc);
                        if (onActionTakePicture != null)
                          onActionTakePicture?.call();
                        else
                          _chooseImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "Chọn ảnh từ thư viện",
                          style: TextStyle(
                            color: Constant.kColorBlueLink,
                            fontSize: 16,
                            fontFamily: FontUtil.semiBold,
                          ),
                        ),
                      ),
                    ),
                    LineBaseWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(bc);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "Đóng",
                          style: TextStyle(
                            color: Constant.kColorBlackPrimary,
                            fontSize: 16,
                            fontFamily: FontUtil.semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<File?> compressFile(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 20,
    );

    return result;
  }

  _chooseImage(ImageSource imageSource) async {
    if (onShowLoading != null) {
      onShowLoading?.call();
    }
    String osVersion = Platform.operatingSystemVersion;
    print("osVersion $osVersion");
    if (isMultiImage && imageSource == ImageSource.gallery && Platform.isIOS && Util.getFirstVersionOS() < 14) {
      XFile? xFile;
      try {
        final ImagePicker _picker = ImagePicker();
        xFile = await _picker.pickImage(source: imageSource);
        if (xFile == null) {
          onHideLoading?.call();
          return;
        }
      } catch (ex) {
        onHideLoading?.call();
        return;
      }

      if (isCrop) {
        await new Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhotoPickerAndCropPage(
            file: File(xFile!.path),
            onCropImage: (imageFileCrop) {
              onChooseImage?.call(imageFileCrop);
              onChooseMultiImage?.call([imageFileCrop]);
            },
          ),
        ));
      } else {
        await new Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();
        onChooseImage?.call(File(xFile.path));
        onChooseMultiImage?.call([File(xFile.path)]);
      }
    } else if (isMultiImage && imageSource == ImageSource.gallery) {
      List<XFile>? listXFile;
      try {
        final ImagePicker _picker = ImagePicker();
        listXFile = await _picker.pickMultiImage(imageQuality: 20);
        if (listXFile == null) {
          onHideLoading?.call();
          return;
        }
      } catch (ex) {
        onHideLoading?.call();
        return;
      }
      await new Future.delayed(const Duration(milliseconds: 100));
      onHideLoading?.call();
      var listFile = <File>[];
      for (var item in listXFile) {
        listFile.add(File(item.path));
      }
      onChooseMultiImage?.call(listFile);
    } else {
      XFile? xFile;
      try {
        final ImagePicker _picker = ImagePicker();
        xFile = await _picker.pickImage(source: imageSource);
        if (xFile == null) {
          onHideLoading?.call();
          return;
        }
      } catch (ex) {
        onHideLoading?.call();
        return;
      }

      if (isCrop) {
        await new Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhotoPickerAndCropPage(
            file: File(xFile!.path),
            onCropImage: (imageFileCrop) {
              onChooseImage?.call(imageFileCrop);
              onChooseMultiImage?.call([imageFileCrop]);
            },
          ),
        ));
      } else {
        await new Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();
        onChooseImage?.call(File(xFile.path));
        onChooseMultiImage?.call([File(xFile.path)]);
      }
    }
  }
}

typedef VoidOnCropImage = void Function(File fileCrop);

class PhotoPickerAndCropPage extends StatefulWidget {
  final File file;
  final VoidOnCropImage? onCropImage;

  PhotoPickerAndCropPage({Key? key, required this.file, this.onCropImage}) : super(key: key);

  @override
  _PhotoPickerAndCropPageState createState() => new _PhotoPickerAndCropPageState();
}

class _PhotoPickerAndCropPageState extends State<PhotoPickerAndCropPage> {
  final cropKey = GlobalKey<CropState>();
  File? _file;
  File? _sample;
  File? _lastCropped;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _file = this.widget.file;
    _sample = this.widget.file;
    print("file: ${_file?.path}");

    //_createImageCrop();
  }

  @override
  void dispose() {
    super.dispose();
    //_file?.delete();
    //_sample?.delete();
    //_lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.black,
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(
            _sample!,
            key: cropKey,
            aspectRatio: 1,
            maximumScale: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                child: Text(
                  "Lưu",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              //_buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        'Open Image',
        style: TextStyle(color: Colors.white),
      ),
      //onPressed: () => _openImage(),
    );
  }

//  11:37:34.062
//  11:37:40.088
//
//  Future<void> _createImageCrop() async {
//    final sample = await ImageCrop.sampleImage(
//      file: _file,
//      preferredSize: context.size.longestSide.ceil(),
//    );
//
//    _sample?.delete();
//    _file?.delete();
//  }
//
//  Future<void> _openImage() async {
//    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
//    final sample = await ImageCrop.sampleImage(
//      file: file,
//      preferredSize: context.size.longestSide.ceil(),
//    );
//
//    _sample?.delete();
//    _file?.delete();
//
//    setState(() {
//      _sample = sample;
//      _file = file;
//    });
//  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState?.scale;
    final area = cropKey.currentState?.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
//    final sample = await ImageCrop.sampleImage(
//      file: _file,
//      preferredSize: (2000 / scale).round(),
//    );
    await new Future.delayed(const Duration(milliseconds: 100));
    print("_file?.path: ${_file?.path}");
    final file = await ImageCrop.cropImage(
      file: _file!,
      area: area,
      scale: 1,
    );
    print("file.path: ${file.path}" + file.path);
    //await new Future.delayed(const Duration(milliseconds: 200));

    //await new Future.delayed(const Duration(milliseconds: 200));
//    print(sample);
//    this.widget.file.delete();
    //sample.delete();

//    _lastCropped?.delete();
//    _lastCropped = file;
    Navigator.pop(context);
    if (this.widget.onCropImage != null) {
      this.widget.onCropImage?.call(file);
    }
    //debugPrint('$file');
  }
}
