import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/image_details_screen.dart';
import '../providers/image.dart' as im;

class ImageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final image = Provider.of<im.Image>(context, listen: false);
    return ClipRRect(
      // borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ImageDetailsScreen.routeName,
              arguments: image.id,
            );
          },
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(image.url_t),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
