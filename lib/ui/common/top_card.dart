import 'package:flutter/material.dart';
import 'package:Fabric_Detective/ui/common/text_widgets.dart';

Column topCard(bool isLogin) {
  double pad = 0;
  if (isLogin) {
    pad = 60;
  } else {
    pad = 226;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: double.infinity,
        height: 288,
        decoration: const BoxDecoration(
          color: Color(0xFF4F71AF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/image18.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget('Login'),
                const SizedBox(width: 108),
                textWidget('Sign Up')
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(pad, 0, 0, 0),
        child: Container(
          height: 3,
          color: const Color(0xFFFA4A0C),
          width: 120,
        ),
      ),
    ],
  );
}
