import 'package:flutter/material.dart';
import 'package:flutter_random_user/model/Item.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/items_base_widget.dart';

class ItemsListWidget extends ItemsBaseWidget {

  ItemsListWidget(List<Item> list, didItemSelected) : super(list, didItemSelected);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: numberOfItems(),
        itemBuilder: (BuildContext context, int index) => createCardViewForListView(index));
  }

  Widget createCardViewForListView(int index) {
    Item item = getItem(index);
    return Card(
      child: ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          leading: createAvatar(item),
          title: createTitle(item),
          subtitle: Text(item.subtitle),
          onTap: () => didItemSelected(item)),
    );
  }

  Widget createAvatar(Item item, {double radius: 35.0}) {
    return CircleAvatar(backgroundImage: NetworkImage(item.image), radius: radius);
  }
}