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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedImage.title),
              background:  Hero(
                  tag: loadedImage.id,
                  child: Image.network("https://upload.wikimedia.org/wikipedia/commons/a/a5/Red_Kitten_01.jpg",
                      fit: BoxFit.cover))
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10),

             Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  loadedImage.owner,
                  textAlign: TextAlign.center,
                )),
          ])),
        ],
      
      ),
    );
  }
}
