import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

class Utils{
  static Future capture(GlobalKey? key) async {
    if(key == null) {
      return null;
    } else{
      RenderRepaintBoundary? boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      final image = await boundary!.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    }
  }

  static Future<String> createFileFromString(Uint8List bytes, String? imageName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = '$dir/${imageName!}';
    print("local file full path ${fullPath}");
    File file = File(fullPath);
    await file.writeAsBytes(bytes);
    print(file.path);
    final result = await ImageGallerySaver.saveImage(bytes);
    print(result);
    return file.path;
  }
}