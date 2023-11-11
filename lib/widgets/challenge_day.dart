import 'package:flutter/material.dart';

// خاص ب ايام الاسبوع اللي هتظهر بعد اضافه تحدي
class ChallengeDay extends StatelessWidget {
  const ChallengeDay(
      {super.key,
      required this.nameDay,
      required this.onChanged,
      required this.value});

  final String? nameDay;
  final Function? onChanged;
  final bool? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: value != null && value!
            ? const Color.fromARGB(255, 21, 155, 66)
            : const Color.fromARGB(255, 30, 30, 68),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onChanged!();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(
                  value: value,
                  activeColor: Colors.amber,
                  checkColor: Colors.black,
                  onChanged: (value) {
                    onChanged!();
                  },
                ),
                const SizedBox(width: 8.0),
                Text(
                  nameDay!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        value != null && value! ? Colors.black54 : Colors.white,
                    fontSize: 22,
                    decoration: value != null && value!
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
