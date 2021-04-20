import 'package:house_kepping/src/models/model.rooms.dart';

/*This class call the method getRooms. It's abstract because it only call the method but it not have the implementation */
abstract class RoomListRepositoty{
  Future<List<Room>> getRooms(int from, int limit);
}