import 'package:flutter/material.dart';
import 'package:flutter_timer/Timer_button_controls.dart';
import 'package:flutter_timer/Timer_time.dart';
import 'package:flutter_timer/timer.dart';
import 'package:flutter_timer/timer_dial.dart';

final Color GRAD_TOP=const Color(0xFFF5F5F5);
final Color GRAD_BOTTOM=const Color(0xFFE8E8E8);
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title:"Flutter Timer" ,
     home: HomePage(),
     theme: new ThemeData(
       accentColor: Colors.teal,
       primarySwatch: Colors.blue,
       brightness: Brightness.light
     ),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  EggTimer eggtimer;
  _HomePageState()
  {
    eggtimer=new EggTimer(maxTime: const Duration(minutes:60),onTimerUpdate: (){
    setState(() {
          
        });
  });
  }

  void _timeSelected(Duration newTime)
  {
    setState(() {
          eggtimer.currentTime=newTime;
        });
  }

  _onDialStopTurning(Duration newTime)
  {
    setState(() {
          eggtimer.currentTime=newTime;
          eggtimer.resume();
        });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       body: new Container( 
          decoration: new BoxDecoration(
            gradient: LinearGradient(begin:Alignment.topCenter,end: Alignment.bottomCenter,colors: [GRAD_TOP,GRAD_BOTTOM]),
          ),
          child: Center(
           child: new Column(
             children: <Widget>[
                  
                new TimerTime(
                  eggTimerstate: eggtimer.state,
                  selectionTime:  eggtimer.lastStartingTime,
                  countDownTime: eggtimer.currentTime,
                  ),
                new TimerDial(
                  maxTime: eggtimer.maxTime,
                  currentTime: eggtimer.currentTime,
                  tickPerSegment: 5,
                  onTimeSelected:_timeSelected,
                  dialStopTurning:_onDialStopTurning,
                ),
                new Expanded( child: new Container(),),
                new TimerButtonControl()
               
             ],
           ),
         ),
       ),
    );
  }
}