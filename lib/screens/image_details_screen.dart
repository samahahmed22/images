import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/images.dart';

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
      appBar: AppBar(title: Text('${loadedImage.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: double.infinity,
              child: Image.network(
                loadedImage.url_m,
                fit: BoxFit.cover,
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   child: Column(children: <Widget>[
                Text(
                  loadedImage.owner,
                  textAlign: TextAlign.center,
                ),
            //     Text(
            //       loadedImage.date_taken,
            //       textAlign: TextAlign.center,
            //     ),
            //     Text(
            //       loadedImage.date_posted,
            //       textAlign: TextAlign.center,
            //     ),
            //     Text(
            //       loadedImage.views,
            //       textAlign: TextAlign.center,
            //     ),
            //   ]),
            // )
          ],
        ),
      ),
    );
  }
}
