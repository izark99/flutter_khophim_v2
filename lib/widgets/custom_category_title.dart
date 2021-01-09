import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/widgets/custom_button.dart';

class CustomCategoryTitle extends StatelessWidget {
  final String title;
  final Function onTap;

  const CustomCategoryTitle({
    Key key,
    @required this.title,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PAD_SYM_H20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.start,
          ),
          CustomButton(
            buttonName: STR_SEE_ALL,
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
