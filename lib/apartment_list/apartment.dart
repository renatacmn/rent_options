class Apartment {
  final String id;
  final int listOrder;
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
}
