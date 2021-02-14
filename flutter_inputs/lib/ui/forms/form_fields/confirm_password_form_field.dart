import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inputs/ui/forms/models/passwords.dart';

class ConfirmPasswordFormField extends FormField<Passwords> {
  ConfirmPasswordFormField({
    FormFieldSetter<Passwords> onSaved,
    FormFieldValidator<Passwords> validator,
    Passwords initialValue,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<Passwords> state) {
            return Column(
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  onChanged: (String value) {
                    state.value.password = value;
                    state.didChange(state.value);
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Confirm Password"),
                  onChanged: (String value) {
                    state.value.confirmPassword = value;
                    state.didChange(state.value);
                  },
                ),
                if (state.hasError)
                  Text(
                    state.errorText,
                    style: TextStyle(color: Colors.red),
                  )
              ],
            );
          },
        );
}
