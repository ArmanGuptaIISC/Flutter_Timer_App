import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const TimerButton({Key key, this.icon, this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return new FlatButton(
                  splashColor: Colors.grey[80],
                  onPressed: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          icon,
                          color: Colors.black,
                          ),
                        new Text(text,
                        style: new TextStyle(
                          color:Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                        )
                      ],
                    ),
                  ),
                );

  }
}