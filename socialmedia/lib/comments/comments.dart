import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/comments/bloc/comments_bloc.dart';
import 'package:socialmedia/common/blocs/auth/auth_bloc.dart';
import 'package:socialmedia/common/model/comment.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/repo/firestore_repo.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatelessWidget {
  final Post post;
  final TextEditingController _controller;

  Comments({Key key, this.post})
      : _controller = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsBloc>(
      create: (context) =>
          CommentsBloc(firestoreRepo: RepositoryProvider.of<FirestoreRepo>(context))
            ..add(LoadComments(postId: post.postId)),
      child: Scaffold(
        appBar: const Header(
          title: "Comments",
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: buildComments(),
            ),
            const Divider(),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration.collapsed(hintText: 'Write a comment...'),
                      ),
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide.none,
                    onPressed: () {
                      addcomment(context);
                    },
                    child: Text("Post", style: TextStyle(color: Theme.of(context).accentColor)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addcomment(BuildContext context) {
    final User user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    BlocProvider.of<CommentsBloc>(context)
        .add(AddComment(post: post, user: user, comment: _controller.text));
    _controller.clear();
  }

  Widget buildComments() {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading) {
          return const CircularProgress();
        }
        if (state is CommentsLoadError) {
          return Center(child: Text(state.error));
        }

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final Comment comment = (state as CommentsRecieved).comments[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(comment.avatarUrl),
              ),
              title: Text(comment.comment),
              subtitle: Text(timeago.format(comment.timestamp.toDate())),
            );
          },
          itemCount: (state as CommentsRecieved).comments.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      },
    );
  }
}
