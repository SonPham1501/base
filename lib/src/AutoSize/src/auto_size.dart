import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui show PointerDataPacket;
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../Utils/ScreenUtil.dart';
import 'auto_size_config.dart';

/// runAutoSizeApp.
///
/// width 设计稿尺寸 宽 dp or pt。
/// height 设计稿尺寸 高 dp or pt。
///
void runAutoSizeApp(Widget app, {required double width, double? height}) {
  AutoSizeConfig.setDesignWH(width: width, height: height);
  AutoSizeWidgetsFlutterBinding.ensureInitialized()!
    ..attachRootWidget(app)
    ..scheduleWarmUpFrame();
}

/// AutoSize.
class AutoSize {
  /// getSize.
  static Size getSize() {
    final Size size = window.physicalSize;
    if (size == Size.zero) return size;
    final Size autoSize = size.width > size.height
        ? Size(size.width / getPixelRatio(), AutoSizeConfig.designWidth)
        : Size(AutoSizeConfig.designWidth, size.height / getPixelRatio());
    return autoSize;
  }

  /// 获取适配后的像素密度。
  /// get the adapted pixel density.
  static double getPixelRatio() {
    final Size size = window.physicalSize;
    return (size.width > size.height ? size.height : size.width) / AutoSizeConfig.designWidth;
  }
}

/// A concrete binding for applications based on the Widgets framework.
///
/// This is the glue that binds the framework to the Flutter engine.
class AutoSizeWidgetsFlutterBinding extends WidgetsFlutterBinding {
  /// Returns an instance of the [WidgetsBinding], creating and
  /// initializing it if necessary. If one is created, it will be a
  /// [AutoSizeWidgetsFlutterBinding]. If one was previously initialized, then
  /// it will at least implement [WidgetsBinding].
  ///
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  ///
  /// In the `flutter_test` framework, [testWidgets] initializes the
  /// binding instance to a [TestWidgetsFlutterBinding], not a
  /// [AutoSizeWidgetsFlutterBinding].
  static WidgetsBinding? ensureInitialized() {
    if (WidgetsBinding.instance == null) AutoSizeWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }

  @override
  ViewConfiguration createViewConfiguration() {
    final double dpRatio = window.devicePixelRatio;
    bool isTablet;
    bool isPhone;
    bool isIos = Platform.isIOS;
    bool isAndroid = Platform.isAndroid;
    bool isIphoneX = false;
    bool hasNotch = false;

    var size = window.physicalSize / dpRatio;
    var width = size.width;
    var height = size.height;

    if (dpRatio <= 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (dpRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }
    if (AutoSize.getSize().width < size.width && !isTablet) {
      AutoSizeConfig.setDesignWH(width: size.width);
    } else if (size.width > 600 || isTablet) {
      AutoSizeConfig.setDesignWH(width: 600);
    }
    // if (isTablet) {
    //   AutoSizeConfig.setDesignWH(width: 600);
    // }

    if (size == Size.zero) {
      return super.createViewConfiguration();
    }
    //if (!ScreenUtil.isGetPixelRatio) {
      ScreenUtil.screenSize = AutoSize.getSize();
      ScreenUtil.pixelRatio = AutoSize.getPixelRatio();
      ScreenUtil.autoSizeRatio = dpRatio / ScreenUtil.pixelRatio;
      ScreenUtil.heightTopSafeArea = window.padding.top / AutoSize.getPixelRatio();
      ScreenUtil.heightBottomSafeArea = window.padding.bottom / AutoSize.getPixelRatio();
      //ScreenUtil.isGetPixelRatio = true;
    //}

    return ViewConfiguration(
      size: ScreenUtil.screenSize ?? size,
      devicePixelRatio: ScreenUtil.pixelRatio,
    );

    // return ViewConfiguration(
    //   size: size,
    //   devicePixelRatio: dpRatio,
    // );
  }

  @override
  void initInstances() {
    super.initInstances();
    window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    // We convert pointer data to logical pixels so that e.g. the touch slop can be
    // defined in a device-independent manner.
    _pendingPointerEvents.addAll(PointerEventConverter.expand(packet.data, AutoSize.getPixelRatio()));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    super.cancelPointer(pointer);
    if (_pendingPointerEvents.isEmpty && !locked) scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty) {
      _handlePointerEvent(_pendingPointerEvents.removeFirst());
    }
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  void _handlePointerEvent(PointerEvent event) {
    assert(!locked);
    HitTestResult? result;
    if (event is PointerDownEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      result = HitTestResult();
      hitTest(result, event.position);
      _hitTests[event.pointer] = result;
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $result');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      result = _hitTests.remove(event.pointer);
    } else if (event.down) {
      result = _hitTests[event.pointer];
    } else {
      return; // We currently ignore add, remove, and hover move events.
    }
    if (result == null) return;
    dispatchEvent(event, result);
  }
}
