
import 'package:flutter_random_user/model/user.dart';
import 'package:meta/meta.dart';

class Item {
  final String id;
  final String image;
  final String title;
  final String subtitle;

  Item({@required this.id, @required this.image, @required this.title, this.subtitle = 'No subtitle'});

  factory Item.fromUser(User user) => Item(id: user.id, image: user.picture, title: user.firstName);
}