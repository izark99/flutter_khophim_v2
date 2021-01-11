import 'package:flutter/material.dart';
import 'package:khophim/helpers/constant.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final String hint;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int maxLength;
  final bool obscureText;
  final bool useOnChanged;
  final bool autofocus;

  const CustomTextFormField({
    Key key,
    @required this.controller,
    this.onChanged,
    @required this.hint,
    this.suffixIcon,
    this.maxLength,
    this.prefixIcon,
    this.obscureText,
    @required this.useOnChanged,
    this.autofocus,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      controller: controller,
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: useOnChanged ? (v) => onChanged() : (v) {},
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding: PAD_SYM_H10,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        helperStyle: Theme.of(context).textTheme.bodyText2,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(05)),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
