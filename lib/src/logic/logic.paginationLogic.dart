import 'package:house_kepping/src/logic/logic.paginationImpl.dart';
import 'package:house_kepping/src/logic/logic.simulationData.dart';
import 'package:house_kepping/src/models/model.rooms.dart';
import 'package:flutter/material.dart';

/*This class is called when we want to load more info. It simulate a pagination */
class PaginationLogic extends ChangeNotifier{

  List<Room> items;
  Room room;
  bool loading = false;
  final RoomListRepositoty paginationRepositoty = PaginationMemory();

  void loadData(int from, int limit) async{
    loading = true;
    notifyListeners();


    //Get data
    //Initialize the list
    if(items == null) items = [];

    //get Room's data and asiggned it to items list.
    final result = await paginationRepositoty.getRooms(from, limit);
    items.addAll(result);


    loading = false;
    notifyListeners();
  }

  // void setRoom(String roomSelected){
  //   room ?? '';
  //   room = roomSelected;
  //   notifyListeners();
  // }

  void setRoom(Room roomSelected){
    room = roomSelected;
    notifyListeners();
  }

  void resetRoom() => room = null;
}