import 'package:flutter/widgets.dart';

import '../providers/image.dart' as image;
import '../helpers/images_api.dart';

class Images extends ChangeNotifier {
  List<image.Image> _images = [];

  image.Image findById(String id) {
    return _images.firstWhere((image) => image.id == id);
  }

  Future<void> searchByImageTitle(String imageTitle) async {
    _images = await ImagesApi().searchByImageTitle(imageTitle);
    notifyListeners();
  }

  List<image.Image> get imagesList => _images;
}
