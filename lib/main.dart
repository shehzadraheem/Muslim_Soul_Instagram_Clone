import 'package:flutter/material.dart';
import 'package:flutter_muslim_soul_instagram/routes/routes.dart';
import 'package:flutter_muslim_soul_instagram/screens/splashs_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_muslim_soul_instagram/utils/theme.dart';
import 'package:get/get.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetX State Management
      debugShowCheckedModeBanner: false,
      title: 'Muslim Soul Instagram',
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      themeMode: ThemeMode.system,// your phone mode
      home:  SplashScreen(),
      getPages: getPages(),
    );
  }
}
