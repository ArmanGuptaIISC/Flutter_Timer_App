import 'dart:math';

import 'package:flutter/material.dart';

final Color GRAD_TOP=const Color(0xFFF5F5F5);
final Color GRAD_BOTTOM=const Color(0xFFE8E8E8);

class TimerDailKnob extends StatefulWidget {
  
  final rotationPercent;
  TimerDailKnob({this.rotationPercent});
  
  @override
  _TimerDailKnobState createState() => _TimerDailKnobState();
}

class _TimerDailKnobState extends State<TimerDailKnob> {
  @override
  Widget build(BuildContext context) {
    return Stack(
                children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: new CustomPaint(
                    painter: new ArrowPainter(
                      rotationPer: widget.rotationPercent
                    ),
                  ),
                ),
                new Container(
                      padding: EdgeInsets.all(20.0),
                      decoration:new BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end:Alignment.bottomCenter,
                        colors:[GRAD_TOP,GRAD_BOTTOM]
                      ),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black38,
                          blurRadius: 2.5,
                          spreadRadius: 1.0,
                          offset:const Offset(0.0, 2.0)
                      )
                      ]
                    ),
                    child: Transform(
                      transform: new Matrix4.rotationZ(2*pi*widget.rotationPercent),
                      alignment: Alignment.center,
                      child: new Container(
                      child: new Center(
                        child: new FlutterLogo(colors:Colors.indigo),
                      ),
                      decoration:new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:Colors.black12,
                          width:1.5
                        )
                      ),
          ),
                    ),
          ),
      ]
  ); 
  }
}
class ArrowPainter extends CustomPainter
{
  Paint dailArrowPaint;
  final rotationPer;
  ArrowPainter({this.rotationPer}){
      dailArrowPaint=new Paint();
      dailArrowPaint.color=Colors.black;
      dailArrowPaint.style=PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.save();
    var radius=size.width/2;
    canvas.translate(radius,radius);
    Path path=new Path();
    path.moveTo(0.0,-radius-10.0);
    path.lineTo(10.0, -radius+5.0);
    path.lineTo(-10.0,-radius+5.0);
    path.close();
    canvas.rotate(2*pi*rotationPer);
    canvas.drawPath(path, dailArrowPaint);
    canvas.drawShadow(path, Colors.black, 3.0, false);
    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}