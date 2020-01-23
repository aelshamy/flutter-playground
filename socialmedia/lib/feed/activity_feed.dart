import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/model/feed.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/feed/bloc/bloc.dart';
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
            itemCount: feeds.length,
            itemBuilder: (BuildContext context, int index) {
              final Feed feed = feeds[index];
              return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    radius: 50,
                    child: CachedNetworkImage(
                      imageUrl: feed.userProfileImage,
                    ),
                  ),
                  title: _getFeedTitle(feed),
                  trailing: (feed.type == FeedType.comment || feed.type == FeedType.like)
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(feed.mediaUrl),
                            ),
                          ),
                        )
                      : null,
                  subtitle: Text(timeago.format(feed.timestamp.toDate())));
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        },
      ),
    );
  }

  Text _getFeedTitle(Feed feed) {
    String activityItemText = '';
    if (feed.type == FeedType.comment) {
      activityItemText = "replied: ${feed.commentData}";
    } else if (feed.type == FeedType.like) {
      activityItemText = "liked your post";
    } else if (feed.type == FeedType.follow) {
      activityItemText = "is following you";
    } else {
      activityItemText = "Error: Unkown type ${feed.type}";
    }
    return Text("${feed.username} $activityItemText");
  }
}
