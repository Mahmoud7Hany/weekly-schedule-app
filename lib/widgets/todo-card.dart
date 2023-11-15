// ignore_for_file: file_names

import 'package:flutter_slidable/flutter_slidable.dart';
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
    // قابل للانزلاق اللي بيعمل تحريك للعنصر ليظهر الانزلاق Slidable
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              delete(index); // حذف العنصر
            },
            backgroundColor: Colors.blue,
            icon: Icons.delete,
            label: 'حذف',
          )
        ],
      ),
      child: ListTile(
        title: GestureDetector(
          onTap: () {
            changeStatus(index);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(209, 224, 224, 0.2),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    // const SizedBox(width: 5),
                    // IconButton(
                    //   onPressed: () {
                    //     _showDeleteConfirmationDialog(context, index);
                    //   },
                    //   icon: const Icon(
                    //     Icons.delete,
                    //     color: Color.fromARGB(255, 255, 200, 196),
                    //     size: 27,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
        onLongPress: () {
          delete(index);
        },
      ),
    );
  }
}
