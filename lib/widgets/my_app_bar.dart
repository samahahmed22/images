import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  MyAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context);
    return AppBar(title: Text(title), actions: <Widget>[
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
    ]);
  }
}
