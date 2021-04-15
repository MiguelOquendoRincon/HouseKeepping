import 'package:flutter/material.dart';

//ignore: must_be_immutable
class RoomListComponent extends StatefulWidget {

  
  TabController myTabController;
  Map rooms;

  RoomListComponent({
    this.myTabController,
    this.rooms,
  });

  @override
  _RoomListComponentState createState() => _RoomListComponentState();
}

class _RoomListComponentState extends State<RoomListComponent> {
   Map rooms;
  
  @override
  Widget build(BuildContext context) {
    rooms = widget.rooms;

    double compHeight =  (rooms['rooms'].length * 60).toDouble();
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      height: compHeight,
      child: _roomList(context)
    );
  }

  

  Widget _roomList(BuildContext context){
    return ListView.builder(
      itemCount: rooms['rooms'].length,
      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return InkWell(
            child: Container(
            margin: EdgeInsets.only(top: 10.0),
            height: 50.0,
            child: Column(
              children: [
                Text(rooms['rooms'][index]['id'], overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(rooms['rooms'][index]['description'])
              ],
            ),
          ),
          onTap: (){
            int index = widget.myTabController.index;
            String id = rooms['rooms'][index]['id'];
            String description = rooms['rooms'][index]['description'];
            List room = [id, description];
            print(index);
            
            if(index == 2) {
              widget.myTabController.animateTo((widget.myTabController.index - 1));
              //Meter en un stream la lista con la informacion de la habitacion escogida
              return room;
            }
          },
        );
      },
    );
  }
}