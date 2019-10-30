import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flutter_plugin_lagi.dart';

class ImageListController {
  ImageListController._(this.channel,
      this._imageListState,) : assert(channel != null) {
    channel.setMethodCallHandler(_handleMethodCall);
  }

  static Future<ImageListController> init(int id,
      ImageListState imageListState,) async {
    assert(id != null);
    final MethodChannel channel = MethodChannel('plugins.flutter.io/flutter_plugin_lagi/$id');
    // TODO(amirh): remove this on when the invokeMethod update makes it to stable Flutter.
    // https://github.com/flutter/flutter/issues/26431
    // ignore: strong_mode_implicit_dynamic_method
//    await channel.invokeMethod('waitForList');
//    channel.setMethodCallHandler(_handleMethodCall);
    return ImageListController._(
      channel,
      imageListState,
    );
  }

  @visibleForTesting
  final MethodChannel channel;

  final ImageListState _imageListState;

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onClick":
        print("call.arguments => ${call.arguments}");
//      case 'onImageTapped':
//        int count = call.arguments['count'] as int;
//        _imageListState.onImageTapped(count ?? 0);
        break;
      default:
        throw MissingPluginException();
    }
  }

  void setText(String s) {
    channel.invokeMethod("setText", {"text": s});
  }
}