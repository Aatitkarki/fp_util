import 'dart:ui';

import 'package:flutter/material.dart';

/// @template
/// Size utils for responsiveness
/// @end-template
class SizeUtils {
  /// @macro size_utils
  SizeUtils._() {
    final view = PlatformDispatcher.instance.views.first;
    _size = view.physicalSize / view.devicePixelRatio;
    final statusBar = MediaQueryData.fromView(view).viewPadding.top;
    final bottomBar = MediaQueryData.fromView(view).viewPadding.bottom;
    _width = _size.width;
    _height = _size.height - statusBar - bottomBar;
    _initialized = true;
  }

  static SizeUtils get instance => SizeUtils._();

  ///scale width
  late double _scaleWidth;

  ///scale height
  late double _scaleHeight;

  ///text scale factor
  late double _textScaleFactor;

  /// default figma size
  Size _designSize = const Size(375, 812);

  /// must call this if your figma design is different
  void init({
    required BoxConstraints constraints,
    Size? designSize,
  }) {
    designSize ??= _designSize;
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;
    _scaleWidth = width / designSize.width;
    _scaleHeight = height / designSize.height;
    _textScaleFactor = _scaleWidth;
  }

  /// size
  late Size _size;

  /// flag for initalized or not
  bool _initialized = false;

  /// height of screen
  late double _height;

  /// width of screen
  late double _width;

  /// responsize width
  double get width {
    if (!_initialized) throw Exception('SizeUtils not initialized.');
    return _width;
  }

  /// responsive height
  double get height {
    if (!_initialized) throw Exception('SizeUtils not initialized.');
    return _height;
  }

  /// set responsive with
  double setWidth(double px) {
    if (!_initialized) throw Exception('SizeUtils not initialized.');
    return (px * _width) / _designSize.width;
  }

  /// set responsive height
  double setHeight(double px) {
    if (!_initialized) throw Exception('SizeUtils not initialized.');
    return (px * _height) / (_designSize.height - 44);
  }

  double setSp(num sp) => sp * _textScaleFactor;

  /// get responsive size
  double getSize(double px) {
    if (!_initialized) throw Exception('SizeUtils not initialized.');
    final height = setHeight(px);
    final width = setWidth(px);
    if (height < width) {
      return height;
    } else {
      return width;
    }
  }
}
