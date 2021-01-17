import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    Key key,
    @required this.currentIndex,
    @required this.onTap,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).accentColor.withOpacity(0.5),
      selectedLabelStyle: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
