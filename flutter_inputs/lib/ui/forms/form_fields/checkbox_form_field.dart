import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    String title = "",
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool initialValue = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<bool> state) {
            return Container(
              child: Column(
                children: [
                  CheckboxListTile(
                      title: Text(title),
                      value: state.value,
                      onChanged: (bool value) {
                        state.didChange(value);
                      }),
                  if (state.hasError)
                    Text(
                      state.errorText,
                      style: TextStyle(color: Colors.red),
                    )
                ],
              ),
            );
          },
        );
}
