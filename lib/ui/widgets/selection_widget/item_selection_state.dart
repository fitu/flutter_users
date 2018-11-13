import 'package:flutter_random_user/model/Item.dart';

class StatusItemSelection {}

class LoadingMode extends StatusItemSelection {}

class ListMode extends StatusItemSelection {
  final List<Item> items;

  ListMode(this.items);
}

class PageMode extends StatusItemSelection {
  final List<Item> items;

  PageMode(this.items);
}

class EmptyMode extends StatusItemSelection {}

class ErrorMode extends StatusItemSelection {}

class SwapListMode extends StatusItemSelection {
  final List<Item> items;
  final bool isList;

  SwapListMode(this.items, this.isList);
}
