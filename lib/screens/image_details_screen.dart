import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/images.dart';
import '../widgets/my_app_bar.dart';

class ImageDetailsScreen extends StatelessWidget {
  static const routeName = '/image-details';

  @override
  Widget build(BuildContext context) {
    final imageId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedImage = Provider.of<Images>(
      context,
      listen: false,
    ).findById(imageId);
    return Scaffold(
      appBar: MyAppBar(loadedImage.title),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: Image.network(
                loadedImage.url_m,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                 Row(children: <Widget>[
                  Text(
                    'Title: ',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    loadedImage.title,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ]),
                 Row(children: <Widget>[
                  Text(
                    'Description: ',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Expanded(
                                      child: Text(
                      loadedImage.description,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  Text(
                    'Taken by: ',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    loadedImage.owner,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ]),
                Row(children: <Widget>[
                  Text('Taken at: ',
                      style: Theme.of(context).textTheme.headline2),
                  Text(
                    loadedImage.date_taken,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ]),
                Row(children: <Widget>[
                  Text('Posted at: ',
                      style: Theme.of(context).textTheme.headline2),
                    Text(
                      loadedImage.date_posted,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                ]),
                 Row(children: <Widget>[
                  Text('Views: ',
                      style: Theme.of(context).textTheme.headline2),
                    Text(
                      loadedImage.views,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                 ]),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
