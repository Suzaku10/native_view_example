import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_lagi/controller.dart';


typedef void OnListCreated(ImageListController controller);

class ImageList extends StatefulWidget {
  final String albumId;
  final OnListCreated onListCreated;

  ImageList({this.albumId, this.onListCreated});

  @override
  ImageListState createState() => ImageListState();
}

class ImageListState extends State<ImageList> {
  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      "albumId": widget.albumId ?? ""
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.flutter.io/flutter_plugin_lagi',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'plugins.flutter.io/flutter_plugin_lagi',
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
  }

  Future<void> onPlatformViewCreated(int id) async {
    print("onPlatformViewCreated $id");
    final ImageListController controller = await ImageListController.init(
      id,
      this,
    );
//
    if (widget.onListCreated != null) {
      widget.onListCreated(controller);
    }
  }
}
