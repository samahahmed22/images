import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/image_details_screen.dart';
import '../providers/image.dart' as im;

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<im.Image>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ImageDetailsScreen.routeName,
              arguments: image.id,
            );
          },
          child: Hero(
            tag: image.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/a/a5/Red_Kitten_01.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
