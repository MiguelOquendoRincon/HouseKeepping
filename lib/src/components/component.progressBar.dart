import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

/*This component is use to show the cleaned progress  */
//ignore: must_be_immutable
class ProgressIndicatorComponent extends StatefulWidget {
  String doneTotal;
  double percent;
  String totalRooms;
  ProgressIndicatorComponent({
    this.doneTotal = '0',
    this.percent = 0.0,
    this.totalRooms = '20'
  });
  @override
  _ProgressIndicatorComponentState createState() => _ProgressIndicatorComponentState();
}

class _ProgressIndicatorComponentState extends State<ProgressIndicatorComponent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String percentString = (widget.percent * 100).toStringAsFixed(2);
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Text('MY PROGRESS'),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.doneTotal +' / ' + widget.totalRooms, overflow: TextOverflow.fade,),
                SizedBox(width: 10.0),
                LinearPercentIndicator(
                  width: size.width * 0.7,
                  lineHeight: 15.0,
                  animation: true,
                  animationDuration: 800,
                  linearGradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0E6FF0),
                      Color(0xFF43BCFE)
                    ],
                  ),
                  backgroundColor: Colors.white,
                  percent: widget.percent,
                ),
                SizedBox(width: 10.0),
                Text(percentString + '%', overflow: TextOverflow.fade, maxLines: 2,)
              ],
            ),
          )
        ],
      )
    );
  }
}