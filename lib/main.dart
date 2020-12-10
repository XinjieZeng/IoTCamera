import 'package:flutter/material.dart';
import 'package:hello_app/menu.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() => runApp(new MyApp());

// Main Application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Example',
      home:  MyCustomForm(), 
      // Routes
      routes: <String, WidgetBuilder>{ 
        '/mainmenu': (_) => new MainMenu(), // Home Page
      },
    );
  }
}

class MyCustomForm extends StatefulWidget{
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
// The login page
  
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

 @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
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

            TextField(
                 controller: usernameController,
                 decoration: const InputDecoration(
                   labelText: "Username",
                   labelStyle: TextStyle(
                     fontSize: 20.0
                   )
                 ),
               
               ),
                
            TextFormField(
                 controller: passwordController,
                 decoration: const InputDecoration(
                   labelText: "password",
                   labelStyle: TextStyle(
                     fontSize: 20.0
                   )
                 ),
                 obscureText: true,
               ),
            // The button on pressed, logs-in the user to and shows Home Page
            new RaisedButton(
                child: new Text('login'),
                onPressed: () =>
                  postLogin(usernameController.text, passwordController.text, context),
                    // Navigator.of(context).pushReplacementNamed("/mainmenu"),
            ),
          ],

          
        ),
      ),
    );
  }


}



// postLogin(username, password) async{
//    var params = Map<String, String> ();
//    params["username"] = username;
//    params["password"] = password;
//     var client = http.Client();
//     var response = await client.post('http://192.168.254.73:5000/login', body: params);
//     print(response.body);
//     // _content = response.body;
    
// }

void postLogin(username, password, context) async {
    FormData formData = FormData.fromMap({
          'username': username, 
          'password': password,
      });

    Dio dio = new Dio();
    var response = await dio.post<String> (
      "http://192.168.254.73:5000/login", 
      data: formData,
      );

    if (response.statusCode == 200) {
      if(response.data == "success") {
         print("successful log in");
         Navigator.of(context).pushReplacementNamed("/mainmenu");
      }
      else {
          Fluttertoast.showToast(
            msg: 'Login failed',
            gravity: ToastGravity.CENTER,
            textColor: Colors.grey
          );
      }
    
    }
    
  }






