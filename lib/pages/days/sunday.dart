// ignore_for_file: use_build_context_synchronously

// الأحد
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/model_task.dart';
import '../../widgets/counter.dart';
import '../../widgets/text_field_add.dart';
import '../../widgets/todo-card.dart';

class Sunday extends StatefulWidget {
  const Sunday({Key? key}) : super(key: key);

  @override
  State<Sunday> createState() => _SundayState();
}

class _SundayState extends State<Sunday> {
  final formKey = GlobalKey<FormState>();

  // يتم إضافة كل المهام الجديدة هنا
  List<Task> allTasks = [];

  // الكود ده مسؤول عن عند الضغط على أي مهمة أن يتم تمييزها كمكتملة أو غير مكتملة بواسطة علامة صح أو خطأ
  changeStatus(int taskIndex) {
    setState(() {
      allTasks[taskIndex].status = !allTasks[taskIndex].status;
      // إعادة ترتيب القائمة بناءً على حالة المهمة
      allTasks.sort((a, b) => a.status ? -1 : 1);
      saveList(); // حفظ حالة الزر بعد التغيير
    });
  }

  // وحدة تحكم تحرير النصوص
  // يتم استخدام هذا الكود لإرسال وربط البيانات التي تم التقاطها من المستخدم في TextField
  final myController = TextEditingController();

  // حساب المهام المكتملة
  int calculateCompletedTasks() {
    int completedTasks = 0;
    for (var task in allTasks) {
      if (task.status) {
        completedTasks++;
      }
    }
    return completedTasks;
  }

  // Widget لإضافة مهمة جديدة
  addNewTask() {
    final newTaskTitle = myController.text;
    if (newTaskTitle.isNotEmpty) {
      setState(() {
        allTasks.insert(0, Task(title: newTaskTitle, status: false));
        myController.clear();
        saveList(); // حفظ القائمة هنا
        allTasks.sort((a, b) => a.status ? -1 : 1); // فرز القائمة هنا
      });
    }
  }

// حذف العنصر من القائمة
  void removeItem(int index) {
    if (allTasks.isNotEmpty) {
      setState(() {
        allTasks.removeAt(index); // حذف العنصر من القائمة
        saveList(); // حفظ القائمة الجديدة في SharedPreferences
        myController.clear(); // مسح الحقل بعد الحذف
        allTasks.sort((a, b) => a.status ? -1 : 1); // فرز القائمة هنا
      });
    }
  }

// حذف جميع العناصر
  void deleteAll() {
    if (allTasks.isNotEmpty) {
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
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق مربع الحوار
                  setState(() {
                    allTasks.clear();
                    saveList(); // قم بحذف القيمة المخزنة هنا
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم مسح جميع البيانات'),
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد بيانات للمسح'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  String pageKey = 'myList_Sunday';

  // حفظ
  Future<void> saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String listAsString =
        allTasks.map((task) => "${task.title}:${task.status}").join(",");
    prefs.setString(pageKey, listAsString);
  }

  // استرجاع
  Future<void> loadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? listAsString = prefs.getString(pageKey);
    if (listAsString != null) {
      List<String> taskDataList =
          listAsString.split(",").where((data) => data.isNotEmpty).toList();
      setState(() {
        allTasks = taskDataList.map((data) {
          final parts = data.split(":");
          final title = parts[0];
          final status = parts[1] == 'true';
          return Task(title: title, status: status);
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  // هذا يقدم للمستخدم إمكانية نسخ القائمة الحالية إلى الحافظة عند الضغط على زر نسخ
  void copyListToClipboard() {
    if (allTasks.isNotEmpty) {
      String listAsString = allTasks
          .map((task) =>
              "${task.title} - ${task.status ? 'مكتملة' : 'غير مكتملة'}")
          .join("\n");
      Clipboard.setData(ClipboardData(text: listAsString));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد بيانات للنسخ'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    allTasks.sort((a, b) => a.status ? -1 : 1);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 53, 61),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1),
        actions: [
          IconButton(
            onPressed: () {
              deleteAll();
            },
            icon: const Icon(
              Icons.delete_forever,
              size: 35,
              color: Color.fromARGB(255, 255, 200, 196),
            ),
          ),
          IconButton(
            onPressed: () {
              copyListToClipboard();
            },
            icon: const Icon(
              Icons.copy,
              size: 30,
              color: Color.fromARGB(255, 255, 200, 196),
            ),
          ),
        ],
        title: const Text('الأحد'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (allTasks.isNotEmpty)
            Counter(
              allTodos: allTasks.length,
              allCompleted: calculateCompletedTasks(),
            ),
          Expanded(
              child: Container(
                  color: const Color.fromARGB(255, 55, 63, 82),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: allTasks.isNotEmpty
                        ? allTasks.length
                        : 1, // تحقق من عدم فراغ القائمة
                    itemBuilder: (BuildContext context, int index) {
                      if (allTasks.isNotEmpty) {
                        return TodoCard(
                          varTitle: allTasks[index].title,
                          doneORnot: allTasks[index].status,
                          changeStatus: changeStatus,
                          index: index,
                          delete: removeItem,
                        );
                      } else {
                        return const Center(
                          child: Text(
                              'لا توجد مهام حتى الآن'), // عندما تكون القائمة فارغة
                        );
                      }
                    },
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // الحصول على حجم الشاشة
              Size screenSize = MediaQuery.of(context).size;

              // حساب ارتفاع الـ Container بناءً على ارتفاع الشاشة
              double containerHeight = screenSize.height * 0.3;

              return Dialog(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  height: containerHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFieldAdd(
                          controller: myController,
                          formKey: formKey,
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          child: const Text('إضافة'),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              addNewTask();
                              await saveList();

                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
