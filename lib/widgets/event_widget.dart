// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// صفحه الحديث اللي حصل في التقيم
class EventWidget extends StatelessWidget {
  EventWidget(
      {super.key,
      required this.textController,
      required this.onPressedClear,
      required this.onPressedAdd,
      required this.enteredText,
      required this.labelText,
      required this.textEventAdd,
      required this.enteredTextLearning,
      required this.enteredTextNegative,
      required this.enteredTextPositive});

  TextEditingController? textController;
  final Function onPressedClear;
  final Function onPressedAdd;
  final String? enteredText;
  final String? labelText;
  final String? textEventAdd;

  final String? enteredTextPositive;
  final String? enteredTextNegative;
  final String? enteredTextLearning;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: 'أدخل نصًا هنا',
            prefixIcon: const Icon(Icons.edit),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                onPressedClear();
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
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            onPressedAdd();
          },
          child: const Text(
            'إضافة الحدث',
            style: TextStyle(
              fontSize: 21,
            ),
          ),
        ),
        const SizedBox(height: 15),
        if ((enteredText ?? '').isNotEmpty)
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: enteredText != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            textEventAdd!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            enteredText!,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
