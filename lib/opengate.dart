import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class OpenGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: OpenGatePage(),
    );
  }
}

class OpenGatePage extends StatefulWidget {
  @override
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OpenGatePage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}