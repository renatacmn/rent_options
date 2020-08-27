import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/url_util.dart';
import 'package:rentoptions/widgets/price_indicator.dart';
import 'package:rentoptions/widgets/status_indicator.dart';

class ApartmentInfo extends StatelessWidget {
  static const Color iconColor = Colors.teal;
  static const Color furnishedIconColor = Colors.teal;
  static const Color unfurnishedIconColor = Colors.redAccent;
  static const Color textColor = Colors.black87;

  final Apartment apartment;

  const ApartmentInfo({this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusIndicator(status: apartment.status),
        SizedBox(height: 16),
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
        Flexible(child: _buildTitle(context, apartment)),
        SizedBox(width: 16),
        PriceIndicator(price: '${apartment.price} SEK'),
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
          Text('Furnished', style: TextStyle(color: textColor)),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.close, color: unfurnishedIconColor),
          SizedBox(width: 4),
          Text('Unfurnished', style: TextStyle(color: textColor)),
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
