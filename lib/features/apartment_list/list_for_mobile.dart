import 'package:flutter/material.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/widgets/apartment_list_item.dart';

class ApartmentListForMobile extends StatelessWidget {
  final List<Apartment> apartmentList;

  const ApartmentListForMobile({this.apartmentList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: apartmentList.length,
      itemBuilder: (context, position) =>
          ApartmentListItem(apartment: apartmentList[position]),
    );
  }
}
