// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weekly_schedule/widgets/challenge_day.dart';

// التحدي الأسبوعي
class WeeklyChallenge extends StatefulWidget {
  const WeeklyChallenge({super.key});

  @override
  _TextState createState() => _TextState();
}

class _TextState extends State<WeeklyChallenge> {
  TextEditingController textController = TextEditingController();
  bool isButtonDisabled = false; // خاص بقفل الزر والحقل
  String? enteredText;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;

// حفظ النص
  void saveText() async {
    final prefs = await SharedPreferences.getInstance();
    if (enteredText != null) {
      prefs.setString('enteredText', enteredText!);
    }
  }

// استرجاع النص المحفوظ
  void loadSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    final savedText = prefs.getString('enteredText');
    setState(() {
      // null إذا لم تكن هناك بيانات محفوظة، يكون القيمة
      enteredText = savedText;
    });
  }

  // bool حفظ حالة
  void saveButtonState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isButtonDisabled', isButtonDisabled);
  }

  // bool استرجاع حالة
  void loadButtonState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedState = prefs.getBool('isButtonDisabled');
    setState(() {
      // إذا لم تكن هناك بيانات محفوظة، يكون القيمة false
      isButtonDisabled = savedState ?? false;
    });
  }

  // الخاص بالايام bool حفظ حالة
  void saveDayState(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  // الخاص بالايام bool استرجاع حاله
  void loadDayState(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final savedState = prefs.getBool(key);
    setState(() {
      // إذا لم تكن هناك بيانات محفوظة، يكون القيمة false
      switch (key) {
        case 'isChecked1':
          isChecked1 = savedState ?? false;
          break;
        case 'isChecked2':
          isChecked2 = savedState ?? false;
          break;
        case 'isChecked3':
          isChecked3 = savedState ?? false;
          break;
        case 'isChecked4':
          isChecked4 = savedState ?? false;
          break;
        case 'isChecked5':
          isChecked5 = savedState ?? false;
          break;
        case 'isChecked6':
          isChecked6 = savedState ?? false;
          break;
        case 'isChecked7':
          isChecked7 = savedState ?? false;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // استرجاع النص اللي تم حفظه
    loadSavedText();
    // استرجاع حاله الزر اللي هو الحقل والزر اضافه مفعل ام مغلق
    loadButtonState();
    // استرجاع كل الايام عند بدء التطبيق
    loadDayState('isChecked1');
    loadDayState('isChecked2');
    loadDayState('isChecked3');
    loadDayState('isChecked4');
    loadDayState('isChecked5');
    loadDayState('isChecked6');
    loadDayState('isChecked7');
  }

  // SharedPreferences حذف جميع البيانات اللي تم تخزينه في
  void clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); // ستقوم هذه الخطوة بحذف جميع المفاتيح والقيم المخزنة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isChecked1 &&
                isChecked2 &&
                isChecked3 &&
                isChecked4 &&
                isChecked5 &&
                isChecked6 &&
                isChecked7
            ? const Text(
                'مبروك تم الانتهاء🎉🥳',
                style: TextStyle(
                  color: Colors.amber,
                ),
              )
            : const Text('التحدي الأسبوعي'),
        actions: [
          // لا يظهر في حالة عدم وجود نص مدخل داخل الحقل appBarDelete
          if (enteredText != null) appBarDelete(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  حقل الاداخل الاضافه نص جديد
              EnterText_TextField(),
              const SizedBox(height: 20),
              // زر اضافه النص
              ElevatedButton(
                onPressed: isButtonDisabled
                    ? null
                    : () {
                        final enteredTextValue = textController.text;
                        if (enteredTextValue.isNotEmpty) {
                          setState(() {
                            enteredText = enteredTextValue;
                            textController.clear();
                            isButtonDisabled = true;
                            // لحفظ النص اللي تم ادخاله saveText
                            saveText();
                            // حفظ حاله الزر والحقل مفعل ام لا
                            saveButtonState();
                          });
                        }
                      },
                child: const Text(
                  'إضافة النص',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (enteredText != null) Container_Challenge(),
              const SizedBox(height: 20),
              if (enteredText != null) Column_weekDays()
            ],
          ),
        ),
      ),
    );
  }

  // الايام اللي هتظهر هيكون بشكل اليوم وعلامه صح بعد انتهاء اليوم تعلم عليها
  Column Column_weekDays() {
    return Column(
      children: [
        ...[
          // ايام الاسبوع اللي هتظهر بعد اضافه تحدي ChallengeDay
          ChallengeDay(
            nameDay: 'السبت',
            value: isChecked1,
            onChanged: () {
              setState(() {
                isChecked1 = !isChecked1;
                saveDayState('isChecked1', isChecked1);
              });
            },
          ),
          ChallengeDay(
            nameDay: 'الأحد',
            value: isChecked2,
            onChanged: () {
              setState(() {
                isChecked2 = !isChecked2;
                saveDayState('isChecked2', isChecked2);
              });
            },
          ),
          ChallengeDay(
            nameDay: 'الاثنين',
            value: isChecked3,
            onChanged: () {
              setState(() {
                isChecked3 = !isChecked3;
                saveDayState('isChecked3', isChecked3);
              });
            },
          ),
          ChallengeDay(
            nameDay: 'الثلاثاء',
            value: isChecked4,
            onChanged: () {
              setState(() {
                isChecked4 = !isChecked4;
                saveDayState('isChecked4', isChecked4);
              });
            },
          ),
          ChallengeDay(
            nameDay: 'الأربعاء',
            value: isChecked5,
            onChanged: () {
              setState(() {
                isChecked5 = !isChecked5;
                saveDayState('isChecked5', isChecked5);
              });
            },
          ),
          ChallengeDay(
            nameDay: 'الخميس',
            value: isChecked6,
            onChanged: () {
              setState(() {
                isChecked6 = !isChecked6;
                saveDayState('isChecked6', isChecked6);
              });
            },
          ),
          ChallengeDay(
            nameDay: 'الجمعة',
            value: isChecked7,
            onChanged: () {
              setState(() {
                isChecked7 = !isChecked7;
                saveDayState('isChecked7', isChecked7);
              });
            },
          ),
          // شرط لعرض مربع التهنئة
          if (isChecked1 &&
              isChecked2 &&
              isChecked3 &&
              isChecked4 &&
              isChecked5 &&
              isChecked6 &&
              isChecked7)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'مبروك تم الانتهاء من جميع الأيام🎉🥳',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
        ].map<Widget>((Widget widget) => widget).toList(),
      ],
    );
  }

  //  المكان اللي هيظهر مكتوب فيه النص اللي هو هيكون التحدي
  Container Container_Challenge() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        'التحدي الأسبوعي: $enteredText',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  //  حقل الاداخل الاضافه نص جديد
  TextField EnterText_TextField() {
    return TextField(
      enabled: !isButtonDisabled,
      controller: textController,
      decoration: InputDecoration(
        labelText: 'أدخل النص هنا',
        hintText: 'أدخل نصًا هنا',
        prefixIcon: const Icon(Icons.edit),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            textController.clear();
            setState(() {
              enteredText = null;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

// لحذف النص المدخل appBar خاص بالجزء بتع
  Row appBarDelete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              enteredText = null;
              isButtonDisabled = false;
              isChecked1 = false;
              isChecked2 = false;
              isChecked3 = false;
              isChecked4 = false;
              isChecked5 = false;
              isChecked6 = false;
              isChecked7 = false;
            });
            clearAllData(); // حذف جميع البيانات المخزنة
            // حفظ حالة الزر بعد الحذف
            saveButtonState();
            // عرض رسالة
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم حذف التحدي'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          style: ButtonStyle(
            side: MaterialStateProperty.resolveWith(
              (states) => const BorderSide(
                color: Colors.red, // يمكنك تغيير لون الحدود هنا
              ),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.delete, color: Colors.red), // لون الأيقونة
              SizedBox(width: 8), // المسافة بين الأيقونة والنص
              Text(
                'إزالة جميع التحديات',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red, // لون النص
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
