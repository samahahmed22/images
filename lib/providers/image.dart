import 'package:flutter/foundation.dart';

class Image with ChangeNotifier {
  final String id;
  final String title;
  final String owner;
  final String url_m;
  final String url_t;
  final String date_taken;
  final String date_posted;
  final String description;
  final String views;

  Image(
      {@required this.id,
      @required this.title,
      @required this.owner,
      @required this.url_m,
      @required this.url_t,
      @required this.date_taken,
      @required this.date_posted,
      @required this.description,
      @required this.views});

  factory Image.fromJson(Map<String, dynamic> jsonData) {
    return Image(
      id: jsonData['id'],
      title: jsonData['title'],
      owner: jsonData['ownername'],
      url_m: jsonData['url_m'],
      url_t: jsonData['url_t'],
      date_taken: jsonData['datetaken'],
      date_posted: jsonData['dateupload'],
      description: jsonData['description']['_content'],
      views: jsonData['views'],
    );
  }
}
