import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/pages/home.dart';
import 'package:socialmedia/widgets/header.dart';
import 'package:socialmedia/widgets/progress.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                final item = snapshot.data.documents[index];
                return ListTile(
                  title: Text(item.data['username']),
                );
              },
            );
          } else {
            return LinearProgress();
          }
        },
      ),
    );
  }
}
