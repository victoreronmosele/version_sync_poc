import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

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
      'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
  static final cfg =
      AppcastConfiguration(url: appcastURL, supportedOS: ['android', 'web', 'ios']);

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(appcastConfig: cfg, debugLogging: true, canDismissDialog: false, debugDisplayAlways: true, ),
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
