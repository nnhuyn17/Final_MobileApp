class ProjectUtils {
  final String image;
  final String title;
  final String subtitle;
  final String? androidLink;
  final String? iosLink;
  final String? webLink;

  ProjectUtils({
    required this.image,
    required this.title,
    required this.subtitle,
    this.androidLink,
    this.iosLink,
    this.webLink,

  });

}


// HOBBY PROJECTS
List<ProjectUtils> hobbyProjectUtils = [
  ProjectUtils(
    image: 'assets/projects/1.png',
    title: 'English Learning App',
    subtitle:
    'This is a comprehensive English learning app for practicing and mastering language skills',
    androidLink:
    'https://play.google.com/store/apps/details?id=com.busuu.android.enc&hl=vi&gl=US',
  ),
  ProjectUtils(
    image: 'assets/projects/3.png',
    title: 'English Dictionary App',
    subtitle:
    'This is a dictionary app for English learners to easily enhance your vocabulary',
    androidLink:
    'https://play.google.com/store/apps/details?id=com.busuu.android.enc&hl=vi&gl=US',
    iosLink:
    'https://apps.apple.com/us/app/busuu-language-learning/id379968583',
  ),
  ProjectUtils(
    image: 'assets/projects/2.png',
    title: 'English Dictionary App',
    subtitle:
    'This is a dictionary app for English learners to easily enhance their vocabulary, improve their language skills through a user-friendly.',
    androidLink:
    'https://play.google.com/store/apps/details?id=com.mobisystems.msdict.embedded.wireless.oxford.dictionaryofenglish&hl=vi&gl=US',
    iosLink:
    'https://apps.apple.com/us/app/oxford-dictionary/id978674211',
  ),
  ProjectUtils(
    image: 'assets/projects/4.png',
    title: 'Candy Crush Saga App',
    subtitle:
    'Play Candy Crush Saga online at King.com! Switch and match your way through hundreds of tasty levels in this divine puzzle game! Sweet!',
    androidLink:
    'https://play.google.com/store/apps/details?id=com.king.candycrushsaga&hl=vi&gl=US',
    iosLink:
    'https://apps.apple.com/us/app/candy-crush-saga/id553834731',
  ),
  ProjectUtils(
    image: 'assets/projects/5.png',
    title: 'bTaskee App',
    subtitle:
    'bTaskee là ứng dụng gia đình số 1 tại Việt Nam với hơn 16 dịch vụ tiện ích, giúp kết nối nhu cầu nội trợ của Khách hàng với những chuyên gia giúp việc.',
    androidLink:
    'https://play.google.com/store/apps/details?id=com.lanterns.btaskee&hl=vi&gl=US',
    iosLink:
    'https://apps.apple.com/vn/app/btaskee-ti%E1%BB%87n-%C3%ADch-gia-%C4%91%C3%ACnh/id1054302942?l=vi',
  ),
  ProjectUtils(
    image: 'assets/projects/6.png',
    title: 'Sticky Me App',
    subtitle:
    'StickMe Notes is a notepad & memo app which makes note taking easy. Use memo notes to capture ideas on the fly, create to-do lists & tasks list',
    androidLink:
    'https://play.google.com/store/apps/details?id=com.fiestalabs.marky&hl=en_US',
    iosLink:
    'https://apps.apple.com/in/app/stickme-notes-sticky-notes-app/id608937293',
  ),
];
List <ProjectUtils> workProjectUtils = [
  ProjectUtils(
    image: 'assets/projects/w01.png',
    title: 'My Shop Haravan',
    subtitle:
    'This is a responsive online shop web application designed to provide a seamless and engaging shopping experience across all devices. ',
    webLink:
    'https://fashion-shop.myharavan.com/',
  ),
  ProjectUtils(
    image: 'assets/projects/w02.png',
    title: 'Apple Pay',
    subtitle:
    'Apple Pay enables you to make purchases in stores, within apps, and online with just a touch or a glance.',
    webLink:
    'https://www.apple.com/vn/apple-pay/',
  ),
  ProjectUtils(
    image: 'assets/projects/w03.png',
    title: 'Advertisement Management System',
    subtitle:
    'This is a profit analytics for Amazon sellers to analyze profits accurately. ',
    webLink:
    'https://sellerboard.com/',
  ),
];