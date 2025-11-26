import 'package:flutter/material.dart';

class VerticalDashedLine extends StatelessWidget {
  final double height;
  final double dashHeight;
  final double dashGap;
  final double thickness;
  final Color color;
  final double? width;

  const VerticalDashedLine({
    super.key,
    required this.height,
    this.dashHeight = 6,
    this.dashGap = 4,
    this.thickness = 2,
    this.color = Colors.black,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? thickness,
      child: CustomPaint(
        painter: _VerticalDashedLinePainter(
          dashHeight: dashHeight,
          dashGap: dashGap,
          thickness: thickness,
          color: color,
        ),
      ),
    );
  }
}

class _VerticalDashedLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashGap;
  final double thickness;
  final Color color;

  _VerticalDashedLinePainter({
    required this.dashHeight,
    required this.dashGap,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashGap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
