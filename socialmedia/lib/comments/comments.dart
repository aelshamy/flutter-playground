import 'package:flutter/material.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/widgets/header.dart';

class Comments extends StatelessWidget {
  final Post post;
  final TextEditingController _controller;

  Comments({Key key, this.post})
      : _controller = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Comments",
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildComments(),
          ),
          Divider(),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration.collapsed(hintText: 'Write a comment...'),
                    ),
                  ),
                ),
                OutlineButton(
                  borderSide: BorderSide.none,
                  onPressed: addcomment,
                  child: Text("Post"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void addcomment() {
    // commentsRef.document(post.postId).collection("comments").add({
    //   "username": currentUser.username,
    //   "userId": currentUser.id,
    //   "avatarUrl": currentUser.photoUrl,
    //   "comment": _controller.text,
    //   "timestamp": DateTime.now()
    // });
    _controller.clear();
  }

  Widget buildComments() {
    return null;
    // return StreamBuilder(
    //   stream: commentsRef
    //       .document(post.postId)
    //       .collection('comments')
    //       .orderBy("timestamp", descending: false)
    //       .snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (!snapshot.hasData) {
    //       return CircularProgress();
    //     }
    //     return ListView.separated(
    //       itemBuilder: (BuildContext context, int index) {
    //         Comment comment = Comment.fromDocument(snapshot.data.documents[index]);
    //         return ListTile(
    //           leading: CircleAvatar(
    //             backgroundImage: CachedNetworkImageProvider(comment.avatarUrl),
    //           ),
    //           title: Text(comment.comment),
    //           subtitle: Text(timeago.format(comment.timestamp.toDate())),
    //         );
    //       },
    //       itemCount: snapshot.data.documents.length,
    //       separatorBuilder: (BuildContext context, int index) => Divider(),
    //     );
    //   },
    // );
  }
}
