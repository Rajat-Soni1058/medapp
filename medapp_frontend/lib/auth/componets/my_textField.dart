// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
                cursorColor: Colors.grey,
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(132, 234, 234, 234),
                  
                  prefixIcon: Icon(prefixIcon,color: Colors.grey,),
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
