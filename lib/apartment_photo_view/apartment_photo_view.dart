import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ApartmentPhotoView extends StatelessWidget {
  final String imageUrl;

  const ApartmentPhotoView({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
