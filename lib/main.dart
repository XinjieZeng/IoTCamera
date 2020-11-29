import 'package:flutter/material.dart';
import 'package:hello_app/menu.dart';
import 'package:hello_app/Login.dart';
import 'package:hello_app/postLogin.dart';
import 'package:http/http.dart' as http;

void main() async {
    runApp(MyApp());
  }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyLoginForm(),
    );
  }
}

class MyLoginForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}


class _MyCustomFormState extends State<MyLoginForm> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Future<String> _futureLogin; 

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return MaterialApp(
  
      title: 'Flutter demo',
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
          child:  (_futureLogin == null) 
            ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                 "User Login",
                 style: TextStyle(
                   color: Colors.black54,
                   fontWeight: FontWeight.w800,
                   fontFamily:'Roboto',
                   letterSpacing:0.5,
                   fontSize: 30.0,
                 ),
                 ),
                 Icon(
                    Icons.login, 
                    color: Colors.black54,
                    size:40.0,
                 ),
               
               Padding(
                 padding: const EdgeInsets.only(top: 50.0),
               ),

               TextField(
                 decoration: const InputDecoration(
                   labelText: "Username",
                   labelStyle: TextStyle(
                     fontSize: 20.0
                   )
                 ),
                 controller: usernameController
               ),
                
               TextFormField(
                 decoration: const InputDecoration(
                   labelText: "password",
                   labelStyle: TextStyle(
                     fontSize: 20.0
                   )
                 ),
                 controller: passwordController,
               ),
               
              Padding(
                 padding: const EdgeInsets.only(top: 30.0),
               ),


               RaisedButton(
                 child: const Text(  
                    "Login in", style: TextStyle(fontSize: 20)
                    ),
                  textColor: Colors.white54,
                  padding: const EdgeInsets.all(3.0),
                  color: Colors.black45,

                  onPressed: () {
                    setState(() {
                          _futureLogin = createLogin(usernameController.text, passwordController.text);
                        
                        });

                    return showDialog(context: context, 
                    builder: (context) {
                      return AlertDialog(
                        content: Text(usernameController.text + passwordController.text),
                     ); 
                    });
                  },
                  
               ),
            ]
          )

          : FutureBuilder<String>(
                  future: _futureLogin,
                  builder: (context, snapshot) {
                    
                    if (snapshot.hasData) {
                      return Text("successful logged in");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
        ),










        
      ),
    );
  }
  } 

  
   

