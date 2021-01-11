import 'package:khophim/helpers/constant.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final String text;

  const CustomLoading({
    Key key,
    this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text != null ? text : STR_LOADING,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SIZED_BOX_H05,
          Container(
            child: LinearProgressIndicator(),
            width: MediaQuery.of(context).size.width / 1.5,
          ),
        ],
      ),
    );
  }
}
