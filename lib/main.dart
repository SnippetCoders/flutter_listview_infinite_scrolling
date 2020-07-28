import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'provider/data_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
          child: HomePage(),
        ),
      ],
      child: MaterialApp(
        title: 'Infinite Scrolling',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
