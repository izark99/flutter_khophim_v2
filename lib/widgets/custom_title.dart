import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomTitle({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: ICON_SIZE_M,
        ),
        SIZED_BOX_W05,
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }
}
