import 'package:house_kepping/src/logic/logic.paginationImpl.dart';
import 'package:test/test.dart';

void main() {
  group('ListGenerate', () {
    test('List.length must be 5', () async{
      final pagination = PaginationMemory();
      final roomList = await pagination.getRooms(0, 5);
      expect(roomList.length, 5);
    });

    test('List.length must be 10', () async{
      final pagination = PaginationMemory();
      final roomList = await pagination.getRooms(5, 10);
      expect(roomList.length, 10);
    });

    test('List.length must be equal to until', () async{
      final pagination = PaginationMemory();
      int until = 50;
      int from = (until - 5);
      final roomList = await pagination.getRooms(from, until);
      expect(roomList.length, until);
    });
  });
}