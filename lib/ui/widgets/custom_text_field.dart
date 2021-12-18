import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';

enum InputType {
  password,
  number,
  expandMore,
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.label = '',
    this.hint = '',
    this.inputType,
    this.showError = false,
    this.errorText,
    this.focusNode,
    this.prefixIcon,
    this.onExpandMore,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final InputType? inputType;
  final bool showError;
  final String? errorText;
  final FocusNode? focusNode;
  final Icon? prefixIcon;
  final VoidCallback? onExpandMore;

  @override
  Widget build(BuildContext context) {
    var _obscureText = ValueNotifier<bool>(true);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ValueListenableBuilder(
        valueListenable: _obscureText,
        builder: (context, value, child) {
          return TextField(
            focusNode: focusNode,
            enableSuggestions: inputType == InputType.password ? false : true,
            autocorrect: inputType == InputType.password ? false : true,
            controller: controller,
            inputFormatters: Utils.getInputFormatters(
                isNumberType: inputType == InputType.password),
            obscureText:
                inputType == InputType.password ? _obscureText.value : false,
            keyboardType:
                inputType == InputType.number ? TextInputType.number : null,
            style: TextStyle(
              fontFamily: AppConstants.SFProText,
              fontWeight: inputType == InputType.expandMore
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
            decoration: InputDecoration(
              label: Text(
                label,
                style: const TextStyle(
                  fontFamily: AppConstants.SFProText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              isDense: true,
              hintText: hint,
              errorText: showError ? errorText : null,
              prefixIcon: prefixIcon,
              alignLabelWithHint: true,
              suffixIcon: inputType == InputType.password
                  ? GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () => _obscureText.value = !_obscureText.value,
                      child: Icon(
                        _obscureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                  : inputType == InputType.expandMore
                      ? Padding(
                          padding: const EdgeInsets.all(0),
                          child: InkWell(
                            onTap: onExpandMore,
                            child: const Icon(
                              Icons.expand_more,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        )
                      : null,
            ),
            onChanged: (value) {
              if (inputType == InputType.number && value.contains(',')) {
                controller.text = value.replaceAll(',', '.');
                controller.value = controller.value.copyWith(
                  selection: TextSelection(
                    baseOffset: value.length,
                    extentOffset: value.length,
                  ),
                  composing: TextRange.empty,
                );
              }
            },
          );
        },
      ),
    );
  }
}
