

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'DrawerHome.dart';
import 'UserModel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}

Future<UserModel> createUser(String name, String jobTitle) async{
 final apiUrl = "https://reqres.in/api/users";

  final response = await http.post (apiUrl, body: {
   "name": name,
    "job": jobTitle});

  if(response.statusCode == 201) {
    final String responseString = response.body;
    print(responseString);
    return userModelFromJson(responseString);
  }
  else {
    return null;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  String username;
  String pass;
  UserModel _user;
  bool check = false;
  bool passCheck = true;

  void toggleVisibility() {
   if(passCheck) {
     setState(() {
       passCheck = false;
     });
   }else {
     setState(() {
       passCheck=true;
     });
   }


  }




@override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Color(0xff00BCD1),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Demo'),
        ),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // children: [Container(
                  //   child: Icon(Icons.email,size: 16.00,),
                  // ),

                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/loginIcon.png', height: 150, width: 150,

                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.email, size: 40,),
                        margin: EdgeInsets.only(left: 10),
                      ),
                      Expanded(
                        flex: 1, // 20%
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0),
                            child: TextField(
                              controller: emailController,
                              cursorColor: Colors.amber,
                              style: TextStyle(height: 1.0),
                              cursorWidth: 3.0,
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: Colors.greenAccent, width: 2.0),
                                    borderRadius:
                                    BorderRadius.all(
                                        new Radius.circular(10.0))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                    borderRadius:
                                    BorderRadius.all(
                                        new Radius.circular(10.0))),
                                hintText: 'User Name',
                              ),
                            )),
                      ),
                    ],

                  ),

                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.lock, size: 40,),
                        margin: EdgeInsets.only(left: 10, top: 15),
                      ),
                      Expanded(
                          flex: 1, // 20%
                          child: Container(
                              margin:
                              const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20.0),
                              child: TextField(
                                controller: passController,
                                cursorColor: Colors.amber,
                                style: TextStyle(height: 1.0),
                                cursorWidth: 3.0,
                                decoration: new InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      toggleVisibility();
                                    },
                                    child: Icon(
                                        passCheck ? Icons.visibility_off : Icons.visibility,
                                      color: passCheck ? Colors.black : Colors.amber,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.greenAccent,
                                          width: 2.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          new Radius.circular(10.0))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0),
                                      borderRadius:
                                      BorderRadius.all(
                                          new Radius.circular(10.0))),
                                  hintText: 'Password',
                                ),
                                obscureText: passCheck,
                              ))
                      ),
                    ],
                  ),


                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    color: Colors.red,
                    child: FlatButton(
                      child: Text('Login'),
                      onPressed: () async {
                        username = emailController.text.trim();
                        pass = passController.text.trim();

                        // Route route = MaterialPageRoute(builder: (context) => Home(username,pass));
                        // final UserModel user = await createUser(username, pass);
                        //  print(user.name);
                        // setState(() {
                        //    _user = user;
                        // });

                        if (username == "Shiv" && pass == "Desai") {
                          Route route =
                          MaterialPageRoute(builder: (context) => DrawerHome());
                          Navigator.push(context, route);
                        } else {
                          setState(() {
                            check = true;
                          });
                        }
                      },
                    ),
                  ),
                  check ? Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child:
                    Text('Sorry username or Password is Incorrect',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.red
                      ),),
                  ) : Container()
                ],
              ),
            ))
    );
  }
}
