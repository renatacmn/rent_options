import 'package:flutter/material.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/widgets/apartment_list_item.dart';

class ApartmentListForWeb extends StatelessWidget {
  final List<Apartment> apartmentList;

  const ApartmentListForWeb({this.apartmentList});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var children = apartmentList
        .map((apartment) => ApartmentListItem(apartment: apartment))
        .toList();

    return GridView.count(
      crossAxisCount: getCrossAxisCount(screenWidth),
      shrinkWrap: true,
      childAspectRatio: getChildAspectRatio(screenWidth),
      children: children,
    );
  }

  /// Returns the number of columns based on the screen width.
  /// All the numbers were chosen by trial and error.
  int getCrossAxisCount(double screenWidth) {
    if (screenWidth <= 700) {
      return 1;
    } else if (screenWidth >= 1000) {
      return 3;
    }
    return 2;
  }

  /// Returns the child aspect ratio based on the screen width.
  /// All the numbers were chosen by trial and error.
  double getChildAspectRatio(double screenWidth) {
    if (screenWidth <= 700) {
      return screenWidth / 600;
    } else if (screenWidth >= 1000) {
      return screenWidth / 2000;
    }
    return screenWidth / 1400;
  }
}
