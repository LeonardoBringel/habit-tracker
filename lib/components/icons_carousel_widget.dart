import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconsCarouselWidget extends StatefulWidget {
  IconsCarouselWidget({super.key});

  IconData selectedIcon = Icons.auto_awesome;

  @override
  State<IconsCarouselWidget> createState() => _IconsCarouselWidgetState();
}

class _IconsCarouselWidgetState extends State<IconsCarouselWidget> {
  final List<IconData> icons = const [
    Icons.auto_awesome,
    Icons.school,
    Icons.favorite_rounded,
    Icons.rocket_launch_rounded,
    Icons.restaurant,
    Icons.music_note,
    Icons.pets,
    Icons.do_not_disturb_alt,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: icons.length,
      itemBuilder: (context, index, realIndex) => Icon(
        icons[index],
        size: 50,
        color: Colors.yellow,
      ),
      options: CarouselOptions(
        initialPage: icons.indexOf(widget.selectedIcon),
        height: 50,
        viewportFraction: 0.25,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        onPageChanged: (index, reason) {
          widget.selectedIcon = icons[index];
        },
      ),
    );
  }
}
