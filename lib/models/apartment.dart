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
  });

  static Apartment fromRow(List<String> row) {
    if (row.length != 12) return null;
    return Apartment(
      listOrder: int.parse(row[0]),
      id: row[1],
      url: row[2],
      imageUrl: row[3],
      address: row[4],
      price: int.parse(row[5]),
      size: int.parse(row[6]),
      numRooms: double.parse(row[7]),
      distanceRange: row[8].split(',').map((e) => (int.parse(e))).toList(),
      furnished: row[9] == 'Yes' ? true : false,
      observations: row[10] == '-' ? null : row[10],
      tags: row[11] == '-' ? null : row[11].split(','),
    );
  }
}
