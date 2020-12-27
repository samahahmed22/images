import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../providers/images.dart';
import '../providers/image.dart' as img;
import './image_item.dart';

class ImagesGrid extends StatefulWidget {
  @override
  _ImagesGridState createState() => _ImagesGridState();
}

class _ImagesGridState extends State<ImagesGrid> {
  bool _isLoading = false;
  List<img.Image> images = [];

  @override
  Widget build(BuildContext context) {
    images = Provider.of<Images>(context).imagesList;
    print(images.length);
    return images.isEmpty
        ? Center(child: Text('Start your search now'))
        : _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : LazyLoadScrollView(
                isLoading: _isLoading,
                onEndOfPage: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Provider.of<Images>(context, listen: false)
                      .fetchMoreData();

                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Scrollbar(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: images.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: images[i],
                      child: ImageItem(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                  ),
                ),
              );
  }
}
