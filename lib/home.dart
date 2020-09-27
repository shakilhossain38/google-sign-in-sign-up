import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Center(child: Text("Nasir Telecom")),
                bottom: TabBar(tabs: [

                  Tab(child: Text("Requests", style: TextStyle(
                    fontSize: 13.0,))),
                  Tab(child: Text("Sign Up", style: TextStyle(
                    fontSize: 13.0,))),
                  Tab(child: Text("Settings", style: TextStyle(
                    fontSize: 13.0,))),

                ]),
              ),
              drawer: Drawer(
                elevation: 10.0,
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(accountName: Center(child: Text("Nasir")),
                      accountEmail: Center(child: Text("${user?.email}")),)
                  ],
                ),
              ),
              body: TabBarView(children: [
                Center(child: Text("All Requests")),
                Home(),
                Profile2(),
              ]),

        )),


    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {

    });
  }

  //String _email, _password, _name;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[
        Form(
            key: _formkey,
            child: Column(


              children: <Widget>[
              //  Padding(padding: EdgeInsets.only(top: 10.0)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      validator: (input) =>
                      input.isNotEmpty ? null : "Please enter display name"
                      ,
                      controller: _name,
                      //onSaved: (input) => _name = input,
                      decoration: InputDecoration(
                        labelText: "Name",
                        fillColor: Colors.white,
                        hintText: "Enter name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),

                      )

                  ),
                ),
                //Padding(padding: EdgeInsets.only(top: 10.0)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      validator: (input) =>
                      input.isNotEmpty ? null : "Please enter an email"
                      ,

                      controller: _email,
                      //onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        hintText: "Enter email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),

                      )

                  ),
                ),
               // Padding(padding: EdgeInsets.only(top: 10.0)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      validator: (input) =>
                      input.isNotEmpty ? null : "Please enter a password"
                      ,
                      controller: _password,
                      obscureText: true,
                      //onSaved: (input) => _password = input,
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),


                      )

                  ),
                ),

                Center(
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.black)),
                      child: Text("Create Account"),
                      color: Colors.green,
                      textColor: Colors.white,
                      splashColor: Colors.blueAccent,

                      onPressed: () {
                        signup();
                      }),
                ),


              ],
            )),
      ]

    );
  }


  void signup() async {
    if (_formkey.currentState.validate()) {
      try {
        User user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email.text, password: _password.text))
            .user;

        var userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = _name.text;
        await user.updateProfile(userUpdateInfo);
        await user.reload();
        print(_name);


        //Navigator.of(context).pop();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
        Fluttertoast.showToast(
            msg: "Account created!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0);
      } catch (e) {
        print(e.message);

        Fluttertoast.showToast(
            msg: "Wrong Email!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      }
      _name.clear();
      _password.clear();
      _email.clear();
    }
  }
}

class Profile2 extends StatefulWidget {
  @override
  _Profile2State createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  final _pin= TextEditingController();
  final _newpin= TextEditingController();
  final _repin= TextEditingController();
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  final FirebaseAuth _auth= FirebaseAuth.instance;
  FirebaseUser user;
  @override
  void initState(){
    super.initState();
    initUser();
  }
  initUser() async{
    user= await _auth.currentUser;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100.0,
              width: 100.0,
              color: Colors.blueGrey,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Center(
                      child: Text(
                        "Nasir",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.0),
                      )),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Center(child: Text("${user?.email}",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15.0),)),
                ],
              ),
            ),

            Form(
                key: _formkey,
                child: Column(


                  children: <Widget>[
                    //Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0,right: 10.0)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          validator: (input)=>
                          input.isNotEmpty?null: "Please enter previous pin"
                          ,
                          //onSaved: (input)=> _email=input,
                          controller: _pin,
                          decoration: InputDecoration(
                            labelText: "Pin",
                            fillColor: Colors.white,
                            hintText: "Enter your pin",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                            ),

                          )

                      ),
                    ),
                    //Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0,right:10.0)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          validator: (input)=>
                          input.isNotEmpty?null: "Please enter a password"
                          ,
                          obscureText: true,
                          //onSaved: (input)=> _password=input,
                          controller: _newpin,
                          decoration: InputDecoration(
                            labelText: "New Pin",
                            fillColor: Colors.white,
                            hintText: "Enter new pin",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                            ),


                          )

                      ),
                    ),
                    //Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0,right: 10.0)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          validator: (input)=>
                          input.isNotEmpty?null: "Please enter a password"
                          ,
                          obscureText: true,
                          //onSaved: (input)=> _password=input,
                          controller: _repin,
                          decoration: InputDecoration(
                            labelText: "New Pin",
                            fillColor: Colors.white,
                            hintText: "Re-enter new pin",
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
                          child: Text("Change Pin"),
                          color: Colors.green,
                          textColor: Colors.white,

                          splashColor: Colors.blueAccent,

                          onPressed: (){
                            changepin();
                          }),
                    ),



                  ],
                )),
          ],
        )
    );
  }

  void changepin() {

  }
}

