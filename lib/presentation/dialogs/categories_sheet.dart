
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controlers/home/home_controler.dart';
import '../../domain/categories.dart';
import '../../generated/l10n.dart';
import '../../utils/color_helper.dart';
import '../../widgets/card_widget.dart';

class CategoryBottomSheet extends StatelessWidget {
  final List<DataCategories> categories;
  final Function(DataCategories) onCategorySelected;
  final Function() onClearClick;

  const CategoryBottomSheet({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    required this.onClearClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(Get.context!).select_category,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  InkWell(
                    onTap: () {
                      homeController.selectedCategory.value="";
                      onClearClick();
                      Navigator.pop(context);
                    },
                    child:   Text(
        S.of(Get.context!).reset,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categories.map((category) {
                      final index = categories.indexOf(category);
                      bool isSelected = index.toString() ==
                          homeController.selectedCategory.value;

                       double cardWidth =
                          (category.name?.length ?? 0) * 8.0 + 60;
                      cardWidth = cardWidth.clamp(100, 200);

                      return GestureDetector(
                        onTap: () {
                          onCategorySelected(category);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: cardWidth,
                          height: 45,
                          child: cardWidget(
                            context,
                            Center(
                              child: Text(
                                category.name ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            null,
                            cardColor:
                            isSelected ? Colors.blue : Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
