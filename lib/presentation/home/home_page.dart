import 'package:aqarati/presentation/home/properites_details.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controlers/home/home_controler.dart';
import '../../controlers/profolio/profolio_controler.dart';
import '../../data/local/cache_data.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../utils/utils.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/empty_list.dart';
import '../../widgets/login_sheet.dart';
import '../dialogs/categories_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    HomeController homeController = Get.find();

    return Obx(() {
      if (homeController.isLoading.value) {
        return   Container(color: ColorHelper.backround,child: Center(child: CircularProgressIndicator()));
      } else if (controller.message.value.isEmpty) {
        return Scaffold(
          backgroundColor: ColorHelper.backround,
          appBar: AppBar(
            backgroundColor: ColorHelper.backround,
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).open,
                      style: TextStyle(
                        color: _tabController.index == 0
                            ? Colors.black
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: _tabController.index == 0
                            ? Colors.black.withOpacity(0.7)
                            : Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${homeController.data.length}",
                        style: TextStyle(
                          color: _tabController.index == 0
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).funed,
                      style: TextStyle(
                        color: _tabController.index == 1
                            ? Colors.black
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? Colors.black.withOpacity(0.7)
                            : Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${homeController.funded.length}",
                        style: TextStyle(
                          color: _tabController.index == 1
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return CategoryBottomSheet(
                              categories: homeController.categories.value,
                              onCategorySelected: (category) {
                                homeController.selectedCategory.value =
                                    homeController.categories
                                        .indexOf(category)
                                        .toString();
                                if (_tabController.index == 0) {
                                  homeController.data.clear();
                                  homeController
                                      .getAllProperites(category.id.toString());
                                } else {
                                  homeController.funded.clear();
                                  homeController.getFundedProperites(
                                      category.id.toString());
                                }
                              },
                              onClearClick: () {
                                if (_tabController.index == 0) {
                                  homeController.data.clear();
                                  homeController.getAllProperites("");
                                } else {
                                  homeController.funded.clear();
                                  homeController.getFundedProperites("");
                                }
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildListView(homeController, screenHeight, context, 0),
                    buildListView(homeController, screenHeight, context, 1),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(child: errorText(controller.message.value));
      }
    });
  }

  Widget buildListView(HomeController controller, double screenHeight,
      BuildContext context, int index) {
    var data = index == 1 ? controller.funded : controller.data;

    if (data.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: data.length,
        itemBuilder: (context, i) {//
          final property = data[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: cardWidget(context,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async {
                    bool isLogin =
                    await CacheDataManager.getBoolean(Utils.IS_LOGIN);
                    if (isLogin) {
                      Get.to(ProperitesDetails(
                        data: property,
                        isOpen: index == 0,
                      ));
                    } else {
                      showLoginSheet(context);
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: screenHeight / 4,
                        width: double.infinity,
                        child: PropertyImagePager(
                            property: property, screenHeight: screenHeight),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          property.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _InfoIcon(
                              "rooms.png",
                              property.rooms?.toString() ?? "0",
                            ),
                            const SizedBox(width: 6),
                            _InfoIcon(
                              "bath_room.png",

                              property.bathrooms?.toString() ?? "0",
                            ),
                            const SizedBox(width: 6),
                            _InfoIcon(
                              "area.png",
                              property.area?.toString() ?? "0",
                            ),
                          ],
                        ),
                      ),
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).aed,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4.0),
                                    child: Text(
                                      "${property.basePrice ?? ''}",
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(property.progressPercentage.toString()+" % "+S.of(context).funed),

                        ],
                      ),
                       Row(
                         children: [
                           SizedBox(width: 5,),
                           Expanded(
                             child: LinearProgressIndicator(
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(10),
                              value: property.progressPercentage!/100,
                              backgroundColor:   ColorHelper.pr,
                              valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.black),
                                                   ),
                           ),
                         ],
                       ),

                    ],
                  ),
                ),
              ),null,
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(S.of(context).no_properites),
      );
    }
  }
}

class PropertyImagePager extends StatefulWidget {
  final dynamic property;
  final double screenHeight;

  const PropertyImagePager({
    super.key,
    required this.property,
    required this.screenHeight,
  });

  @override
  State<PropertyImagePager> createState() => _PropertyImagePagerState();
}

class _PropertyImagePagerState extends State<PropertyImagePager> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.property.images ?? [];
    final progress = widget.property.progressPercentage ?? 0;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: images.isNotEmpty
              ? PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, imgIndex) {
              final imageUrl =
                  Utils.IMAGE_PATH + (images[imgIndex].imageUrl ?? "");
              return Image.network(
                imageUrl,
                height: widget.screenHeight / 4,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                ),
              );
            },
          )
              : Container(
            height: widget.screenHeight / 4,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.image_not_supported),
          ),
        ),
        if (images.isNotEmpty)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "${_currentPage + 1} / ${images.length}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                S.of(context).open,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "${S.of(context).funed}$progress%",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
class _InfoIcon extends StatelessWidget {
  final String icon;
  final String value;

  const _InfoIcon(this.icon, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ColorHelper.pr, // خلفية رمادية فاتحة جدًا
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(width: 10,height: 10,
            child: Image.asset(Utils.getImgePath(icon)

            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: ColorHelper.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
