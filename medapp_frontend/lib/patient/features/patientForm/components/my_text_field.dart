// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PatientFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxlines;
  final int maxlength;
  const PatientFormTextField({
    super.key,
    required this.controller,
    required this.hint,
     this.maxlines =1,
     this.maxlength=10,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: maxlines,
      maxLength: maxlength,
                cursorColor: Colors.grey,
                controller: controller,
                decoration: InputDecoration(
                  counterText: (maxlength>10)? '$maxlength' : '',
                  filled: true,
                  fillColor: const Color.fromARGB(132, 234, 234, 234),
                  
                  hint: Text(hint,style: TextStyle(color: Colors.grey),),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5,color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              );
  }
}
