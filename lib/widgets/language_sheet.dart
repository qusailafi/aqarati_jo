import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import '../../../../generated/l10n.dart';
import '../controlers/language/language_controler.dart';

class LanguageSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CacheControler languageController = Get.find();

    final currentLocale = languageController.local.value;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLangCard(
            context,
            title: S.of(context).arabic,
            localeCode: 'ar',
            isSelected: currentLocale == 'ar',
            onTap: () {
              if (currentLocale != 'ar') {
                languageController.setLang(context);
              }
            },
          ),
          const SizedBox(height: 10),
          _buildLangCard(
            context,
            title: S.of(context).english,
            localeCode: 'en',
            isSelected: currentLocale == 'en',
            onTap: () {
              if (currentLocale != 'en') {
                languageController.setLang(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLangCard(BuildContext context,
      {required String title,
        required String localeCode,
        required bool isSelected,
        required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Center(child: Text(title, style: TextStyle(fontSize: 16))),
        trailing: isSelected ? Icon(Icons.check_circle, color: Colors.green) : null,
      ),
    );
  }
}
