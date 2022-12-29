import 'dart:math';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:upgrader/upgrader.dart';
import 'package:version_sync_poc/token.dart';
import 'dart:html' as html;

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
  static const appcastURL =
      'https://scintillating-gingersnap-7481a0.netlify.app/xmlappcast.xml';
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
          onUpdate: () {
            if (UniversalPlatform.isWeb) {
              print('onUpdate called on web');
              if (html.window.navigator.serviceWorker != null) {
                html.window.navigator.serviceWorker!
                    .getRegistration()
                    .then((serviceWorkerRegistration) => {
                          serviceWorkerRegistration
                              .unregister()
                              .then((_) => {html.window.location.reload()})
                        });
              } else {
                html.window.location.reload();
              }
            } else if (UniversalPlatform.isAndroid) {
              print('onUpdate called on android');
            } else if (UniversalPlatform.isIOS) {
              print('onUpdate called on ios');
            }

            return true;
          }),
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
