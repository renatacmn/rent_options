import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/apartment_details/apartment_details_page.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/url_util.dart';

class ApartmentListItem extends StatelessWidget {
  final Color iconColor = Colors.teal;
  final Color furnishedIconColor = Colors.teal;
  final Color unfurnishedIconColor = Colors.redAccent;
  final Color textColor = Colors.black87;

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
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26)],
              image: DecorationImage(
                image: NetworkImage(apartment.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _buildApartmentInfo(context),
          ),
        ],
      ),
    );
  }

  Column _buildApartmentInfo(BuildContext context) {
    return Column(
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
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: '${apartment.address}',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  decoration: TextDecoration.underline,
                  color: textColor,
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
          Icon(Icons.check, color: furnishedIconColor),
          SizedBox(width: 4),
          Text(
            'Furnished',
            style: TextStyle(color: textColor),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.close, color: unfurnishedIconColor),
          SizedBox(width: 4),
          Text(
            'Unfurnished',
            style: TextStyle(color: textColor),
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
          style: TextStyle(color: textColor),
        ),
        SizedBox(width: 24),
        Icon(Icons.hotel, color: iconColor),
        SizedBox(width: 8),
        Text(
          '${apartment.numRooms} rooms',
          style: TextStyle(color: textColor),
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
            style: TextStyle(color: textColor),
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
              style: TextStyle(color: textColor),
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
