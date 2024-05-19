import 'package:flutter/material.dart';
import '../constants/colors.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 30.0,
      ),
      height: screenHeight * 0.7, // Increase the height
      constraints: BoxConstraints(
        minHeight: 300.0, // Increase the minimum height
        maxWidth: screenWidth * 0.9, // Increase the width
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // avatar img
          Image.asset(
            "assets/avatar.png",
            width: screenWidth,
          ),
          const SizedBox(height: 30),
          // intro message
          const Text(
            "Hi,\nI'm Ngoc Huyen\nA Flutter Developer",
            style: TextStyle(
              fontSize: 24,
              height: 1.5,
              color: CustomColor.textFieldBg,
            ),
          ),
          const SizedBox(height: 15),
          // contact btn
          SizedBox(
            width: 190.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: CustomColor.bluePrimary,
              ),
              child: const Text("Contact Me"),
            ),
          )
        ],
      ),
    );
  }
}
