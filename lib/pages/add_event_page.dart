import 'dart:async';
import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:calendar_of_events/text_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_range/time_range.dart';

class AddEventPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final AddEventController addEventController = Get.put(AddEventController());

  AddEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.green.shade700,
              title: Text(appBarTitle.keys.first.tr),
              leading: CloseButton(
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    saveForm();
                  },
                  icon: const Icon(Icons.done),
                ),
              ]),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextFormField(
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              labelText: addEventHintText.keys.first.tr,
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            onFieldSubmitted: (_) =>
                                FocusScope.of(context).unfocus(),
                            validator: (title) => title != null && title.isEmpty
                                ? 'Title cannot be empty'
                                : null,
                            controller: _titleController,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => pickEventDate(context),
                        child: SizedBox(
                          width: 160,
                          height: 50,
                          child: Card(
                              child: Center(
                                  child: Obx(
                            () => Text(
                              Utils.toDate(
                                  addEventController.selectedDate.value),
                              maxLines: 1,
                              style: TextStyle(fontSize: 18),
                            ),
                          ))),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 300,
                  ),
                  child: DecoratedBox(
                    decoration: new BoxDecoration(color: Colors.black38),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> pickEventDate(BuildContext context) async {
    final data = await showDatePicker(
      context: context,
      initialDate: addEventController.selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2033),
    );
    if (data != null && data != addEventController.selectedDate.value) {
      addEventController.selectedDate.value = data;
    }
  }

  Future<void> saveForm() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: _titleController.text,
          dayMonth: addEventController.selectedDate.value);
      addEventController.addEvent(event);
      Get.back();
    }
  }
}
