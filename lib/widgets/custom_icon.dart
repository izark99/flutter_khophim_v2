import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  const CustomIcon({
    Key key,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: ICON_SIZE_M,
      ),
    );
  }
}
