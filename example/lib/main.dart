import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:MinimalExampleInternationalization/MinimalExampleInternationalization.dart';
import 'package:MinimalExampleInternationalization/l10n/translations.dart';

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String title = "Plugin example app";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translateTitle(context);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MinimalExampleInternationalization.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void translateTitle(BuildContext context) async {
    String tempNewTitle = await MinimalExampleInternationalization.getTitle(context);
    setState(() {
      title = tempNewTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Running on: $_platformVersion\n'),
      ),
    );
  }
}
