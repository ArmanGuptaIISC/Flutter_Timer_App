import 'package:flutter/material.dart';
import 'package:flutter_timer/timer.dart';
import 'package:intl/intl.dart';
class TimerTime extends StatefulWidget {
  final TimerState eggTimerstate;
  final selectionTime;
  final countDownTime;
  TimerTime({this.eggTimerstate
  ,this.selectionTime=const Duration(seconds:0)
  ,this.countDownTime=const Duration(seconds:0)});
  @override
  _TimerTimeState createState() => _TimerTimeState();
}

class _TimerTimeState extends State<TimerTime> with TickerProviderStateMixin {
  final DateFormat selectionTimeFormat=new DateFormat("mm");
  final DateFormat countDownFormat=new DateFormat("mm:ss");
  AnimationController selectAnimationController,countAnimationController;
  get _formattedSelectedTime{
    DateTime dateTime=new DateTime(DateTime.now().year,0,0,0,0,widget.selectionTime.inSeconds);
    return selectionTimeFormat.format(dateTime);
  }

  get _formattedCoundTime{
    DateTime dateTime=new DateTime(DateTime.now().year,0,0,0,0,widget.countDownTime.inSeconds);
    return countDownFormat.format(dateTime);
  }


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      selectAnimationController=new AnimationController(vsync: this,duration: const Duration(milliseconds: 150))
      ..addListener((){
        setState((){});
      });

      countAnimationController=new AnimationController(vsync: this,duration: const Duration(microseconds: 150))..addListener((){
        setState((){});
      });
      countAnimationController.value=1.0;
    }

    
  @override
  Widget build(BuildContext context) {
     
    if(widget.eggTimerstate==TimerState.ready){
      countAnimationController.forward();
      selectAnimationController.reverse();
    }
    else{
      countAnimationController.reverse();
      selectAnimationController.forward();
    }
    return new Padding(
                padding:const EdgeInsets.only(top:30.0) ,
                child: Stack(
                  alignment: Alignment.center,
                  children:[Transform(
                    transform: new Matrix4.translationValues(0.0, 
                    -200.0*selectAnimationController.value, 
                    0.0),
                    child: new Text(
                      _formattedSelectedTime,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 90.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BebasNeue",
                        letterSpacing: 5.0,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity:1.0 -countAnimationController.value ,
                    child: new Text(
                      _formattedCoundTime,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 90.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BebasNeue",
                        letterSpacing: 5.0,
                      ),
                    ),
                  ),] 
                ),
                );
  }
}