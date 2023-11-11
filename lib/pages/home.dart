import 'package:flutter/material.dart';
import 'package:weekly_schedule/pages/days/monday.dart';
import 'package:weekly_schedule/pages/days/saturday.dart';
import 'package:weekly_schedule/pages/days/sunday.dart';
import 'package:weekly_schedule/pages/days/thursday.dart';
import 'package:weekly_schedule/pages/days/tuesday.dart';
import 'package:weekly_schedule/pages/days/wednesday.dart';
import 'days/friday.dart';

// الصفحه الرئيسية
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<String> days = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جدول أسبوعي'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                openPageByDay(context, days[index]);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    days[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void openPageByDay(BuildContext context, String day) {
    switch (day) {
      case 'السبت':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Saturday()),
        );
        break;
      case 'الأحد':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sunday()),
        );
        break;
      case 'الاثنين':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Monday()),
        );
        break;
      case 'الثلاثاء':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Tuesday()),
        );
        break;
      case 'الأربعاء':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Wednesday()),
        );
        break;
      case 'الخميس':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Thursday()),
        );
        break;
      case 'الجمعة':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Friday()),
        );
        break;
    }
  }
}
