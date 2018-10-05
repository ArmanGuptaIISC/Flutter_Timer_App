import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_timer/timer_dail_knob.dart';
import 'radial_drag_gesture_detector.dart';

final Color GRAD_TOP=const Color(0xFFF5F5F5);
final Color GRAD_BOTTOM=const Color(0xFFE8E8E8);


class TimerDial extends StatefulWidget {
   final Duration currentTime;
   final int tickPerSegment;
   final Duration maxTime;
   final Function(Duration) onTimeSelected;
   final Function(Duration) dialStopTurning;
   TimerDial({
     this.currentTime=const Duration(seconds: 0),
     this.maxTime=const Duration(minutes: 60),
     this.tickPerSegment=5,
     this.onTimeSelected,
     this.dialStopTurning
     });
  
  @override
  _TimerDialState createState() => _TimerDialState();
}

class _TimerDialState extends State<TimerDial> {

  _rotationpercent(){return widget.currentTime.inSeconds/ widget.maxTime.inSeconds;}

  @override
  Widget build(BuildContext context) {
    return DialTurnGestureDetector(
      maxTime: widget.maxTime,
      currentTime: widget.currentTime,
      timeSelected:widget.onTimeSelected,
      dialStopTurning:widget.dialStopTurning,
      child: new Container(
                    width:double.infinity,
                    child: new Padding(
                      padding: const EdgeInsets.only(left:45.0,right: 45.0,top:10.0),
                      child:AspectRatio(
                        aspectRatio: 1.0,
                        child:new Container(
                          decoration:new BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end:Alignment.bottomCenter,
                              colors:[GRAD_TOP,GRAD_BOTTOM]
                            ),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                                offset:const Offset(0.0, 2.0)
                            )
                            ]
                          ),
                          child:Stack(
                            children: [
                               Padding(
                              padding: const EdgeInsets.all(65.0),
                              child: new TimerDailKnob(
                               
                               rotationPercent:_rotationpercent()

                              ),
                               ),
                              Padding(
                                padding: const EdgeInsets.all(55.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: new CustomPaint(
                                    painter: new TickPainter(
                                      tick_counter: widget.maxTime.inMinutes,
                                      tickperseg: widget.tickPerSegment
                                    ),
                                  ),
                                ),
                              ),
                             
                            ]
                          ),
                        )
                      )
                    ),
                  ),
    );
  }
}

class TickPainter extends CustomPainter
{
  final SHORT_TICK=4.0;
  final LONG_TICK=12.0;

  final Paint tickPaint;
  final tick_counter;
  final tickperseg;
  final tickinset;
  final textPainter;
  final textStyle;
  TickPainter({this.tick_counter=60,
  this.tickperseg=5,
  this.tickinset=0.0}):tickPaint=new Paint(),
  textPainter=new TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr
  ),
  textStyle=new TextStyle(
    color: Colors.black,
    fontFamily: 'BebasNeue',
    fontSize: 10.0
  )
  {
    tickPaint.color=Colors.black;
    tickPaint.strokeWidth=1.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    
    canvas.translate(size.width/2, size.height/2);

    final radius=size.width/2;
    for(var i=0;i<tick_counter;i++)
    {

    final tick_size=(i%tickperseg==0)?LONG_TICK:SHORT_TICK;
    canvas.drawLine(new Offset(0.0, -radius), new Offset(0.0,-radius-tick_size), tickPaint);
    
    if(tick_size==LONG_TICK)
    {
      //paint text
      double per=i/tick_counter;
      var quad;
      if(per < 0.25)
      quad=1;
      else if(per < 0.5)
      quad=2;
      else if(per==0.5)
      quad=5;
      else if(per<0.75)
      quad=3;
      else
      quad=4;
      canvas.save();
      canvas.translate(0.0,-size.height/2-25.0);
      textPainter.text=new TextSpan(
        style: textStyle,
        text: '$i'
      );
       switch(quad)
      {
        case 2:
        canvas.rotate(-pi/2);
        break;
        case 3:
        case 4:
        canvas.rotate(pi/2);
        break;
        case 5:
        canvas.rotate(pi);
        break;
      }
      //layout of textPainter
      textPainter.layout();
      
      textPainter.paint(
        canvas,
        Offset(-textPainter.width/2, -textPainter.height/2),

      );
      canvas.restore();
    }

    canvas.rotate(2*pi/tick_counter);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}

class DialTurnGestureDetector extends StatefulWidget {

  final child;
  final maxTime;
  final currentTime;
  final Function(Duration) timeSelected;
  final Function(Duration) dialStopTurning;
  DialTurnGestureDetector({this.child,this.maxTime,this.currentTime,this.timeSelected,this.dialStopTurning});
  @override
  _DialTurnGestureDetectorState createState() => _DialTurnGestureDetectorState();
}

class _DialTurnGestureDetectorState extends State<DialTurnGestureDetector> {
  
  PolarCoord startCoord;
  Duration startTime;
  Duration selectedTime;
  _RadialDragStart(PolarCoord coord)
  {
      this.startCoord=coord;
      this.startTime=widget.currentTime;
  }

  _RadialDragEnd()
  {
    widget.dialStopTurning(selectedTime);
    startCoord=null;
    startTime=null;
    selectedTime=null;
  }

  _RadialDragUpdate(PolarCoord coord)
  {
    if(startCoord!=null)
    {
     final anglediff=coord.angle-startCoord.angle;
     final angleper=anglediff/(2*pi);
     final timeInc=(angleper*widget.maxTime.inSeconds).round();
     selectedTime=new Duration(seconds:startTime.inSeconds+timeInc);

     print('newTIme: ${(selectedTime.inMinutes+60)%60}');

     widget.timeSelected(selectedTime);

    }
  }
  @override
  Widget build(BuildContext context) {
    return RadialDragGestureDetector(
       child: widget.child,
       onRadialDragEnd: _RadialDragEnd,
       onRadialDragStart: _RadialDragStart,
       onRadialDragUpdate: _RadialDragUpdate,
    );
  }
}