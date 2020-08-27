import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  static Future<List<String>> fetchApartmentImages(String id) async {
    final response = await http.get('https://api.qasa.se/v1/homes/$id');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return HomeResponse.fromJson(json.decode(response.body))
          .homes
          .first
          .uploads
          .where((upload) => upload.uploadType == 'home_picture')
          .map((upload) => upload.url)
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load home details');
    }
  }
}

class HomeResponse {
  List<Homes> homes;

  HomeResponse({this.homes});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    if (json['homes'] != null) {
      homes = new List<Homes>();
      json['homes'].forEach((v) {
        homes.add(new Homes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homes != null) {
      data['homes'] = this.homes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Homes {
  List<Uploads> uploads;

  Homes({this.uploads});

  Homes.fromJson(Map<String, dynamic> json) {
    if (json['uploads'] != null) {
      uploads = new List<Uploads>();
      json['uploads'].forEach((v) {
        uploads.add(new Uploads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uploads != null) {
      data['uploads'] = this.uploads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Uploads {
  String uploadType;
  String url;

  Uploads({this.uploadType, this.url});

  Uploads.fromJson(Map<String, dynamic> json) {
    uploadType = json['uploadType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadType'] = this.uploadType;
    data['url'] = this.url;
    return data;
  }
}
