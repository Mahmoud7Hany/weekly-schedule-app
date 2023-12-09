// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/event_widget.dart';

// صفحه تقيم الاسبوع
class EvaluationWeek extends StatefulWidget {
  const EvaluationWeek({Key? key}) : super(key: key);

  @override
  _WeekRatingPageState createState() => _WeekRatingPageState();
}

class _WeekRatingPageState extends State<EvaluationWeek> {
  TextEditingController textControllerPositive = TextEditingController();
  TextEditingController textControllerNegative = TextEditingController();
  TextEditingController textControllerLearning = TextEditingController();
  String? enteredTextPositive;
  String? enteredTextNegative;
  String? enteredTextLearning;

  // حفظ البيانات
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('enteredTextPositive', enteredTextPositive ?? '');
    prefs.setString('enteredTextNegative', enteredTextNegative ?? '');
    prefs.setString('enteredTextLearning', enteredTextLearning ?? '');
  }

  // استرجاع البيانات
  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enteredTextPositive = prefs.getString('enteredTextPositive') ?? '';
      enteredTextNegative = prefs.getString('enteredTextNegative') ?? '';
      enteredTextLearning = prefs.getString('enteredTextLearning') ?? '';
    });
  }

  // دالة لحذف جميع النصوص
  // Future<void> clearAllText() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('enteredTextPositive');
  //   await prefs.remove('enteredTextNegative');
  //   await prefs.remove('enteredTextLearning');
  //   await loadSavedData(); // لإعادة تحميل البيانات بعد الحذف
  // }

  // لحذف جميع النصوص
  Future<void> clearAllText() async {
    final prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد أنك تريد حذف جميع البيانات؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // إغلاق مربع الحوار

                await prefs.remove('enteredTextPositive');
                await prefs.remove('enteredTextNegative');
                await prefs.remove('enteredTextLearning');
                await loadSavedData(); // لإعادة تحميل البيانات بعد الحذف

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم حذف جميع البيانات'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  //  لنسخ العناصر واظهار رساله في حاله النسخ او في حاله لا يوجد بيانات
  void copyListToClipboard() {
    // التحقق من وجود عناصر في القائمة قبل النسخ
    if ((enteredTextPositive ?? '').isNotEmpty ||
        (enteredTextNegative ?? '').isNotEmpty ||
        (enteredTextLearning ?? '').isNotEmpty) {
      // نسخ محتوى القائمة إلى الحافظة
      Clipboard.setData(ClipboardData(text: '''
إيجابي: $enteredTextPositive
سلبي: $enteredTextNegative
تعلم: $enteredTextLearning'''));
    } else {
      // إذا لم يكن هناك عناصر في القائمة
      // عرض رسالة تنبيه
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد عناصر لنسخها'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تقييم الأسبوع'),
        actions: [
          if ((enteredTextPositive ?? '').isNotEmpty ||
              (enteredTextNegative ?? '').isNotEmpty ||
              (enteredTextLearning ?? '').isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    enteredTextPositive = textControllerPositive.text;
                    // عند الضغط على الزر يتم حذف جميع النصوص
                    clearAllText();
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
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'إزالة جميع التقييمات',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const SizedBox(width: 10),
          if ((enteredTextPositive ?? '').isNotEmpty ||
              (enteredTextNegative ?? '').isNotEmpty ||
              (enteredTextLearning ?? '').isNotEmpty)
            IconButton(
              onPressed: copyListToClipboard,
              icon: const Icon(
                Icons.copy,
                size: 30,
                color: Color.fromARGB(255, 255, 200, 196),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EventWidget(
                textController: textControllerPositive,
                // زر علامه غلط لحذف النص المدخل في الحقل فقط
                onPressedClear: () {
                  setState(() {
                    textControllerPositive.clear();
                    saveData();
                  });
                },
                // إضافة الحدث
                onPressedAdd: () {
                  final enteredTextValue = textControllerPositive.text;
                  if (enteredTextValue.isNotEmpty) {
                    setState(() {
                      enteredTextPositive = enteredTextValue;
                      textControllerPositive.clear();
                      saveData();
                    });
                  }
                },
                // TextField بيتم تخزين فيها النص اللي تم استبقاله من enteredTextPositive
                enteredText: enteredTextPositive,
                labelText: 'شيء إيجابي حدث في هذا الأسبوع',
                textEventAdd: 'شيء إيجابي حدث في هذا الأسبوع',
                //  شرط
                enteredTextPositive: enteredTextPositive,
                enteredTextNegative: enteredTextNegative,
                enteredTextLearning: enteredTextLearning,
              ),
              EventWidget(
                textController: textControllerNegative,
                onPressedClear: () {
                  setState(() {
                    textControllerNegative.clear();
                    saveData();
                  });
                },
                onPressedAdd: () {
                  final enteredTextValue = textControllerNegative.text;
                  if (enteredTextValue.isNotEmpty) {
                    setState(() {
                      enteredTextNegative = enteredTextValue;
                      textControllerNegative.clear();
                      saveData();
                    });
                  }
                },
                enteredText: enteredTextNegative,
                labelText: 'شيء سيء حدث في هذا الأسبوع',
                textEventAdd: 'شيء سيء حدث في هذا الأسبوع',
                enteredTextPositive: enteredTextPositive,
                enteredTextNegative: enteredTextNegative,
                enteredTextLearning: enteredTextLearning,
              ),
              EventWidget(
                textController: textControllerLearning,
                onPressedClear: () {
                  setState(() {
                    textControllerLearning.clear();
                    saveData();
                  });
                },
                onPressedAdd: () {
                  final enteredTextValue = textControllerLearning.text;
                  if (enteredTextValue.isNotEmpty) {
                    setState(() {
                      enteredTextLearning = enteredTextValue;
                      textControllerLearning.clear();
                      saveData();
                    });
                  }
                },
                enteredText: enteredTextLearning,
                labelText: 'شيء تم تعلمه في هذا الأسبوع',
                textEventAdd: 'شيء تم تعلمه في هذا الأسبوع',
                enteredTextPositive: enteredTextPositive,
                enteredTextNegative: enteredTextNegative,
                enteredTextLearning: enteredTextLearning,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
