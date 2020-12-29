import 'dart:convert';

import 'package:http/http.dart' as http;

class ImagesApi {
  static final String _API_KEY = 'a4d4ab76c0999e2a223c878a28d5b652';

  Future<dynamic> searchByImageTitle(String imageTitle, int perPage, int page) async {
    try {
      http.Response response = await http.get(
          "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=$_API_KEY&text=$imageTitle&format=json&nojsoncallback=1&per_page=$perPage&page=$page&extras=url_m,url_t,description,date_upload,date_taken,owner_name,views");
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

//   Future<dynamic> getImageData(String imageId) async {
//     try {
//       http.Response response = await http.get(
//           "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=$_API_KEY&photo_id=$imageId&format=json&nojsoncallback=1");
//       if (response.statusCode == 200) {
//         String data = response.body;
//         var jsonData = jsonDecode(data);
//         var imageData = {
//           'id': jsonData['photo']['id'],
//           'url': jsonData['photo']['urls']['url'][0]['_content'],
//           'title': jsonData['photo']['title']['_content'],
//           'owner': jsonData['photo']['owner']['username'],
//           'description': jsonData['photo']['description']['_content'],
//           'views': jsonData['photo']['views'],
//           'data_taken': jsonData['photo']['dates']['taken'],
//           'data_posted': jsonData['photo']['dates']['posted'],
//         };
//         //  print(new DateTime.fromMicrosecondsSinceEpoch(int.parse(jsonData['photo']['dates']['posted'])));
//         // DateTime myTime = DateTime.parse(jsonData['photo']['dates']['posted']);
//         return imageData;
//       } else {
//         print('status code = ${response.statusCode}');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
}
