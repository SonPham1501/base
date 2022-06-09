import 'package:base/src/Common/Constant.dart';
import 'package:base/src/Helper/navigator.dart';
import 'package:base/src/Widget/ButtonWidget.dart';
import 'package:base/src/Widget/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:graphql/client.dart';

class DialogUtil {

  static Future<void> onChangeStatusFailed(List<GraphQLError> errors) async {
    await showGraphQLErrorDialog(errors);
  }

  static Future<void> showGraphQLErrorDialog(List<GraphQLError> errors, {String? code}) async {
    final message = errors.isEmpty == true || errors.first.message.isEmpty
        ? 'Máy chủ đang bảo trì.'
        : (code ?? '') + errors.first.message;

    return await showSimpleDialog(message);
  }

  static Future<void> showSimpleDialog(String message) async {
    return await showDialog<void>(
      context: navigationService.context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static showLoading() {
    // Future.delayed(Duration.zero, () async {
    //   Get.dialog(
    //     WillPopScope(
    //       onWillPop: () => Future.value(false),
    //       child: Container(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container(
    //               width: 25,
    //               height: 25,
    //               child: CircularProgressIndicator(
    //                 valueColor: AlwaysStoppedAnimation<Color>(Constant.kColorOrangePrimary),
    //                 strokeWidth: 2,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     barrierDismissible: false,
    //
    //   );
    // });
    EasyLoading.show(maskType: EasyLoadingMaskType.black, indicator: const LoadingWidget());
  }

  static hideLoading() {
    //Get.back();
    EasyLoading.dismiss();
  }

  static Future<T?> buildBaseDialog<T>({
    Widget? header,
    Widget? body,
    List<Widget>? actions,
    bool? barrierDismissible,
    Color barrierColor = Colors.black54,
    double width = double.infinity,
    EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 16),
  }) async {
    BuildContext context = navigationService.context;

    Dialog buildDialog() {
      return Dialog(
        insetPadding: insetPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: header ?? const SizedBox(),
                  ),
                  body ?? const SizedBox(),
                  actions == null ? const SizedBox() : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: actions,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    T? result = await showDialog(
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible ?? true;
          },
          child: buildDialog(),
        );
      },
    );

    return result;
  }

  static showErrorDialog(BuildContext context, {String? error}) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Lỗi"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error.toString()),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ButtonWidget(
                height: 35,
                buttonType: ButtonType.Normal,
                onTap: Navigator.of(context).pop,
                title: "Thoát",
              ),
            ),
          ],
        ));
    });
  }

  static showCompleteDialog(BuildContext context, {String? content, String title = "Thông báo"}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(content.toString()),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: ButtonWidget(
                  height: 35,
                  buttonType: ButtonType.Normal,
                  onTap: Navigator.of(context).pop,
                  title: "Thoát",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static showInfo(BuildContext context, {String? content}) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(20),
          width: 335,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                child: Text(
                  content ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Constant.kColorBlackPrimary,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    height: 44,
                    buttonType: ButtonType.Normal,
                    onTap: Navigator.of(context).pop,
                    title: "Đóng",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }

  static showCompleteDialogQuestion(BuildContext context,
      {String? content,
      String title = "Thông báo",
      String titleCancel = "Đóng",
      String titleAction = "OK",
      Function? onButtonCancel,
      Function? onButtonAction}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(20),
            width: 335,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Constant.kColorBlackPrimary,
                  ),
                ),
                if (content != null && content.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                    child: Text(
                      content.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Constant.kColorBlackPrimary,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        height: 44,
                        buttonType: ButtonType.Cancel,
                        onTap: () {
                          Navigator.of(context).pop();
                          onButtonCancel?.call();
                        },
                        title: titleCancel,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ButtonWidget(
                        height: 44,
                        buttonType: ButtonType.Normal,
                        onTap: () {
                          Navigator.of(context).pop();
                          onButtonAction?.call();
                        },
                        title: titleAction,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showExitDialog(BuildContext context) {
    showDialog(
        barrierColor: const Color(0x01000000),
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Dialog(
            child: Container(
              width: 200,
              height: 30,
              decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Center(
                child: Text(
                  'Title',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          );
        });
  }

  static showConfirmDialog(BuildContext context, {String? content,
    String title = "Bạn có chắc không?",
    String titleCancel = "Đóng",
    String titleAction = "OK",
    Function? onButtonCancel,
    Function? onButtonAction}) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.all(0),
          width: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Constant.kColorText141,
                  ),
                ),
              ),
              if (content != null && content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Text(
                    content.toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Constant.kColorText141,
                    ),
                  ),
                )
              else
                const SizedBox(height: 24),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onButtonCancel?.call();
                },
                child: SizedBox(
                  height: 43,
                  child: Center(
                    child: Text(
                      titleCancel,
                      style: const TextStyle(color: Color(0xff007AFF), fontSize: 17),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onButtonAction?.call();
                },
                child: SizedBox(
                  height: 43,
                  child: Center(
                      child: Text(titleAction, style: const TextStyle(color: Color(0xff007AFF), fontSize: 17))),
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}
