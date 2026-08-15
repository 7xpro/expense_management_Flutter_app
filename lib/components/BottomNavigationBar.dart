import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/expens.dart';
import '../pages/history.dart';
import '../pages/insight.dart';
import '../pages/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const ExpensPage(),
      const HistoryPage(),
      const InsightPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          setState(() => _currentIndex = 0);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Expenses'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Incomes'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}