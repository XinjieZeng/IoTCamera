
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_app/UploadFileInfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hello_app/menu.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AddPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/mainmenu': (_) => new MainMenu(), // main menu
      },

        home: NewFacePage(),
    );
  }
}

class NewFacePage extends StatefulWidget {
  @override
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<NewFacePage> { 
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    
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
      body: Column(
        children: [
          _image == null
            ? Text('No image selected.')
            : Image.file(_image, width: 400.0, height: 500.0, fit: BoxFit.contain,), 
           

          RaisedButton(
            child: Text("submit"),
            textColor: Colors.black87,
            onPressed: () =>
                    uploadPhoto(_image)
                    // Navigator.of(context).pushReplacementNamed("/mainmenu")
            )
        ] 
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
     print(path);
     var name = path.substring(path.lastIndexOf("/") + 1, path.length);
     var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    FormData formData = FormData.fromMap({
          'filetype': suffix, 
          'filename': name, 
          'file': await MultipartFile.fromFile(
           path, 
           filename: name)
      });

    Map<String, dynamic> map = {'fileType': suffix};

    Dio dio = new Dio();
    var response = await dio.post<String> (
      "http://192.168.254.73:5000/addphoto", 
      data: formData,
      queryParameters: map, 
      onSendProgress: (int count, int total) {
        print('-------${count/total}------');
      }
      );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'upload photo sucessful',
        gravity: ToastGravity.CENTER,
        textColor: Colors.grey
      );
    }
    
  }


