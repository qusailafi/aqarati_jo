import 'package:flutter/material.dart';

Widget cardWidget(
    BuildContext context,
    Widget child,
    double? height, {
      RoundedRectangleBorder? cardShape,
      EdgeInsets? cardPadding,
      Color? cardColor,
      double? elevation=.5
    }) {
  return Container(
    height: height,

    padding: cardPadding ?? EdgeInsets.zero,
    child: Card(elevation: elevation,
      color: cardColor ?? Colors.white,
      margin: EdgeInsets.zero,
      shape: cardShape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    ),
  );
}

