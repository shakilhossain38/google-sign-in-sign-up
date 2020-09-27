import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nasir_telecom_2/homeuser.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nasir Telecom",
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: Login(),

    );
  }
}
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //String _email, _password;
  final _email= TextEditingController();
  final _password= TextEditingController();
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text("Sign In")),
        backgroundColor: Colors.teal,
      ),
      body: Form(
          key: _formkey,
          child: Column(


        children: <Widget>[
          //Padding(padding: EdgeInsets.only(top: 10.0)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              validator: (input)=>
                input.isNotEmpty?null: "Please enter an username"
              ,
              //onSaved: (input)=> _email=input,
                controller: _email,
              decoration: InputDecoration(
                labelText: "Email",
                fillColor: Colors.white,
                hintText: "Enter email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
              ),

            )

            ),
          ),
          //Padding(padding: EdgeInsets.only(top: 10.0)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
                validator: (input)=>
                input.isNotEmpty?null: "Please enter a password"
                ,
                obscureText: true,
               //onSaved: (input)=> _password=input,
                controller: _password,
                decoration: InputDecoration(
                  labelText: "Password",
                  fillColor: Colors.white,
                  hintText: "Enter Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                  ),


                )

            ),
          ),
          
          Center(
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black)),
                child: Text("Sigin"),
                color: Colors.green,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,

                onPressed: (){
                  signin();
                }),
          ),

          
          
          
          
        ],
      )),

    );
  }



  void signin() async {
    if(_formkey.currentState.validate()){
      try{
        if(_email.text=="nasirkhan74696@gmail.com"){

          final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text)).user;
         Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
        }
        else{
          final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text)).user;
          Navigator.push(context, MaterialPageRoute(builder: (context) => user1()));
        }

       Fluttertoast.showToast(
           msg: "Login Successful!",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,
           backgroundColor: Colors.green,
           textColor: Colors.black,
           fontSize: 16.0);
        _email.clear();
        _password.clear();
      }catch(e){
        print(e.message);
        Fluttertoast.showToast(
            msg: "Wrong email/password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    }
  }
}

