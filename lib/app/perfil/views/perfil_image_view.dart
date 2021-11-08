import 'package:flutter/material.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
import 'package:get/get.dart';

class PerfilImageView extends StatelessWidget {
  const PerfilImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final String? url = userController.user.photoURL;
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          url == "" || url == null
              ? const CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/Profile Image.png"),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(url),
                ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFF5F6F9),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
