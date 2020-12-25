import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  User({
      @required this.id,
      @required this.name,
      @required this.email,
      @required this.imageUrl
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
