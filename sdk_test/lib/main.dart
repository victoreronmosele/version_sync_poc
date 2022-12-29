import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FocusNode? f1, f2, f3;

  void _onFocusChanged1() {
    bool f1Focus;
    setState(() => f1Focus = f1?.hasFocus ?? false);
  }

  void _onFocusChanged2() {
    bool f2Focus;
    setState(() => f2Focus = f2?.hasFocus ?? false);
  }

  void _onFocusChanged3() {
    bool f3Focus;
    setState(() => f3Focus = f3?.hasFocus ?? false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (f1 == null) {
      f1 = FocusNode();
      f2 = FocusNode();
      f3 = FocusNode();
      //Setting the 1st Focus to the appropriate widget
      //List<FocusNode> fnList= List.generate(3, (index) => FocusNode());
      f1?.addListener(_onFocusChanged1);
      f2?.addListener(_onFocusChanged2);
      f3?.addListener(_onFocusChanged3);
      f1?.requestFocus();
    }
  }

  @override
  void dispose() {
    f1!.dispose();
    f2!.dispose();
    f3!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event.runtimeType == RawKeyUpEvent) {
                if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                  _onFocusChanged1;
                  _onFocusChanged2;
                  _onFocusChanged3;
                } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                  _onFocusChanged1;
                  _onFocusChanged2;
                  _onFocusChanged3;
                }
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Focus(
                      focusNode: f1,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 100,
                        width: 100,
                        color: (f1?.hasPrimaryFocus ?? true)
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                    Focus(
                      focusNode: f2,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 100,
                        width: 100,
                        color: (f2?.hasPrimaryFocus ?? true)
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                    Focus(
                      focusNode: f3,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 100,
                        width: 100,
                        color: (f3?.hasPrimaryFocus ?? true)
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
