
import 'dart:collection';

import 'package:flutter/material.dart';

class Home extends StatelessWidget{

  String username;
  String pass;
  Person person;

  Home(this.username,this.pass){
    print(username);
    print(pass);
  }

   List<Person> choice = const <Person>[
    const Person(key: 1, name: 'Shiv', age: 22),
    const Person(key: 2, name: 'Raj', age: 25),
    const Person(key: 3, name: 'Rahul', age: 25),
    const Person(key: 4, name: 'Adi', age: 32),
    const Person(key: 5, name: 'Sid', age: 28),
    const Person(key: 6, name: 'Rohan', age: 29),
    const Person(key: 7, name: 'Tejas', age: 20),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: ListView.builder(
          itemCount: choice.length,
          itemBuilder: (context,index){
            Person  item = choice[index];
            return Container(
                color: Colors.blue,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only( bottom: 5.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xffFDCF09),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/m.png'),
                        ),
                      ),
                    ),
                  Column(
                    children: [Container(
                        margin: const EdgeInsets.only(left: 16.00),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${item.name}")

                        )
                    ),
                      Container(
                          margin: const EdgeInsets.only(left: 16.00),
                          child: Align(

                              alignment: Alignment.centerRight,
                              child: Text("${item.age}")
                          )
                      )],
                  )
                ],
              )

            );
      }),

    );
  }

}

class Person{
  const Person({this.key, this.name, this.age });
  final String name;
  final int age;
  final int key;
}