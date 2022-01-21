import 'package:flutter/material.dart';
import 'package:flutter_widget_to_img_convert/utils.dart';
import 'package:screenshot/screenshot.dart';


class ConversionScreenPage extends StatefulWidget {
  ConversionScreenPage({Key? key}) : super(key: key);

  @override
  _ConversionScreenPageState createState() => _ConversionScreenPageState();
}

class _ConversionScreenPageState extends State<ConversionScreenPage> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temporary"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Animal",style: TextStyle(color: Colors.red),),
                  Text("Animal Description", style: TextStyle(color: Colors.red),),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: const Text(
                'Capture Above Widget',
              ),
              onPressed: () {
                Utils.captureScreenSortOfSpecificWidget(screenshotController);
              },
            ),
            ElevatedButton(
              child: const Text(
                'Capture An Invisible Widget',
              ),
              onPressed: () {
                var container = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Animal"),
                    Text("Animal Description"),
                  ],
                );

                Utils.captureScreenSortOfAnyWidget(context, childContent: container,saveImageToGalleryStatus: true);

              },
            ),
          ],
        ),
      ),
    );
  }

}