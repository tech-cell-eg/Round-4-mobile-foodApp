import 'package:fruit_hub/core/cache/cache_helper.dart';
import 'package:fruit_hub/core/cache/cache_keys.dart';

abstract class CacheData {
  static String? accessToken;
  static String? userName;
  static bool? firstTime;

  static Future<void> clear() async {
    await CacheHelper.removeData(key: CacheKeys.accessToken);
    await CacheHelper.removeData(key: CacheKeys.userName);
  }
}
