import 'package:flutter/material.dart';

class RadioFormField extends FormField<bool> {
  RadioFormField({
    IconData icon = Icons.add,
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
                  GestureDetector(
                    onTap: () {
                      state.didChange(!state.value);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state.value
                                      ? Colors.green
                                      : Colors.transparent,
                                ),
                              ),
                              Icon(icon)
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(
                            "My Label",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
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
