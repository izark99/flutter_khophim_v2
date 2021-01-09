import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:khophim/helpers/constant.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function onTabChange;
  final List<GButton> tabs;

  const CustomBottomNavigationBar({
    Key key,
    @required this.selectedIndex,
    @required this.onTabChange,
    @required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_SYM_H10,
      child: GNav(
        gap: 4,
        textStyle: Theme.of(context).textTheme.bodyText1,
        iconSize: ICON_SIZE_S,
        padding: PAD_SYM_H12_W03,
        tabMargin: PAD_SYM_V10,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        color: Theme.of(context).accentColor,
        activeColor: Theme.of(context).accentColor,
        duration: Duration(milliseconds: 800),
        tabBackgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
        tabs: tabs,
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}
