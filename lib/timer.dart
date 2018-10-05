import 'dart:async';

class EggTimer{

final Duration maxTime;
final Function onTimerUpdate;
final Stopwatch stopwatch=new Stopwatch();
Duration _currentTime=new Duration(seconds: 0);
Duration lastStartingTime=new Duration(seconds: 0);
TimerState state=TimerState.ready;

EggTimer({this.maxTime,this.onTimerUpdate});
  
get currentTime
{
  return _currentTime;
}

set currentTime(newTime)
{
  if(state==TimerState.ready)
  {
    _currentTime=newTime;
    lastStartingTime=currentTime;
  }
}

resume()
{
 state=TimerState.running;
 stopwatch.start();
 _tick();
}

pause()
{

}

_tick()
{ 
  _currentTime=lastStartingTime-stopwatch.elapsed;
  print(_currentTime.inSeconds);
  if(_currentTime.inSeconds > 0)
  {
    new Timer(const Duration(seconds:1), _tick) ;
  }
  else
  {
    state=TimerState.ready;
    lastStartingTime=new Duration(seconds:0);
    currentTime=new Duration(seconds:0);
  }
  if(onTimerUpdate!=null)
   onTimerUpdate();
}
}

enum TimerState
{
  ready,
  running,
  pause
}