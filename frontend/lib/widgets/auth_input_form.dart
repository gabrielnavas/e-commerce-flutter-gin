import 'package:flutter/material.dart';

class AuthInputForm extends StatelessWidget {
  final TextEditingController controller;
  final String valueKey;
  final double screenWidth;
  final bool autofocus;
  final bool obscureText;
  final TextInputAction textInputAction;

  final bool isValid;

  final String label;
  final void Function(String value) onChange;
  final String? Function(String? value) validator;
  final void Function(String?) onSaved;

  const AuthInputForm({
    this.autofocus = false,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    required this.screenWidth,
    required this.controller,
    required this.valueKey,
    required this.label,
    required this.isValid,
    required this.onChange,
    required this.validator,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: screenWidth * .022, horizontal: screenWidth * .05),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        key: ValueKey(valueKey),
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Icon(
              isValid ? Icons.check : Icons.close,
              color: isValid ? Colors.green : Colors.redAccent,
            ),
          ),
        ),
        textInputAction: textInputAction,
        autofocus: autofocus,
        onChanged: onChange,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
