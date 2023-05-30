import 'package:flutter/material.dart';

/// 清除的TextFiled
class RoundedInputField extends StatelessWidget {

  const RoundedInputField(
      {Key? key, required this.hintText, required this.icon, this.onChanged, this.textEditingController, this.cursorColor, this.iconColor, this.editTextBackgroundColor})
      : super(key: key);
  final String hintText;
  final IconButton icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final Color? cursorColor;
  final Color? iconColor;
  final Color? editTextBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: editTextBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TextField(
          controller: textEditingController,
          onChanged: onChanged,
          cursorColor: cursorColor,
          decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
