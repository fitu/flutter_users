import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_random_user/model/Item.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/dots_indicator.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/item_selection_state.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/items_list_widget.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/items_page_widget.dart';

class SelectionWidget extends StatefulWidget {
  final StatusItemSelection statusItemSelection;
  final DidItemSelected didItemSelected;

  SelectionWidget({@required this.statusItemSelection, this.didItemSelected});

  @override
  SelectionWidgetState createState() => SelectionWidgetState();
}

class SelectionWidgetState extends State<SelectionWidget> {
  static const _duration = const Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final StatusItemSelection status = widget.statusItemSelection;
    if (status is LoadingMode) {
      return createMessageView("Loading...");
    }
    if (status is ListMode) {
      return ItemsListWidget(status.items, widget.didItemSelected);
    }
    if (status is PageMode) {
      return pageViewWithIndicator(status.items);
    }
    if (status is EmptyMode) {
      return createMessageView("Items not found");
    }
    if (status is SwapListMode) {
      return status.isList
          ? ItemsListWidget(status.items, widget.didItemSelected)
          : ItemsPageWidget(status.items, widget.didItemSelected);
    }
    throw UnimplementedError();
  }

  Widget createMessageView(String message) {
    return Center(child: Text(message));
  }

  Widget pageViewWithIndicator(List<Item> items) {
    var itemsPage = ItemsPageWidget(items, widget.didItemSelected);
    return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[itemsPage, pageIndicator(itemsPage.pageController, items)]);
  }

  Widget pageIndicator(PageController pageController, List<Item> items) {
    return SizedBox(
        height: 80.0,
        child: DotsIndicator(
            controller: pageController,
            itemCount: items.length,
            color: Colors.black87,
            onPageSelected: (int page) {
              pageController.animateToPage(page, duration: _duration, curve: _curve);
            }));
  }
}

typedef DidItemSelected = Function(Item);
