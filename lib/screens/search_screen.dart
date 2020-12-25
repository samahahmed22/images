import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_widget/search_widget.dart';

import '../providers/auth.dart';
import '../providers/images.dart';
import '../widgets/images_grid.dart';
import '../providers/auth.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context, listen: false);
    final images = Provider.of<Images>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Flickr Images"), actions: <Widget>[
        Row(children: <Widget>[
          DropdownButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(userData.user.photoURL),
            ),
            items: [
              DropdownMenuItem(
                child: Text('Logout'),
              ),
            ]),
          // SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          // SizedBox(width: 8),
        ]),
      ]),
      body: Column(children: <Widget>[
        RaisedButton(
          onPressed: () async {
            images.searchByImageTitle("cats");
          },
        ),
        Expanded(child: ImagesGrid())
      ]),
    );
  }
}
