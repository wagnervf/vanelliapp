import 'package:flutter/material.dart';

class SocialCard extends StatelessWidget {
  final String icon;
  final Function press;

  const SocialCard({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(8.0),
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          color: Color(0xfff5f6f9),
          shape: BoxShape.circle,
        ),
        //   child: SvgPicture.asset(icon),
      ),
    );
  }
}
