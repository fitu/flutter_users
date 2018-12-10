import 'package:flutter_random_user/model/user.dart';

class UserFactory {
  static List<User> getUsers() {
    final List<User> users = [];
    users.add(User(
        id: '1',
        firstName: 'samuele',
        lastName: 'rousseau',
        picture: 'https://randomuser.me/api/portraits/med/men/14.jpg'));
    users.add(User(
        id: '2',
        firstName: 'linda',
        lastName: 'grande',
        picture: 'https://randomuser.me/api/portraits/med/women/66.jpg'));
    users.add(User(
        id: '3', firstName: 'lukas', lastName: 'colin', picture: 'https://randomuser.me/api/portraits/med/men/10.jpg'));
    users.add(User(
        id: '4', firstName: 'lesa', lastName: 'ruiz', picture: 'https://randomuser.me/api/portraits/med/women/72.jpg'));
    users.add(User(
        id: '5',
        firstName: 'willie',
        lastName: 'mcdonalid',
        picture: 'https://randomuser.me/api/portraits/med/women/96.jpg'));
    users.add(User(
        id: '6',
        firstName: 'ceyhun',
        lastName: 'dağlaroğlu',
        picture: 'https://randomuser.me/api/portraits/med/men/39.jpg"'));
    users.add(User(
        id: '7',
        firstName: 'archer',
        lastName: 'singh',
        picture: 'https://randomuser.me/api/portraits/med/men/91.jpg'));
    users.add(User(
        id: '8',
        firstName: 'adriana',
        lastName: 'parra',
        picture: 'https://randomuser.me/api/portraits/med/women/61.jpg'));
    users.add(User(
        id: '9',
        firstName: 'ilona',
        lastName: 'jokela',
        picture: 'https://randomuser.me/api/portraits/med/women/48.jpg'));
    users.add(User(
        id: '10',
        firstName: 'cristian',
        lastName: 'carmona',
        picture: 'https://randomuser.me/api/portraits/med/men/47.jpg'));
    return users;
  }

  static User getFavoriteUser() {
    return User(
        id: '1',
        firstName: 'samuele',
        lastName: 'rousseau',
        picture: 'https://randomuser.me/api/portraits/med/men/14.jpg',
        favorite: 1);
  }

  static getNotFavoriteUser() {
    return User(
        id: '1',
        firstName: 'samuele',
        lastName: 'rousseau',
        picture: 'https://randomuser.me/api/portraits/med/men/14.jpg',
        favorite: 0);
  }
}
