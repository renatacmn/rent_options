import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/styles.dart';
import 'package:rentoptions/util/url_util.dart';
import 'package:rentoptions/widgets/price_indicator.dart';
import 'package:rentoptions/widgets/status_indicator.dart';

class ApartmentInfo extends StatelessWidget {
  final Apartment apartment;

  const ApartmentInfo({this.apartment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatus(apartment),
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

  Widget _buildStatus(Apartment apartment) {
    if (apartment.status == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: StatusIndicator(status: apartment.status),
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
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: '${apartment.address}',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  decoration: TextDecoration.underline,
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
          Icon(Icons.check, color: Styles.furnishedIconColor),
          SizedBox(width: 4),
          Text('Furnished'),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.close, color: Styles.unfurnishedIconColor),
          SizedBox(width: 4),
          Text('Unfurnished'),
        ],
      );
    }
  }

  Widget _buildSizeRow(Apartment apartment) {
    return Row(
      children: [
        Icon(Icons.straighten),
        SizedBox(width: 8),
        Text('${apartment.size} m²'),
        SizedBox(width: 24),
        Icon(Icons.hotel),
        SizedBox(width: 8),
        Text('${apartment.numRooms} rooms'),
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
          Icon(Icons.directions_bus),
          SizedBox(width: 8),
          Text(text),
        ],
      );
    }
    return Container();
  }

  Widget _buildObservations(String observations) {
    return observations?.isNotEmpty == true
        ? Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Obs: $observations'),
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
