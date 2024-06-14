import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/to_do_model.dart';

class data extends StatefulWidget {
  const data({super.key});

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _users = (data['users'] as List).map((i) => User.fromJson(i)).toList();
    });
  }


    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text('local json data'),
        ),
        body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [

                Card(
                  child: ListTile(
                    title: Text(_users[index].name),
                    subtitle: Column(
                      children: [
                        Text(_users[index].email),
                        Text(_users[index].address),
                      ],
                    ),
                  
                  ),
                ),

              ],
            );
          },
        ),
      );
    }
}
