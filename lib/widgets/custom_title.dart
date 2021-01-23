import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool center;
  const CustomTitle({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
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
