import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customButton(
    {required VoidCallback onPressed,
    required Color color,
    required Color textColor,
    required String title,
    double borderRadius = 8.0}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(12),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    onPressed: onPressed,
    child: title.text.color(textColor).fontFamily(bold).make(),
  );
}
