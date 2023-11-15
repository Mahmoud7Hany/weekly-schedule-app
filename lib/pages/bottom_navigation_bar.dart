// ignore_for_file: library_private_types_in_public_api

// BottomNavigation صفحه
import 'package:flutter/material.dart';
import 'package:weekly_schedule/pages/home.dart';
import 'package:weekly_schedule/pages/weekly_challenge.dart';

import 'evaluation_week.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});


  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 1;
  final List<Widget> _pages = [
    const WeeklyChallenge(),
     Home(),
    const EvaluationWeek(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        // type: BottomNavigationBarType.shifting, // لجعل العناصر ثابتة العرض
        selectedItemColor: Colors.amber, // لون العنصر المحدد
        unselectedItemColor: Colors.grey, // لون العناصر غير المحددة
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'تحدي الأسبوعي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'تقيم الاسبوع',
          ),
        ],
        backgroundColor:
            const Color.fromARGB(153, 136, 24, 123), // لون خلفية شريط القائمة
        elevation: 5, // رفعة شريط القائمة
        selectedFontSize: 14, // حجم الخط للعنصر المحدد
        unselectedFontSize: 12, // حجم الخط للعناصر غير المحددة
      ),
    );
  }
}
