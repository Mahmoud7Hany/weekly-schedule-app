import 'package:flutter/material.dart';

class TextFieldAdd extends StatelessWidget {
  const TextFieldAdd({Key? key, required this.controller, required this.formKey})
      : super(key: key);

  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: TextFormField(
            validator: (text) {
              if (text!.isEmpty) {
                return 'الرجاء إدخال مهمة';
              }
              return null;
            },
            controller: controller,
            maxLength: 25,
            decoration: InputDecoration(
              hintText: 'إضافة مهمة جديدة',
              labelText: 'مهمة',
              prefixIcon: const Icon(Icons.task),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
