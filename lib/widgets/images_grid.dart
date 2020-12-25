import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/images.dart';
import './image_item.dart';

class ImagesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    final imagesData = Provider.of<Images>(context);
    final images = imagesData.imagesList;

    return images == null
        ? Center(child: Text('there is no data'))
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: images.length,
            itemBuilder: (ctx, i) => 
            ChangeNotifierProvider.value(
              value: images[i],
              child: ImageItem(
                  ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
  
}
