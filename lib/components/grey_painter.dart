import 'package:flutter/rendering.dart';
import 'colors.dart';

class GreyPainter extends CustomPainter{

  GreyPainter() :
        bluePaint = Paint()..color = green1..style = PaintingStyle.fill,
        bluegreyPaint = Paint()..color = Color(0xffd4d4d4)..style = PaintingStyle.fill,
        greenPaint = Paint()..color = dblue..style = PaintingStyle.fill;

  final bluePaint;
  final bluegreyPaint;
  final greenPaint;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    paintGrey(canvas, size);
  }

  void paintGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height/2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(size.width*0.6, size.height*0),
      Point(size.width*0.55, size.height*0),
      Point(size.width*0.54, size.height*0.115),
      Point(size.width*0.85, size.height*0.17),
      Point(size.width*0.95, size.height*0.19),
      Point(size.width, size.height*0.24),
      Point(size.width, size.height*0.24),

    ]);

    canvas.drawPath(path, bluegreyPaint);
  }

  void paintGreen(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height/2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(size.width*0, size.height*0.1),
      Point(size.width*0, size.height*0.1),
      Point(size.width*0.15, size.height*0.175),
      Point(size.width*0.3, size.height*0.1),
      Point(size.width*0.5, size.height*0.125),
      Point(size.width*0.7, size.height*0),
      Point(size.width, size.height*-0.4),

    ]);

    canvas.drawPath(path, greenPaint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points){
    if (points.length < 3){
      throw UnsupportedError('Need three or more points to create a path');
    }

    for(var i = 0; i < points.length -2; i++){
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    path.quadraticBezierTo(
      points[points.length - 2].x,
      points[points.length - 2].y,
      points[points.length - 1].x,
      points[points.length - 1].y,
    );
  }

}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}
