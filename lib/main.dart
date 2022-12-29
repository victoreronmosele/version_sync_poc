import 'dart:math';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:version_sync_poc/token.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Version 6 Sync PoC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final appcastURL =
      'https://raw.githubusercontent.com/victoreronmosele/version_sync_poc/master/build/web/xmlappcast.xml?random=${Random().nextDouble()}';
  static final cfg = AppcastConfiguration(
    url: appcastURL,
  );

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        appcastConfig: cfg,
        debugLogging: true,
        canDismissDialog: false,
        showIgnore: false,
        durationUntilAlertAgain: Duration.zero,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/robot.jpeg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
