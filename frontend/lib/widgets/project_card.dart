import 'package:flutter/material.dart';


import 'package:frontend/utils/project_utils.dart';
import '../constants/colors.dart';


class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({
    Key? key,
    required this.project,
  }) : super(key: key);

  final ProjectUtils project;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 304, // Adjusted height to accommodate padding
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColor.bgLight2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Project image
          Image.asset(
            project.image,
            height: 140,
            width: 260,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
            child: Text(
              project.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColor.textFieldBg,
              ),
            ),
          ),
          // Subtitle
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              project.subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: CustomColor.textFieldBg,
              ),
            ),
          ),
          const Spacer(),
          // Footer
          Container(
            padding: const EdgeInsets.only(bottom: 10), // Add padding at the bottom
            color: CustomColor.bgLight1,
            child: Row(
              children: [
                const Text(
                  "Available on: ",
                  style: TextStyle(
                    color: CustomColor.bluePrimary,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                // Icons for different platforms
                if (project.iosLink != null)
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/ios_icon.png",
                      width: 17,
                    ),
                  ),
                if (project.androidLink != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/android_icon.png",
                        width: 17,
                      ),
                    ),
                  ),
                if (project.webLink != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/web_icon.png",
                        width: 17,
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}