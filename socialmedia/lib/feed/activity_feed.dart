import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/model/feed.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/feed/bloc/bloc.dart';
import 'package:socialmedia/profile/post_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: "Activity Feed"),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedInitialState) {
            return const CircularProgress();
          }
          if (state is FeedLoadError) {
            return Center(child: Text(state.error));
          }

          final feeds = (state as FeedRecieved).feeds;

          return ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: feeds.length,
            itemBuilder: (BuildContext context, int index) {
              final Feed feed = feeds[index];
              return ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                leading: CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: feed.userProfileImage,
                  ),
                ),
                title: _getFeedTitle(feed),
                trailing: (feed.type == FeedType.comment || feed.type == FeedType.like)
                    ? GestureDetector(
                        onTap: () => _goToPost(context),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(feed.mediaUrl),
                            ),
                          ),
                        ),
                      )
                    : null,
                subtitle: Text(
                  timeago.format(feed.timestamp.toDate()),
                  style: const TextStyle(height: 1.5),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        },
      ),
    );
  }

  void _goToPost(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const PostPage(),
        settings: const RouteSettings(name: "PostPage"),
      ),
    );
  }

  Text _getFeedTitle(Feed feed) {
    String activityItemText = '';
    if (feed.type == FeedType.comment) {
      activityItemText = " commented on your post: ${feed.commentData}";
    } else if (feed.type == FeedType.like) {
      activityItemText = " like your post";
    } else if (feed.type == FeedType.follow) {
      activityItemText = " is following you";
    } else {
      activityItemText = "Error: Unkown type ${feed.type}";
    }
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "${feed.username}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          TextSpan(text: "$activityItemText"),
        ],
      ),
      style: const TextStyle(height: 1.3),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
