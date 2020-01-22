import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/auth/bloc/auth_bloc.dart';
import 'package:socialmedia/auth/bloc/auth_event.dart';
import 'package:socialmedia/common/widgets/header.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Timeline",
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              // Future.delayed(const Duration(seconds: 1))
              //     .then((_) => throw Exception());
            },
            child: const Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: usersRef.snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data.documents.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           final item = snapshot.data.documents[index];
      //           return ListTile(
      //             title: Text(item.data['username']),
      //           );
      //         },
      //       );
      //     } else {
      //       return LinearProgress();
      //     }
      //   },
      // ),
    );
  }
}
