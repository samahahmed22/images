import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/image.dart' as image;

class ImagesApi {
  static final String _API_KEY = '843f2df1d2a9598c67c92271be1a8b91';

  Future<List<image.Image>> searchByImageTitle(String imageTitle) async {
    try {
      http.Response response = await http.get(
          "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=$_API_KEY&text=$imageTitle&format=json&nojsoncallback=1&per_page=10");
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        var jsonImages = jsonData['photos']['photo'];

        List<image.Image> loaded_images = [];
        
        //  jsonImages.forEach((image) async {
        //     loaded_images.add(image.Image(
        //       id: image['id'],
        //       title: image['title'],
        //       owner: image['owner'],
        //       url: await _searchForImageUrl(jsonImages[i]['id'],
        //     ));
        //   });

        for (var i = 0; i < jsonImages.length; i++) {  
          loaded_images.add(image.Image(
            id: jsonImages[i]['id'],
            title: jsonImages[i]['title'],
            owner: jsonImages[i]['owner'],
            url: await _searchForImageUrl(jsonImages[i]['id']),
          ));
        }
        return loaded_images;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> _searchForImageUrl(String imageId) async {
    try {
      http.Response response = await http.get(
          "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=$_API_KEY&photo_id=$imageId&format=json&nojsoncallback=1");
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        var url = jsonData['photo']['urls']['url'][0]['_content'];
        return url;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
