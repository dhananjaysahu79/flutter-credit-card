import 'package:credit_card_project/screens/onboardingScreen.dart';

import './credit_cards_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards Project',
      theme: ThemeData(
        fontFamily: 'Lato',
        canvasColor: Colors.white,
        pageTransitionsTheme: PageTransitionsTheme(
        builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen()
      
    );
  }
}
