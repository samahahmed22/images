import 'package:flutter/widgets.dart';

import '../providers/image.dart' as image;
import '../helpers/images_api.dart';

class Images extends ChangeNotifier {
  List<image.Image> _images = [];
  int _page = 1;
  int _pages;
  int _perPage;
  int _total;
  String _searchText;

  image.Image findById(String id) {
    return _images.firstWhere((image) => image.id == id);
  }

  Future<void> searchByImageTitle(String imageTitle, int perPage) async {
    if (_searchText != imageTitle) {
      _images = [];
    }

    _searchText = imageTitle;
    _perPage = perPage;

    var jsonData =
        await ImagesApi().searchByImageTitle(_searchText, _perPage, _page);
    List<dynamic> jsonImages = jsonData['photo'];
    _pages = jsonData['pages'];
    _total = int.parse(jsonData['total']);

    List<image.Image> _currentImages = [];
    _currentImages = jsonImages.map((e) => image.Image.fromJson(e)).toList();
    _images.addAll(_currentImages);

    // jsonImages.forEach((item) async {
    //   image.Image currentImage = image.Image.fromJson(await ImagesApi().getImageData(item['id']));
    //  _images.add( currentImage);
    //  notifyListeners();
    // });

    // for (var i = 0; i < jsonImages.length; i++) {
    //   _images.add( image.Image.fromJson(await ImagesApi().getImageData(jsonImages[i]['id'])));

    // }

    notifyListeners();
  }

  Future<void> fetchMoreData(String title) {
    if (_page == _pages) {
      _perPage = _total - _images.length;
      searchByImageTitle(title, _perPage);
      _page = 1;
    } else {
      _page++;
      searchByImageTitle(title, _perPage);
    }

    notifyListeners();
  }

  List<image.Image> get imagesList => _images;
  int get page => _page;
  int get pages => _pages;
  int get perPage => _perPage;
  int get total => _total;
  String get searchText => _searchText;
}
