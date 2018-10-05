import 'package:flutter/material.dart';
import 'package:flutter_timer/Timer_button.dart';

class TimerButtonControl extends StatefulWidget {
  @override
  _TimerButtonControlState createState() => _TimerButtonControlState();
}

class _TimerButtonControlState extends State<TimerButtonControl> {
  @override
  Widget build(BuildContext context) {
    return new Column(
                  children:<Widget>[
                   new Row(
                   children: <Widget>[
                     new TimerButton(
                       icon:Icons.refresh,
                       text:"RESTART"
                     ),
                     new Expanded(child:new Container()),
                     new TimerButton(
                       text:"RESET" ,
                       icon: Icons.arrow_back,
                       )
                   ],
                ),
                new TimerButton(
                icon: Icons.pause,
                text: "PAUSE",
              )
              ] 

              );
  }
}