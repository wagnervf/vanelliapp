import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidgetSplash extends StatelessWidget {
  const HeaderWidgetSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      //height: size.height,
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).accentColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: ShapeClipper([
              Offset(size.width / 5, 350),
              Offset(size.width / 10 * 5, 350 - 60),
              Offset(size.width / 5 * 4, 350 + 20),
              Offset(size.width, 350 - 18)
            ]),
          ),
          ClipPath(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).accentColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: ShapeClipper([
              Offset(size.width / 3, 350 + 20),
              Offset(size.width / 10 * 8, 350 - 60),
              Offset(size.width / 5 * 4, 350 - 60),
              Offset(size.width, 350 - 20)
            ]),
          ),
          ClipPath(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: ShapeClipper([
              Offset(size.width / 5, 350),
              Offset(size.width / 2, 350 - 40),
              Offset(size.width / 5 * 4, 350 - 80),
              Offset(size.width, 350 - 20)
            ]),
          ),
          Center(
            heightFactor: 4,
            child: Column(
              children: [
                SizedBox(height: size.height * .03),
                Image.asset(
                  "assets/img/icon6.png",
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  width: size.width * .5,
                  height: size.height * .1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
