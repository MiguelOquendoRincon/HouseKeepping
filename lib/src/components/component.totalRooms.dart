import 'package:flutter/material.dart';

/*This component receive totalRooms and render it. */
//ignore: must_be_immutable
class TotalRoomsComponent extends StatefulWidget {
  int totalRooms;
  TotalRoomsComponent({
    this.totalRooms = 0,
  });

  @override
  _TotalRoomsComponentState createState() => _TotalRoomsComponentState();
}

class _TotalRoomsComponentState extends State<TotalRoomsComponent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: size.width * 0.9,
      height: 90.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color(0xFFBEC2C5)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Rooms', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0, color: Color(0xFF8C8C8C))),
          Text(widget.totalRooms.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0),)
        ],
      )
    );
  }
}