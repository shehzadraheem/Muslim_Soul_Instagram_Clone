import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration decorationWidget(BuildContext context, String text, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    labelText: text,
    contentPadding: EdgeInsets.zero,
    enabledBorder: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).primaryColor,
      ),
    ),
    focusColor: Theme.of(context).primaryColor,
  );
}