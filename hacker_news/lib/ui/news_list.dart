import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/blocs/stories/stories_bloc.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top News')),
      body: BlocBuilder<StoriesBloc, StoriesState>(
        builder: (BuildContext context, StoriesState state) {
          if (state.data != null) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (BuildContext context, int index) {
                print(state.data[index]);
                return SizedBox();
                // return FutureBuilder(
                //   future: state.data[index],
                //   builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
                //     if (snapshot.hasData) {
                //       return ListTile(title: Text(snapshot.data.title));
                //     }
                //     return SizedBox();
                //   },
                // );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
