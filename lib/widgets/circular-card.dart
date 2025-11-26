import 'package:flutter/material.dart';

class CircularCard extends StatelessWidget {
  final double size;
  final Widget child;
  final Color color;
  final double elevation;
  final VoidCallback? onTap;

  const CircularCard({
    Key? key,
    this.size = 30,
    required this.child,
    this.color = Colors.black,
    this.elevation = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(

            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: elevation,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
