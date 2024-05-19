import 'package:flutter/material.dart';

class HeaderMobile extends StatelessWidget {
  final VoidCallback onLogoTap;
  final VoidCallback onMenuTap;

  const HeaderMobile({
    required this.onLogoTap,
    required this.onMenuTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          'PixelPulse Coder'
          ),
      backgroundColor: Colors.blue, // Change this color to match your theme
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: onMenuTap,
        ),
      ],
    );
  }
}
