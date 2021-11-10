import 'package:flutter/material.dart';
import 'package:vanelliapp/app/theme.dart';

class ProfileMenuView extends StatelessWidget {
  const ProfileMenuView({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFF5F6F9),
        ),
        child: TextButton(
          onPressed: press,
          child: Row(
            children: [
              // SvgPicture.asset(
              //   icon,
              //   color: kPrimaryColor,
              //   width: 22,
              // ),
              const SizedBox(width: 20),
              Expanded(child: Text(text)),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
