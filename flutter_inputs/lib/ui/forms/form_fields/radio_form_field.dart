import 'package:flutter/material.dart';

class RadioFormField<T> extends FormField<T> {
  RadioFormField({
    String label = "My Label",
    IconData icon = Icons.add,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    T? value,
    bool selected = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: value,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<T> state) {
            return Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      state.didChange(state.value);
                      selected = !selected;
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
                                  color: selected
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
                            label,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      style: TextStyle(color: Colors.red),
                    )
                ],
              ),
            );
          },
        );
}
