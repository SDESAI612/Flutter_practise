import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


Future<Album> fetchAlbum() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Album.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class GetApi extends StatefulWidget{

_GetApi createState() => _GetApi();

}

class _GetApi extends State<GetApi>{
  Future<Album> futureAlbum;
  PersistentTabController _controller;





  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    _controller = PersistentTabController(initialIndex: 0);
  }

  int _index = 0;
  final List<Widget> _children =[];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body :
      Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),

   );
  }


}

