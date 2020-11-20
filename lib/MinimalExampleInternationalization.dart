import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';

class MinimalExampleInternationalization {
  static const MethodChannel _channel = const MethodChannel('MinimalExampleInternationalization');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future getTitle(context) async {
    return Translations.of(context).example_title;
  }
}
