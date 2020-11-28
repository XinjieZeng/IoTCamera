import 'package:flutter/material.dart';
import 'package:hello_app/addphoto.dart';
import 'package:hello_app/opengate.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Container(
              margin: const EdgeInsets.only(top: 80.0),
              child:
              RawMaterialButton(
              onPressed: () {
                 Navigator.push(context, 
                 MaterialPageRoute(builder: (context) => AddPhoto()),
                 );
              },
              elevation: 2.0,
             
                child: 
                Icon(
                  Icons.add_a_photo_rounded,
                  color: Colors.blue,
                  size: 80.0,
                  ),
                  padding: EdgeInsets.all(35.0),
                ),
            ),
            
              Container(
                margin: const EdgeInsets.only(top: 80.0),
                child:
              RawMaterialButton(
              onPressed: () {
                Navigator.push(context, 
                 MaterialPageRoute(builder: (context) => (OpenGate())),
                 );
              },
              elevation: 2.0,
          
                child: 
                Icon(
                  Icons.lock_open_rounded,
                  color: Colors.blue,
                  size: 80.0,
                  ),
                  padding: EdgeInsets.all(35.0),
                ),
            ),
        ],
        ),
      ),
      
    );
  }
}