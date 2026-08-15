import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
      // import pages
import 'pages/home.dart';
import 'pages/profile.dart';
import 'components/BottomNavigationBar.dart';
import 'pages/insight.dart';
import 'pages/expens.dart';
import 'pages/History.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('expenses');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home:  const BottomBar(),        // set initial page
      routes: {
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(), 
        '/insight': (context) => const InsightPage(),
        '/expenses': (context) => const ExpensPage(),
        '/history': (context) => const HistoryPage(),


    
      },
    );
  }
}