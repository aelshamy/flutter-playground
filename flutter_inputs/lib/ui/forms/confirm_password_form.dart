import 'package:flutter/material.dart';
import 'package:flutter_inputs/ui/forms/form_fields/checkbox_form_field.dart';
import 'package:flutter_inputs/ui/forms/form_fields/confirm_password_form_field.dart';
import 'package:flutter_inputs/ui/forms/models/passwords.dart';

class ConfirmPasswordForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Form Fields'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    ConfirmPasswordFormField(
                      initialValue: Passwords(),
                      onSaved: (Passwords? passwords) {
                        print("Password: ${passwords!.password}");
                      },
                      validator: (Passwords? passwords) {
                        if (passwords!.nonEmpty()) {
                          if (passwords.match()) {
                            if (passwords.valid()) {
                              return null;
                            }
                            return "Passwords should be 8 characters long";
                          }
                          return "Passwords should be same";
                        }
                        return "Passwords should not be empty";
                      },
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    CheckboxFormField(
                      title: "I agree to change password",
                      onSaved: (bool? checked) {
                        print("Checkbox: $checked");
                      },
                      validator: (bool? value) {
                        return value! ? null : "You must check this";
                      },
                      autovalidateMode: AutovalidateMode.always,
                    )
                  ],
                ),
              ),
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
