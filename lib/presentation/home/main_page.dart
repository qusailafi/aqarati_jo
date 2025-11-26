
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controlers/home/home_controler.dart';
import '../../data/local/cache_data.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/language_sheet.dart';
import '../../utils/color_helper.dart';
import '../invesments_screen.dart';
import '../portfolio/portfolio_screen.dart';
import '../splash/splash_screen.dart';
import '../user_mangment/profile/user_profile.dart';
import '../walet/walet_screen.dart';
import 'home_page.dart';

class MainView extends StatelessWidget {
  List<Widget>? _pages;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    _pages = [
      HomeScreen(),
      PortFolioScreen(),
      WaletScreen(),
      UserProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: ColorHelper.backround,
      appBar: AppBar(
        backgroundColor: ColorHelper.backround,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Obx(() {
          return Text(controller.title.value, style: const TextStyle(color: Colors.black));
        }),
        actions: const [
          Icon(Icons.notifications, color: Colors.black),
        ],
      ),
      drawer: Drawer(
        backgroundColor: ColorHelper.backround,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: ColorHelper.primaryColor),
              child: Text(
                S.of(context).welcome,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Image.asset(Utils.getImgePath("my_properites.png"), width: 30, height: 30),
              title: Text(S.of(context).properites),
              onTap: () {
                Get.to(InvestmentsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(S.of(context).change_language),
              onTap: () {
                Get.bottomSheet(
                  LanguageSheet(),
                  backgroundColor: Colors.white,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(S.of(context).logout),
              onTap: () async {
                await Utils.clearSharedPrefs();
                await CacheDataManager.putBooleanData(Utils.IS_LOGIN, false);
                Get.offAll(() => SplashPage());
              },
            ),
          ],
        ),
      ),
      body: Obx(() => _pages![controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        return Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white, // خلفية الـ BottomNavigationBar
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 5),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.changeIndex,
              backgroundColor: Colors.white, // لون الخلفية ثابت
              selectedItemColor: ColorHelper.primaryColor, // لون العنصر المحدد
              unselectedItemColor: Colors.grey, // لون العناصر غير المحددة
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: S.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.dashboard),
                  label: S.of(context).dashboard,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.wallet),
                  label: S.of(context).walet,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: S.of(context).profile,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
