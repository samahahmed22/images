import 'package:flutter/foundation.dart';

class Image with ChangeNotifier {
  final String id;
  final String title;
  final String owner;
  final String url;
  final String date_taken;
  final String description;
  final String tags;

  Image({
      @required this.id,
      @required this.title,
      @required this.owner,
      @required this.url,
      @required this.date_taken,
      @required this.description,
      @required this.tags
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
