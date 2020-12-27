import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/image.dart' as image;

class ImagesApi {
  static final String _API_KEY = '298aeb2f5da509cbf7ded3c2e48d2cce';

  Future searchByImageTitle(String imageTitle, int perPage, int page) async {
    try {
      http.Response response = await http.get(
          "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=$_API_KEY&text=$imageTitle&format=json&nojsoncallback=1&per_page=$perPage&page=$page");
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        var jsonImages = jsonData['photos'];
        return jsonImages;
      } else {
        print('status code = ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> searchForImageUrl(String imageId) async {
    try {
      http.Response response = await http.get(
          "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=$_API_KEY&photo_id=$imageId&format=json&nojsoncallback=1");
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        print(data);
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
