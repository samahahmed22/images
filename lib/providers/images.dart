import 'package:flutter/widgets.dart';

import '../providers/image.dart' as image;
import '../helpers/images_api.dart';

class Images extends ChangeNotifier {
  List<image.Image> _images = [];
  int _page = 1;
  int _pages;
  int _perPage = 12;
  int _total;
  String _searchText;

  image.Image findById(String id) {
    return _images.firstWhere((image) => image.id == id);
  }

  Future<void> searchByImageTitle(String imageTitle) async {
    if (_searchText == null) {
      _images = [];
      _searchText = imageTitle;
    }

    var jsonData =
        await ImagesApi().searchByImageTitle(_searchText, _perPage, _page);
    var jsonImages = jsonData['photo'];
    _pages = jsonData['pages'];
    _total = int.parse(jsonData['total']);

    //  jsonImages.forEach((image) async {
    //     _images.add(image.Image(
    //       id: image['id'],
    //       title: image['title'],
    //       owner: image['owner'],
    //       url: await _searchForImageUrl(jsonImages[i]['id'],
    //     ));
    //   });

    for (var i = 0; i < jsonImages.length; i++) {
      _images.add(image.Image(
        id: jsonImages[i]['id'],
        title: jsonImages[i]['title'],
        owner: jsonImages[i]['owner'],
        url: await ImagesApi().searchForImageUrl(jsonImages[i]['id']),
      ));
    }

    notifyListeners();
  }

  Future<void> fetchMoreData() {
    if (_searchText != null) {
      if (_page == _pages) {
        _perPage = _total - _images.length;
        searchByImageTitle(_searchText);
        _page = 1;
        _searchText = null;
      } else {
        _page++;
        searchByImageTitle(_searchText);
      }
    }
  }

  List<image.Image> get imagesList => _images;
  int get page => _page;
  int get pages => _pages;
  int get perPage => _perPage;
  int get total => _total;
}
