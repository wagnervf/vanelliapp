import 'package:flutter/material.dart';
import 'constants.dart';

class ButtonSalvar extends StatelessWidget {
  const ButtonSalvar(
      {Key? key, required this.size, required this.press, required this.color})
      : super(key: key);

  final Size size;
  final Function press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * .1,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 10),
                const Text(
                  "Salvar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
