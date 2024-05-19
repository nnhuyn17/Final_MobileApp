import 'package:flutter/cupertino.dart';
import 'package:frontend/widgets/project_card.dart';

import '../constants/colors.dart';
import '../utils/project_utils.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return  Container(
      width: screenWidth,
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),

      child: Column(
        children: [
          // Work projects title
          const Text(
            "Work Projects",
            style: TextStyle(
              fontSize: 24,
              color: CustomColor.textFieldBg,
            ),
          ),
          const SizedBox(
              height: 50
          ),
          //Work projects cards
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 25,
              runSpacing: 25,
              children: [
                for(int i=0; i<workProjectUtils.length;i++)
                  ProjectCardWidget(
                    project: workProjectUtils[i],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          // Hobby Projects title
          const Text(
            "Hobby Projects",
            style: TextStyle(
              fontSize: 24,
              color: CustomColor.textFieldBg,
            ),
          ),
          const SizedBox(
              height: 50
          ),
          // Hobby projects cards
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 25,
              runSpacing: 25,
              children: [
                for(int i=0; i<hobbyProjectUtils.length;i++)
                  ProjectCardWidget(
                    project: hobbyProjectUtils[i],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}