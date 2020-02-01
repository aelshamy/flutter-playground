import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/auth/bloc/bloc.dart';
import 'package:socialmedia/common/model/post.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/header.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/profile/bloc/bloc.dart';

import 'edit_profile.dart';
import 'widgets/post_item.dart';
import 'widgets/post_tile.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: widget.user.displayName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgress());
          }
          if (state is ProfileLoadError) {
            return Center(child: Text(state.error));
          }
          final List<Post> posts = (state as ProfileLoaded).posts;
          return Column(
            // physics: ClampingScrollPhysics(),
            children: <Widget>[
              buildProfileHeader(posts.length),
              _buildPostsTabs(context, posts),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPostsTabs(BuildContext context, List<Post> posts) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            const Divider(height: 0.0),
            TabBar(
              labelColor: Theme.of(context).accentColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.all(5),
              tabs: <Widget>[
                Icon(Icons.grid_on),
                Icon(Icons.list),
              ],
            ),
            const Divider(height: 0.0),
            Expanded(
              child: posts.isEmpty
                  ? buildSplashScreen(context)
                  : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        buildProfileGridPost(posts),
                        buildProfileColumnPost(posts),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileHeader(int postsCount) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(widget.user.photoUrl),
                  ),
                  Text(
                    widget.user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   widget.user.displayName,
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  buildCountColumn("posts", postsCount),
                                  buildCountColumn("followers", 0),
                                  buildCountColumn("following", 0),
                                ],
                              ),
                              const SizedBox(height: 12),
                              buildProfileButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.user.bio,
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildProfileButton() {
    final User user = (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    final bool isProfileOwner = user.id == widget.user.id;
    if (isProfileOwner) {
      return buildButton(
        text: "Edit Profile",
        function: () {
          editProfile(user);
        },
      );
    }
    return const Text('Profile button');
  }

  Widget buildButton({String text, void Function() function}) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: FlatButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: 150,
          height: 27,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void editProfile(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => EditProfile(user: user),
        settings: const RouteSettings(name: "EditProfile"),
      ),
    );
  }

  Widget buildProfileColumnPost(List<Post> posts) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 30),
      itemBuilder: (BuildContext context, int index) {
        final Post post = posts[index];
        return PostItem(post: post, user: widget.user);
      },
      itemCount: posts.length,
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.only(top: 13.0),
        child: Divider(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget buildProfileGridPost(List<Post> posts) {
    final List<GridTile> gridTiles = posts
        .map((post) => GridTile(
              child: PostTile(
                post: post,
              ),
            ))
        .toList();

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: gridTiles,
    );
  }

  Widget buildSplashScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset('assets/images/no_content.svg', height: 200),
        const SizedBox(height: 10),
        Text(
          'No Posts',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
