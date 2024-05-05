import 'package:flutter/material.dart';

Text textWidget(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w500,
      wordSpacing: 1.0,
    ),
  );
}
