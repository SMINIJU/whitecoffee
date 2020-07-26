import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get("http://localhost:4000/get");
    data = json.decode(response.body);
    print(data);
    setState(() {
      userData = data["rows"];

    });
    debugPrint(userData.toString());

  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('What is going on ?'),
          backgroundColor: Colors.teal,
        ),
        body: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
               padding: const EdgeInsets.all(16.0),
                child: Row(
                 children: <Widget>[
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${userData[index]["USERID"]} ${userData[index]["USESRNAME"]}",
                        ),


                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
