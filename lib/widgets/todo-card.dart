// // ignore_for_file: file_names, must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';

// خاص بالحقل اللي هو بعد اضافه المهمه بيظهر ومكتوب فيه المهمه وعلامه صح وازاله العنصر
class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.varTitle,
    required this.doneORnot,
    required this.changeStatus,
    required this.index,
    required this.delete,
  }) : super(key: key);

  final String varTitle;
  final bool doneORnot;
  final Function changeStatus;
  final int index;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeStatus(index);
      },
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(209, 224, 224, 0.2),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    varTitle,
                    style: TextStyle(
                      color: doneORnot ? Colors.black54 : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      decoration: doneORnot
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Row(
                children: [
                  Checkbox(
                    value: doneORnot,
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                    onChanged: (value) {
                      changeStatus(index);
                    },
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      // delete(index);
                      _showDeleteConfirmationDialog(context, index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 200, 196),
                      size: 27,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // عرض مربع التأكيد لحذف العنصر
  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("تأكيد الحذف"),
          content: const Text("هل أنت متأكد أنك تريد حذف هذا العنصر؟"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                delete(index); // حذف العنصر
                Navigator.of(context).pop(); // إغلاق مربع الحوار
              },
              child: const Text("حذف"),
            ),
          ],
        );
      },
    );
  }
}
