import 'package:rentoptions/models/status.dart';
import 'package:rentoptions/util/extensions.dart';

class Apartment {
  final int listOrder;
  final String id;
  final String url;
  final String imageUrl;
  final String address;
  final int price;
  final int size;
  final double numRooms;
  final List<int> distanceRange;
  final bool furnished;
  final String observations;
  final List<String> tags;
  final Status status;

  Apartment({
    this.id,
    this.listOrder,
    this.url,
    this.imageUrl,
    this.address,
    this.price,
    this.size,
    this.numRooms,
    this.distanceRange,
    this.furnished,
    this.observations,
    this.tags,
    this.status,
  });

  static Apartment fromRow(List<String> row) {
    return Apartment(
      listOrder: row.getOrNull(0)?.toInt(),
      id: row.getOrNull(1),
      url: row.getOrNull(2),
      imageUrl: row.getOrNull(3),
      address: row.getOrNull(4),
      price: row.getOrNull(5)?.toInt(),
      size: row.getOrNull(6)?.toInt(),
      numRooms: row.getOrNull(7)?.toDouble(),
      distanceRange:
          row.getOrNull(8)?.split(',')?.map((e) => (e.toInt()))?.toList(),
      furnished: row.getOrNull(9) == 'Yes' ? true : false,
      observations: row.getOrNull(10),
      tags: row.getOrNull(11)?.split(','),
      status: Status.fromValues(
        name: row.getOrNull(12),
        notes: row.getOrNull(13),
      ),
    );
  }
}
