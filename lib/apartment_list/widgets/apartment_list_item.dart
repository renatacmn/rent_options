import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/apartment_details/apartment_details_page.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/url_util.dart';

class ApartmentListItem extends StatelessWidget {
  final Color iconColor = Colors.tealAccent;

  final Apartment apartment;

  const ApartmentListItem({this.apartment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildCard(context),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApartmentDetailsPage(
            apartment: apartment,
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(apartment.imageUrl, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Color(0x5F000000)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(context, apartment),
                SizedBox(height: 16),
                _buildFurnished(apartment.furnished),
                SizedBox(height: 16),
                _buildSizeRow(apartment),
                SizedBox(height: 16),
                _buildCommutingTimeRow(apartment.distanceRange),
                _buildObservations(apartment.observations),
                _buildTags(apartment.tags),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context, Apartment apartment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: _buildTitle(context, apartment),
        ),
        SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.deepPurple,
          ),
          child: Text(
            '${apartment.price} SEK',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, Apartment apartment) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '#${apartment.listOrder} - ',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: '${apartment.address}',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => openUrl(context, apartment.url),
          ),
        ],
      ),
    );
  }

  Widget _buildFurnished(bool furnished) {
    if (furnished) {
      return Row(
        children: [
          Icon(Icons.check, color: Colors.tealAccent),
          SizedBox(width: 4),
          Text(
            'Furnished',
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.close, color: Colors.redAccent),
          SizedBox(width: 4),
          Text(
            'Unfurnished',
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    }
  }

  Widget _buildSizeRow(Apartment apartment) {
    return Row(
      children: [
        Icon(Icons.straighten, color: iconColor),
        SizedBox(width: 8),
        Text(
          '${apartment.size} m²',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 24),
        Icon(Icons.hotel, color: iconColor),
        SizedBox(width: 8),
        Text(
          '${apartment.numRooms} rooms',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCommutingTimeRow(List<int> distanceRange) {
    if (distanceRange.isNotEmpty) {
      var hasUpperBound = distanceRange.length > 1;
      var text;
      if (hasUpperBound) {
        var first = distanceRange.first;
        var last = distanceRange.last;
        text = '$first ~ $last min to Centralen';
      } else {
        text = '${distanceRange.first} min to Centralen';
      }
      return Row(
        children: [
          Icon(Icons.directions_bus, color: iconColor),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildObservations(String observations) {
    return observations?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Obs: $observations',
              style: TextStyle(color: Colors.white),
            ),
          )
        : Container();
  }

  Widget _buildTags(List<String> tags) {
    if (tags?.isNotEmpty == true) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Wrap(
          spacing: 8,
          children: tags.map((tag) {
            return Chip(
              label: Text(tag),
            );
          }).toList(),
        ),
      );
    }
    return Container();
  }
}
