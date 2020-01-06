import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/model/user.dart';
import 'package:socialmedia/pages/home.dart';
import 'package:socialmedia/widgets/progress.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Stream<QuerySnapshot> users;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
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
            setState(() {
              users = usersRef.where("displayName", isGreaterThanOrEqualTo: query).snapshots();
            });
          },
        ),
      ),
      body: users == null ? buildNoContnet() : buildSearchResults(),
    );
  }

  Widget buildNoContnet() {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/images/search.svg',
                    height: orientation == Orientation.portrait ? 250 : 200,
                  ),
                  Text(
                    'Find Users',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildSearchResults() {
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgress();
        }
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            User user = User.fromDocument(snapshot.data.documents[index]);
            print(user.photoUrl);
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
        );
      },
    );
  }
}
