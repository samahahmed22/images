import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("facebook login"), actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
                await Provider.of<Auth>(context, listen: false)
            .logout();
            },
          )
        ]),
        body: Center(
          child: Text("welcome here....."),
        ));
  }
}
