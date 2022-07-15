import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  @required TextEditingController controlText,
  @required TextInputType type,
  @required IconData prefix,
  @required String text,
  bool isPassword = false,
  @required Function validate,
  Function tap,
  Function onSubmit,
  Function change,
  bool visible = true,
  IconData suffix,
  Function suffixPressed,
}) =>
    TextFormField(
      onTap: tap,
      onFieldSubmitted: onSubmit,
      onChanged: change,
      keyboardType: type,
      enabled: visible,
      validator: validate,
      obscureText: isPassword,
      controller: controlText,
      decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          labelText: text,
          suffix: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
