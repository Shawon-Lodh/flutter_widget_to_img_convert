import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

const PIXEL_RATIO = 72.0;

/// Details About Pixel Ratio - 72
 // from internet it is found that best pixel ratio for image is 72 PPI


class Utils{

  //perfectly okkk
  // 1. Capture screenshot  of any widget by passing as parameter
  static Future<Uint8List?> captureScreenSortOfAnyWidget(BuildContext context,{required Widget childContent, bool saveImageToGalleryStatus = false}) async {
    Uint8List? screenshot;
    if (childContent != null) {
      ScreenshotController screenshotController = ScreenshotController();
      screenshotController
          .captureFromWidget(
        InheritedTheme.captureAll(
            context, Material(child: childContent)),
        // delay: const Duration(seconds: 1),
        pixelRatio: PIXEL_RATIO,)
          .then((capturedImage) {
        if (saveImageToGalleryStatus && capturedImage != null) {
          screenshot = capturedImage;
          saveImageToGallery(capturedImage);
        }
      }).catchError((onError) {
        print(onError);
      });
    }
    return screenshot;
  }

  // 2. Capture screenshot of the widget which is controlled by the screenshot controller(background black)
  static Future<Uint8List?> captureScreenSortOfSpecificWidget(ScreenshotController? screenshotController) async {
    Uint8List? screenshot;
    if (screenshotController != null) {
      screenshotController
          .capture(
        // delay: const Duration(milliseconds: 10),
        pixelRatio: PIXEL_RATIO,)
          .then((capturedImage) async {
        saveImageToGallery(capturedImage!);
      }).catchError((onError) {
        print(onError);
      });
    }
    return screenshot;
  }


  /// image saving functionality
  static Future<String?> saveImageToLocalPath(Uint8List image, String? imageName) async {
    _createLocalPath(imageName: imageName).then((fullPath) async {
      File file = File(fullPath);
      await file.writeAsBytes(image);
      print(file.path);
      return file.path;
    });
  }

  static saveImageToGallery(Uint8List image) async {
    final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }

  static Future<String> _createLocalPath({String? imageName = 'sample.png'}) async{
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fullPath = '$dir/${imageName!}';
    print("local file full path ${fullPath}");
    return fullPath;
  }
}