import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class user1 extends StatefulWidget {
  @override
  _user1State createState() => _user1State();
}

class _user1State extends State<user1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  title: Center(child: Text("Nasir Telecom")),
                  bottom: TabBar(tabs: [
                    Tab(
                        child: Text("Bkash",
                            style: TextStyle(
                              fontSize: 13.0,
                            ))),
                    Tab(
                        child: Text("Topup",
                            style: TextStyle(
                              fontSize: 13.0,
                            ))),
                    Tab(
                      child: Text("Requests",
                          style: TextStyle(
                            fontSize: 13.0,
                          )),
                    ),
                    Tab(
                        child: Text("Pin",
                            style: TextStyle(
                              fontSize: 13.0,
                            ))),
                  ]),
                ),
                drawer: Drawer(
                  elevation: 10.0,
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName:
                            Center(child: Text("${user?.displayName}")),
                        accountEmail: Center(child: Text("${user?.email}")),
                      )
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  Center(child: Text("Bkash Request")),
                  Center(child: Text("Topup Request")),
                  Homeuser(),
                  Profile(),
                ]))));
  }
}

class Homeuser extends StatefulWidget {
  @override
  _HomeuserState createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("All requests")),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _pin = TextEditingController();
  final _newpin = TextEditingController();
  final _repin = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser;
    setState(() {});
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
                "${user?.displayName}",
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
                //Padding(padding: EdgeInsets.only(top: 10.0)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      validator: (input) =>
                          input.isNotEmpty ? null : "Please enter previous pin",
                      //onSaved: (input)=> _email=input,
                      controller: _pin,
                      decoration: InputDecoration(
                        labelText: "Old Pin",
                        fillColor: Colors.white,
                        hintText: "Enter your pin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      )),
                ),
                //Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0,right: 10.0)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      validator: (input) =>
                          input.isNotEmpty ? null : "Please enter a password",
                      obscureText: true,
                      //onSaved: (input)=> _password=input,
                      controller: _newpin,
                      decoration: InputDecoration(
                        labelText: "New Pin",
                        fillColor: Colors.white,
                        hintText: "Enter new pin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      )),
                ),
                // Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0,right: 10.0)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      validator: (input) =>
                          input.isNotEmpty ? null : "Please enter a password",
                      obscureText: true,
                      //onSaved: (input)=> _password=input,
                      controller: _repin,
                      decoration: InputDecoration(
                        labelText: "New Pin",
                        fillColor: Colors.white,
                        hintText: "Re-enter new pin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      )),
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
                      onPressed: () {
                        changepin();
                      }),
                ),
              ],
            )),
      ],
    ));
  }

  void changepin() {}
}
