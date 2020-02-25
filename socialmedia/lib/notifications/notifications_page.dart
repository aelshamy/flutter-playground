import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/common/model/notification.dart' as model;
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/common/widgets/route_aware_widget.dart';
import 'package:socialmedia/notifications/bloc/notifications_bloc.dart';
import 'package:socialmedia/profile/post_page.dart';
import 'package:socialmedia/profile/profile.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: "Activity Feed"),
      body: BlocConsumer<NotificationsBloc, NotificationsState>(
        listener: (BuildContext context, NotificationsState state) {
          if (state is NotificationsGoToPost) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PostPage(
                  user: User(
                    username: state.notification.username,
                    photoUrl: state.notification.userProfileImage,
                  ),
                  post: Post(
                      mediaUrl: state.notification.mediaUrl,
                      location: state.notification.postLocation,
                      likes: state.notification.postLikes,
                      description: state.notification.postDescription),
                ),
                settings: const RouteSettings(name: "PostPage"),
              ),
            );
          }
        },
        buildWhen: (previous, current) => current is! NotificationsGoToPost,
        builder: (context, state) {
          if (state is NotificationsInitial) {
            return const CircularProgress();
          }
          if (state is NotificationsLoadError) {
            return Center(child: Text(state.error));
          }
          if (state is FeedRecieved) {
            final notifications = state.notifications;

            return ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                final model.Notification notification = notifications[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => BlocProvider.of<NotificationsBloc>(context)
                      .add(NotificationsShowPost(notification: notification)),
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    leading: CircleAvatar(
                      child: CachedNetworkImage(
                        imageUrl: notification.userProfileImage,
                      ),
                    ),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${notification.username}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                log('clicked');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const RouteAwareWidget(
                                        "Profile",
                                        child: Profile(user: null)),
                                  ),
                                );
                              },
                          ),
                          TextSpan(text: _getFeedTitle(notification)),
                        ],
                      ),
                      style: const TextStyle(height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: (notification.type == model.NotificationType.comment ||
                            notification.type == model.NotificationType.like)
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(notification.mediaUrl),
                              ),
                            ),
                          )
                        : null,
                    subtitle: Text(
                      timeago.format(notification.timestamp.toDate()),
                      style: const TextStyle(height: 1.5),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  String _getFeedTitle(model.Notification notification) {
    String activityItemText = '';
    switch (notification.type) {
      case model.NotificationType.comment:
        activityItemText = " commented on your post: ${notification.commentData}";
        break;
      case model.NotificationType.like:
        activityItemText = " like your post";
        break;
      case model.NotificationType.follow:
        activityItemText = " is following you";
        break;
      default:
        activityItemText = "Error: Unkown type ${notification.type}";
    }
    return activityItemText;
  }
}
