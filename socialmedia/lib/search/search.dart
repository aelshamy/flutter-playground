import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/common/model/user.dart';
import 'package:socialmedia/common/widgets/progress.dart';
import 'package:socialmedia/search/bloc/search_bloc.dart';

import 'bloc/bloc.dart';
import 'bloc/search_state.dart';

class Search extends StatelessWidget {
  final TextEditingController _controller;

  Search() : _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search for a user...',
            filled: true,
            prefixIcon: Icon(Icons.account_box),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
              },
            ),
          ),
          onFieldSubmitted: (String query) {
            _controller.clear();

            BlocProvider.of<SearchBloc>(context).add(SearchStarted(query));
          },
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
          if (state is SearchInitial) {
            return _buildSearchInitial();
          }
          if (state is SearchLoading) {
            return const CircularProgress();
          }
          if (state is SearchError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is SearchError) {}
          return _buildSearchLoaded((state as SearchLoaded).users);
        },
      ),
    );
  }

  Widget _buildSearchInitial() {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 220 : 180,
            ),
            Text(
              'Find Users',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildSearchLoaded(List<User> users) {
    return users.isNotEmpty
        ? ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              final User user = users[index];
              return Container(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                  title: Text(
                    user.displayName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    user.username,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text('No Results found'),
          );
  }
}
