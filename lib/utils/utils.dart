import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/local/cache_data.dart';
import '../presentation/splash/splash_screen.dart';

class Utils {
  static String BASE_URL = "https://brickstogetherapi.tryasp.net/api/";
  static String IMAGE_PATH = "https://brickstogetherapi.tryasp.net";

  static String TOKEN = "token";
  static String USER_INFO = "user_info";

  static String API_KEY = "AIzaSyCxyO_--XNmAO27km4b5Qpy3MZdKdNJGpg";
  static String POPULARVIDEOS = "videos?";
  static String GET_CATEGORIES = "products/categories";
  static String GET_PRODUCTS = "products";
  static String REELS = "search?";
  static String LANGUAGE = "language";
  static String IS_LOGIN = "IS_LOGIN";
  static String categories = "videoCategories?";
  static String countryCode = "JO";
  static String countryLang = "ar";
static final String stripe_publish_key="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9";
  static String language = "en";

  static String notInterstedIds = "";
  static String currentLang = "en";

  static String timeAgo(String isoDate) {
    final date = DateTime.parse(isoDate);
    final now = DateTime.now().toUtc();
    final diff = now.difference(date);

    if (diff.inDays >= 365) {
      final years = (diff.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 30) {
      final months = (diff.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  static Map<String, String> getReelsParam(
      String query, String lang, String nextPage) {
    Map<String, String> queryParams = {};
    if (lang == 'ar') {
      if (nextPage.isNotEmpty) {
        queryParams = {
          'part': 'snippet',

          'regionCode': countryCode,
          'type': 'video',
          'videoDuration': 'short',
          // "order":"relevance",
          'pageToken': nextPage,
          'maxResults': "50",
          'key': API_KEY
        };
      } else {
        queryParams = {
          'part': 'snippet',
          'regionCode': "JO",
          'type': 'video',
          'videoDuration': 'short',
          // "order":"relevance",

          'maxResults': "50",
          'key': API_KEY
        };
      }
      // if(query.isNotEmpty){
      //   // queryParams ["q"]=query+","+"#شورتات" ;
      //   queryParams ["q"]= query;
      //
      // }
      // else{
      //   queryParams ["q"]= query;
      //
      // }
    } else {
      if (nextPage.isNotEmpty) {
        queryParams = {
          'part': 'snippet',
          'q': query,
          'regionCode': countryCode,
          'type': 'video',
          'videoDuration': 'short',
          // "order":"relevance",
          'pageToken': nextPage,
          'maxResults': "2",
          'key': API_KEY
        };
      } else {
        queryParams = {
          'part': 'snippet',
          'q': query,
          'regionCode': countryCode,
          // 'relevanceLanguage':"ar",
          'type': 'video',
          'videoDuration': 'short',
          // "order":"viewCount",

          'maxResults': "2",
          'key': API_KEY
        };
      }
      // if(query.isNotEmpty){
      //   queryParams ["q"]= query;
      //
      //   // queryParams ["q"]=query+","+"#shorts" ;
      // }
      // else{
      //   queryParams ["q"]= query;
      //
      // }
    }

    return queryParams;
  }

  static Map<String, String> getVieosFillterParams(String fillter) {
    Map<String, String> queryParams = {
      'part': 'snippet',
      'q': fillter,
      'regionCode': countryCode,
      "order": "viewCount",
      "hl": currentLang,
      'key': API_KEY,
      'maxResults': "1000",
      'type': "video"
    };
    return queryParams;
  }

  static Map<String, String> getRelatedVideos(String videoId) {
    Map<String, String> queryParams = {
      'part': 'snippet',
      'relatedToVideoId': '$videoId',
      'regionCode': countryCode,
      'type': 'video',
      'maxResults': '1000',
      // "order": "viewCount",
      'key': API_KEY
    };
    return queryParams;
  }

  static Map<String, String> getSerchScreenParam(
      String query, String nextPage) {
    Map<String, String> queryParams = {};
    if (nextPage.isNotEmpty) {
      queryParams = {
        'part': 'snippet',

        'q': '$query',
        // 'regionCode': countryCode,
        'type': 'video',
        "order": "viewCount",
        'pageToken': nextPage,

        'maxResults': '50',
        'key': API_KEY
      };
    } else {
      queryParams = {
        'part': 'snippet',
        'q': '$query',
        // 'regionCode': countryCode,
        'type': 'video',
        "order": "viewCount",
        'maxResults': '50',
        'key': API_KEY
      };
    }
    return queryParams;
  }

  static Map<String, String> getSerchParam(String query, String nextPage) {
    Map<String, String> queryParams = {};
    if (nextPage.isNotEmpty) {
      queryParams = {
        'part': 'snippet',
        'q': '$query',
        'regionCode': countryCode,
        'type': 'video',
        "order": "viewCount",
        'pageToken': nextPage,
        'maxResults': '100000',
        'key': API_KEY
      };
    } else {
      queryParams = {
        'part': 'snippet',
        'q': '$query',
        'regionCode': countryCode,
        'type': 'video',
        "order": "viewCount",
        'maxResults': '100000',
        'key': API_KEY
      };
    }
    return queryParams;
  }

  static String getRandomDateIso() {
    final now = DateTime.now();
    final randomDaysAgo = DateTime.now().subtract(const Duration(days: 300));
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(randomDaysAgo.toUtc());
  }

  static Map<String, String> getPopularVideosParam(String q, String pageToken) {
    Map<String, String> queryParams = {};
    queryParams = {
      'part': 'snippet,statistics,contentDetails',
      'chart': 'mostPopular',
      'regionCode': countryCode,
      // 'q':"",
      if (q.isNotEmpty) "videoCategoryId": q,

      "order": "viewCount",
      'maxResults': "50",
      if (pageToken.isNotEmpty) 'pageToken': pageToken,
      'key': API_KEY,
    };
    return queryParams;
  }

  static String formatDate(String isoString) {
    final date = DateTime.parse(isoString);
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static Future<void> changeLanguage(
      BuildContext context, Locale newLocale) async {
    Get.updateLocale(newLocale);

    Get.offAll(() => Localizations.override(
      context: context,
      locale: newLocale,
      child: SplashPage(),
    ));
  }

  static String getImgePath(String imgName) {
    return "images/" + imgName;
  }
  static Future<Map<String, String>> getCommonHeaderWithoUTAuth() async {
    Map<String, String> headers = {};
    String token = await CacheDataManager.getStringData(
      Utils.TOKEN,
    );
    String lang = await CacheDataManager.getStringData(
      Utils.LANGUAGE,
    );

    headers["x-Language"] = lang;
    headers["Content-Type"]="application/json";

    return headers;
  }

  static Future<Map<String, String>> getCommonHeaderWithAuth() async {
    Map<String, String> headers = {};
    String token = await CacheDataManager.getStringData(
      Utils.TOKEN,
    );
    String lang = await CacheDataManager.getStringData(
      Utils.LANGUAGE,
    );

    headers["Authorization"] = "Bearer $token";
    headers["x-Language"] = lang;
    headers["Content-Type"]="application/json";
    return headers;
  }
  static Future<void> clearSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  static Future<Map<String, String>> commonHeaderWithOutAuth() async {
    String lang = await CacheDataManager.getStringData(
      Utils.LANGUAGE,
    );

    Map<String, String> headers = {};

    headers["x-Language"] = lang;

    return headers;
  }
}
