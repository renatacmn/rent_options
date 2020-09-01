import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rentoptions/features/apartment_photo_view/apartment_photo_view.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const ImageCarousel({this.imageUrls});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentPosition = 0;

  void _viewPhoto() {
    var currentImageUrl = widget.imageUrls[_currentPosition];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApartmentPhotoView(imageUrl: currentImageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    List<Widget> items =
        widget.imageUrls.map((url) => _buildImageCard(url)).toList();
    return CarouselSlider(
      enlargeCenterPage: true,
      height: screenHeight / 2,
      items: items,
      viewportFraction: 0.9,
      enableInfiniteScroll: false,
      onPageChanged: (position) => _currentPosition = position,
    );
  }

  Widget _buildImageCard(String url) {
    return GestureDetector(
      onTap: _viewPhoto,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26)],
          image: DecorationImage(
            image: CachedNetworkImageProvider(url),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }
}
