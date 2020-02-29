import "dart:io";

import "package:flutter/material.dart";

Directory docsDir;

Future selectDate(BuildContext context, String inDateString) async {
  DateTime initialDate = DateTime.now();
  if (inDateString != null) {
    List dateParts = inDateString.split(",");
    initialDate =
        DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]), int.parse(dateParts[2]));
  }
  DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  if (picked != null) {
    // setChosenDate(
    //   DateFormat.yMMMMd("en_US").format(picked.toLocal())
    // );
    return "${picked.year},${picked.month},${picked.day}";
  }
}
