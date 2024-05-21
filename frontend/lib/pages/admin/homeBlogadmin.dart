import 'package:flutter/material.dart';
import 'package:frontend/widgets/contact_section.dart';
import 'package:frontend/widgets/projects_section.dart';
import '../../constants/colors.dart';
import '../../constants/size.dart';
import '../../widgets/drawer_mobile.dart';
import '../../widgets/footer.dart';
import '../../widgets/header_desktop.dart';
import '../../widgets/main_desktop.dart';
import '../../widgets/main_mobile.dart';
import '../../widgets/skill_desktop.dart';
import '../../widgets/skills_mobile.dart';


class HomeBlogAd extends StatefulWidget {
  const HomeBlogAd({Key? key}) : super(key: key);
  static String routeName = "/homeBlog_admin";
  @override
  _HomeBlogAdState createState() => _HomeBlogAdState();
}

class _HomeBlogAdState extends State<HomeBlogAd> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          endDrawer: constraints.maxWidth >= kMinDesktopWidth
              ? null
              : DrawerMobile(
            onNavItemTap: (int navIndex) {
              // call function
              scaffoldKey.currentState?.closeEndDrawer();
              scrollToSection(navIndex);
            },
          ),
          appBar: constraints.maxWidth >= kMinDesktopWidth
              ? null
              : AppBar(
            title: const Text('PixelPulse Coder'),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(key: navbarKeys.first),
                // Header
                if (constraints.maxWidth >= kMinDesktopWidth)
                  HeaderDesktop(
                    onNavMenuTap: (int navIndex) {
                      // call function
                      scrollToSection(navIndex);
                    },
                  ),
                // else
                //   HeaderMobile(
                //     onLogoTap: () {},
                //     onMenuTap: () {
                //       scaffoldKey.currentState?.openEndDrawer();
                //     },
                //   ),
                // Main content
                if (constraints.maxWidth >= kMinDesktopWidth)
                  const MainDesktop()
                else
                  const MainMobile(),
                const Divider(), // Divider between main content and skills
                // SKILLS
                Container(
                  key: navbarKeys[1],
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "What I can do ?",
                        style: TextStyle(
                          fontSize: 24,
                          color: CustomColor.textFieldBg,
                        ),
                      ),
                      const SizedBox(height: 50),
                      if (constraints.maxWidth >= kMedDesktopWidth)
                        const SkillsDesktop()
                      else
                        const SkillsMobile(),
                    ],
                  ),
                ),
                const Divider(), // Divider between skills and projects
                const SizedBox(height: 30),
                // PROJECTS
                ProjectSection(key: navbarKeys[2]),
                const Divider(), // Divider between projects and contact
                const SizedBox(height: 30),
                // CONTACT
                ContactSection(key: navbarKeys[3]),
                const SizedBox(height: 30),
                // FOOTER
                const Footer(),
              ],
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      // open a blog page
      // js.context.callMethod('open', [SnsLinks.blog]);
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}