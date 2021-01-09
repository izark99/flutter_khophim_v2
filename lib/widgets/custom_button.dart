import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final Function onTap;

  const CustomButton({
    Key key,
    @required this.buttonName,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: PAD_SYM_H12_W03,
          color: Theme.of(context).accentColor,
          child: Text(
            buttonName,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).canvasColor),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
