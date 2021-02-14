import 'package:flutter/material.dart';

class DirectionalityExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directionality Examples'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: TextFormField(
              textAlign: TextAlign.right,
              //  controller: _textEdittingControler_bookName,
              // autofocus: tr  ue,
              decoration: InputDecoration(labelText: "عنوان الكتاب", hintText: "اذكر عنوان الكتاب الذي تريده"),
            ),
          ),
        ),
      ),
    );
  }
}
