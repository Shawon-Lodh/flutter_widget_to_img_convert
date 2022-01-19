import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_widget_to_img_convert/utils.dart';
import 'package:flutter_widget_to_img_convert/widget_to_image.dart';

class ConversionScreenPage extends StatefulWidget {
  const ConversionScreenPage({Key? key}) : super(key: key);

  @override
  State<ConversionScreenPage> createState() => _ConversionScreenPageState();
}

class _ConversionScreenPageState extends State<ConversionScreenPage> {
  GlobalKey? key1, key2;
  Uint8List? bytes1,bytes2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convert Widget to Image"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Widgets",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, i) {
              if (i == 0) {
                return WidgetToImage(
                  builder: (key) {
                    key1 = key;
                    return ListTile(
                      leading: Image.network(
                          "https://media-eng.dhakatribune.com/uploads/2018/05/photo-moheen-reeyad-1526713172729.gif"),
                      title: const Text("Animal"),
                      subtitle: const Text("Animal Description"),
                    );
                  },
                );
              } else {
                return WidgetToImage(
                  builder: (key) {
                    key2 = key;
                    return ListTile(
                      leading: Image.network(
                          "https://media-eng.dhakatribune.com/uploads/2018/05/photo-moheen-reeyad-1526713172729.gif"),
                      title: const Text("Animal"),
                      subtitle: const Text("Animal Description"),
                    );
                  },
                );
              }
            },
          ),
          Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Images",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
          Expanded(
            child: bytes1!=null ? Image.memory(bytes1!) : Container(),
          ),
          Expanded(
            child: bytes1!=null ? Image.memory(bytes2!) : Container(),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async{
                  final tempBytes1 = await Utils.capture(key1);
                  final tempBytes2 = await Utils.capture(key2);

                  setState(() {
                    bytes1 = tempBytes1;
                    bytes2 = tempBytes2;
                  });
                },
                child: const Text(
                  "Convert to Image",
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () async{
                  Utils.createFileFromString(bytes1!,"widget1.png").then((path){
                    print("Image1 path : $path");
                  });
                  Utils.createFileFromString(bytes2!,"widget2.png").then((path){
                    print("Image2 path : $path");
                  });
                },
                child: const Text(
                  "Save to Gallery",
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      ],
    );
  }
}
