
import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/images.dart';

Widget backgroundWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill)
    ),
    child: child,
  );
}