
import 'package:house_kepping/src/logic/logic.simulationData.dart';
import 'package:house_kepping/src/models/model.rooms.dart';

/*Here we create and save elements. It simulate a http response */
class PaginationMemory extends RoomListRepositoty{
  @override
  Future<List<Room>> getRooms(int from, int limit) async{
    await Future.delayed(Duration(milliseconds: 1500));
    int indexFrom = from ?? 0;
    return List.generate(limit, (index) => Room(
      position: indexFrom + index + 1,
      idRoom: 'Room ' + (indexFrom + index + 1).toString() + '- 1.0C',
      description: 'Individual - Vacant',
      status: 'Arrived',
      credits: '$index.' + (index/2).toString(),
      guest: 'Miguel Oquendo',
      checkIn: '11/24/20 - 4:40PM',
      checkOut: '11/30/20 - 3:20PM',
      internalStatus: '1'
    ));
  }
}

