import 'package:flutter/material.dart';
import 'package:flutter_random_user/model/Item.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/selection_widget.dart';

abstract class ItemsBaseWidget extends StatelessWidget {
  final List<Item> list;
  final DidItemSelected didItemSelected;

  ItemsBaseWidget(this.list, this.didItemSelected);

  int numberOfItems() {
    return list != null ? list.length : 0;
  }

  Item getItem(int index) {
    return list[index];
  }

  Widget createTitle(Item item, {double fontSize: 17.0, Color color: Colors.black}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.title, style: TextStyle(fontSize: fontSize, color: color)));
  }
}
