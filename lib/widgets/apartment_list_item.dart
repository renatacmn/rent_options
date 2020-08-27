import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/features/apartment_details/apartment_details_page.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/widgets/apartment_info.dart';
import 'package:rentoptions/widgets/translucent_card.dart';

class ApartmentListItem extends StatelessWidget {
  final Apartment apartment;

  const ApartmentListItem({this.apartment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildTranslucentCard(),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApartmentDetailsPage(apartment: apartment),
        ),
      ),
    );
  }

  Widget _buildTranslucentCard() {
    return TranslucentCard(
      child: Column(
        children: [
          _buildImage(),
          _buildApartmentInfo(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: 8,
      ),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26)],
        image: DecorationImage(
          image: CachedNetworkImageProvider(apartment.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildApartmentInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ApartmentInfo(apartment: apartment),
    );
  }
}
