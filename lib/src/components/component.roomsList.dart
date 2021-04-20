
import 'package:flutter/material.dart';
import 'package:house_kepping/src/logic/logic.paginationLogic.dart';

/*This component recive the tabController to know the index, logic to get the rooms info and the list of cleaned rooms to validate
  if some room has been cleaned before */

//ignore: must_be_immutable
class RoomListComponent extends StatefulWidget {
  TabController myTabController;
  PaginationLogic logic;
  List cleanedRooms;

  RoomListComponent({
    this.myTabController,
    this.logic,
    this.cleanedRooms
  });

  @override
  _RoomListComponentState createState() => _RoomListComponentState();
}

class _RoomListComponentState extends State<RoomListComponent> {
  PaginationLogic logic;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    logic = widget.logic;
    //We calculate exactly  container's height. Each element has 90.0 px so we multiplicate for the items length
    double compHeight =  (logic.items.length * 90).toDouble();
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      height: compHeight,
      child: _roomList(context)
    );
  }


  Widget _roomList(BuildContext context){
    return ListView.builder(
      itemCount: logic.items.length,
      physics: ClampingScrollPhysics(),
      itemBuilder: (_, index) {
        final item = logic.items[index];
        return InkWell(
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            height: 80.0,
            child: Column(
              children: [
                Divider(),
                Text(item.idRoom, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(item.description),
              ],
            ),
          ),
          onTap: (){
            int indexTab = widget.myTabController.index;
            if(indexTab == 2) {
              bool repeated = false;
              if(widget.cleanedRooms.length != 0){
                widget.cleanedRooms.forEach((room) {
                  if(room['idRoom'] == item.idRoom){
                    repeated = true;
                    return _showAlert();
                  }
                });
              }
              if(!repeated){
                logic.setRoom(item);
                widget.myTabController.animateTo((widget.myTabController.index - 1));
              }
            }
          },
        );
      },
    );
  }

  _showAlert(){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Container(
                height: size.height * 0.16,
                child: Image(image: AssetImage('assets/ups.jpg')),
              ),
              SizedBox(height: size.height * 0.05),
              Text('Ups! You can´t clean the same room twice',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
          content: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFF8B83E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.06,
              child: Text('OK',
                  style:TextStyle(color: Colors.white)),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        );
      }
    );
  }
}