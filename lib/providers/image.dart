import 'package:flutter/foundation.dart';

class Image with ChangeNotifier {
  final String id;
  final String title;
  final String owner;
  final String url;

  Image({
      @required this.id,
      @required this.title,
      @required this.owner,
      @required this.url
      });

  // factory Image.fromJson(Map<String, dynamic> jsonData) {
  //   return Image(
  //     id: jsonData['id'],
  //     title: jsonData['title'],
  //     owner: jsonData['owner'],
  //     url: jsonData['url'],
  //   );
  // }
}
