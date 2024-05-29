import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Dashboard/view/dashboard.dart';
import 'package:pet_adoption_app/Dashboard/view_model/themeprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(
      value: ThemeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    ThemeData themeData = ThemeData(brightness: currentBrightness);
    return MaterialApp(
      home: const Dashboard(),
      themeMode: ThemeMode.system,
      theme: themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
