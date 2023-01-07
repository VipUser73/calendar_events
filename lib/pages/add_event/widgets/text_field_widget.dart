import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/text_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({Key? key}) : super(key: key);

  final AddEventController addEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: addEventController.formKey,
        child: TextFormField(
          cursorColor: Colors.green,
          decoration: InputDecoration(
            labelText: addEventHintText.keys.first.tr,
            labelStyle: const TextStyle(color: Colors.white),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
          validator: (title) =>
              title != null && title.isEmpty ? 'Title cannot be empty' : null,
          controller: addEventController.titleController,
        ),
      ),
    );
  }
}
