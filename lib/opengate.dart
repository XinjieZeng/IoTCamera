import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 500, maxWidth: 500);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadPhoto(_image);
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

Future<FormData> uploadPhoto(File image) async {
     String path = image.path;
     var name = path.substring(path.lastIndexOf("/") + 1, path.length);
     var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
           path, 
           filename: name)
      });

    Map<String, dynamic> map = {'fileType': suffix};

    Dio dio = new Dio();
    var response = await dio.post<String> (
      "http://192.168.254.73:5000/opengarage", 
      data: formData,
      queryParameters: map, 
      onSendProgress: (int count, int total) {
        print('-------${count/total}------');
      }
      );

    if (response.statusCode == 200) {
      print(response.data);
      if (response.data == "success") {
        Fluttertoast.showToast(
          msg:'validate sucessfully, garage is opened',
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey
        );
      }
      else {
        Fluttertoast.showToast(
          msg:'validate Fail',
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey
        );
      }
     
      
    }
    
  }
