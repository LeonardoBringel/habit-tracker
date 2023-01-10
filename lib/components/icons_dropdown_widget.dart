import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IconsDropdownWidget extends StatefulWidget {
  IconsDropdownWidget({super.key});

  IconData selectedIcon = Icons.auto_awesome;

  @override
  State<IconsDropdownWidget> createState() => _IconsDropdownWidgetState();
}

class _IconsDropdownWidgetState extends State<IconsDropdownWidget> {
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
    return DropdownButton(
      value: widget.selectedIcon,
      underline: Container(
        height: 2,
        color: Colors.yellow,
      ),
      onChanged: (value) {
        setState(() {
          widget.selectedIcon = value!;
        });
      },
      items: icons.map<DropdownMenuItem>((value) {
        return DropdownMenuItem(
          value: value,
          child: Icon(
            value,
            color: Colors.yellow,
          ),
        );
      }).toList(),
    );
  }
}
