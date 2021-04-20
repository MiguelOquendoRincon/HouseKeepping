import 'dart:async';
import 'package:flutter/material.dart';
import 'package:house_kepping/src/preferences/preferences.dart';

/*This component receive the stopwatch info and save the total time expend in some room */
class TimerText extends StatefulWidget {
  final Stopwatch stopwatch;

  TimerText({this.stopwatch});

  TimerTextState createState() => new TimerTextState(stopwatch: stopwatch);
}

class TimerTextState extends State<TimerText> {

  Timer timer;
  final Stopwatch stopwatch;
  final prefs = new UserPreferences();

  TimerTextState({this.stopwatch}) {
    timer = Timer.periodic(Duration(milliseconds: 30), callback);
  }
  
  void callback(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle timerTextStyle = TextStyle(fontSize: 60.0, fontFamily: "Open Sans");
    String time = stopwatch.elapsed.toString();
    List formattedTimeList = time.split(':');
    String seconds = formattedTimeList[2].split('.')[0];
    String formattedTime = formattedTimeList[1] +  ':' + seconds;
    prefs.totalTime = formattedTime;
    return Text(formattedTime, style: timerTextStyle);
  }
}