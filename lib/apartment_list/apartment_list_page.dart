import 'package:flutter/material.dart';
import 'package:rentoptions/apartment_list/apartment.dart';
import 'package:rentoptions/apartment_list/data.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentListPage extends StatelessWidget {
  static const openMap = 'menu_open_map';
  static const openUrl = 'menu_open_url';
  final _list = hardcodedApartmentList;

  void _showFilterOptions(BuildContext context) {
    Toast.show(
      'Filter',
      context,
      duration: Toast.LENGTH_SHORT,
    );
  }

  void _openMap(BuildContext context, Apartment apartment) {
    Toast.show(
      'View map',
      context,
      duration: Toast.LENGTH_SHORT,
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    print('Open url: $url');
    if (url.isNotEmpty) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Toast.show(
          'Could not launch',
          context,
          duration: Toast.LENGTH_SHORT,
        );
      }
    } else {
      Toast.show(
        'No URL provided for this apartment',
        context,
        duration: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Options'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterOptions(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, position) => _buildListItem(context, position),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int position) {
    var apartment = _list[position];
    return PopupMenuButton(
      child: _buildCardView(apartment),
      itemBuilder: (_) => _buildContextMenu(),
      onSelected: (value) {
        if (value == openMap) {
          _openMap(context, apartment);
        } else if (value == openUrl) {
          _openUrl(context, apartment.url);
        }
      },
    );
  }

  List<PopupMenuItem<String>> _buildContextMenu() {
    return [
      PopupMenuItem(
        value: openMap,
        child: Text('View map'),
      ),
      PopupMenuItem(
        value: openUrl,
        child: Text('Open URL'),
      ),
    ];
  }

  Widget _buildCardView(Apartment apartment) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(apartment.imageUrl, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Color(0x6F000000)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(apartment),
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

  Widget _buildTitleRow(Apartment apartment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            '#${apartment.listOrder} - ${apartment.address}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFurnished(bool furnished) {
    if (furnished) {
      return Text('Furnished');
    } else {
      return Text('Unfurnished');
    }
  }

  Widget _buildSizeRow(Apartment apartment) {
    return Row(
      children: [
        Icon(Icons.straighten, color: Colors.white),
        SizedBox(width: 8),
        Text('${apartment.size} m²'),
        SizedBox(width: 24),
        Icon(Icons.hotel, color: Colors.white),
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
          Icon(Icons.directions_bus, color: Colors.white),
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
