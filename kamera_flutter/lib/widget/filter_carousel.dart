import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kamera_flutter/widget/filter_selector.dart';

@immutable
class PhotoFilterCarousel extends StatefulWidget {
  const PhotoFilterCarousel({super.key, required this.imagePath});

final String imagePath;
  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}


class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];


  final _filterColor = ValueNotifier<Color>(Colors.white);


  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }


  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        // Anda bisa ganti dengan foto Anda sendiri
        return Image.file(File(widget.imagePath),
          color: color,
          colorBlendMode: BlendMode.color,
          fit: BoxFit.cover,
        );
      },
    );
  }


  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
