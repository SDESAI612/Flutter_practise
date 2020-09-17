import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'ListViewModel.dart';

class ListViewFromApi extends StatefulWidget {
  _ListViewFromApi createState() => _ListViewFromApi();
}

class _ListViewFromApi extends State<ListViewFromApi> {

  List<ListViewModel> user;
  var subscription;
  bool _saving = false;


  Future<void> _getUser() async {
    print("Get Function");
    String apiUrl = "https://api.github.com/search/users?q=repos:%3E12+followers:%3C1000&location:uk+language:python&page=1&per_page=100";
     var data = await http.get(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      },
    );

    // List<dynamic> _list = json.decode(response.body) as List;
    //
    // print(_list);

     Map<String, dynamic> map = json.decode(data.body);

     var keys= map.keys.toList();
     List<dynamic> val = map[keys[2]] as List;


    setState(() {
      user = val.map((e) => ListViewModel.fromJson(e)).toList();
     // print(user.length);
    });
    //
    //  if(map.containsKey("items")){
    //    List<ListViewModel> _list = map.values;

    // for(var a in _list){
    //   print(a.login);
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<Null> _refreshList() async{
    await Future.delayed(Duration(seconds: 2));

    if(check==true){
      user = null;
      return null;
    }
    else {
      setState(() {
        _getUser();

      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshList,
       child: user == null ? Container() : ListView.builder(
         itemCount: user.length,
         itemBuilder: (context,index){
           ListViewModel  item = user[index];
           return Dismissible(
             key: Key(item.login) ,
               onDismissed: (direction) {
                 setState(() {
                   user.removeAt(index);
                 });
               },
             child: Container(
               color: Colors.blue,
               margin: EdgeInsets.only(bottom: 10.0),
               padding: EdgeInsets.only( bottom: 5.0, top: 5.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Container(
                   margin: const EdgeInsets.only(left: 8.00),
                     child: CircleAvatar(
                       radius: 55,
                       backgroundColor: Color(0xffFDCF09),
                       child: CircleAvatar(
                         radius: 50,
                         backgroundImage: NetworkImage(item.avatarUrl),
                       ),
                     ),
                   ),
                   Flexible(
                   child: SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Column(
                     children: [
                       Container(
                         margin: const EdgeInsets.only(left: 16.00),
                         child: Align(
                             alignment: Alignment.centerLeft,
                             child: Text("${item.avatarUrl}")
                         )
                     ),
                       Container(
                           margin: const EdgeInsets.only(left: 16.00),
                           child: Align(

                               alignment: Alignment.centerRight,
                               child: Text("${item.login}")
                           )
                       )],
                   ))
                   ) ],
               )
             )
           );
         }),
     ),
    );
  }

  @override
  void initState() {
    super.initState();
    subscription =  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if(result == ConnectivityResult.none) {
      print("not ");
    }else {
      print("Connection is back");
     WidgetsBinding.instance.addPostFrameCallback((_) => _getUser());
    //   _getUser();
    }
    });

   // _getUser();
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }
}

