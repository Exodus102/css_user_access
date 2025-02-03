import 'package:css_website_access/users/css-coordinator/css_coordinator_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SFfont'),
      home: CssCoordinatorPanelSide(),
    );
  }
}
