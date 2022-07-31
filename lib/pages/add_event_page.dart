import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  AddEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return BlocBuilder<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>(),
        builder: (context, state) {
          DateTime startEvent = state.startEvent ?? DateTime.now();
          DateTime finishEvent =
              state.finishEvent ?? DateTime.now().add(const Duration(hours: 2));
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green.shade700,
                leading: CloseButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<CalendarBloc>().add(LoadingCalendarEvent());
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () => saveForm(
                        context, startEvent, finishEvent, titleController.text),
                    icon: const Icon(Icons.done),
                  ),
                ]),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Add title of the event',
                      ),
                      onFieldSubmitted: (_) => saveForm(context, startEvent,
                          finishEvent, titleController.text),
                      validator: (title) => title != null && title.isEmpty
                          ? 'Title cannot be empty'
                          : null,
                      controller: titleController,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: dropDownField(
                                text: Utils.toDate(startEvent),
                                onClicked: () => pickstartEventTime(
                                    context, startEvent, finishEvent,
                                    pickDate: true),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: Utils.toTime(startEvent),
                                onClicked: () => pickstartEventTime(
                                    context, startEvent, finishEvent,
                                    pickDate: false),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: dropDownField(
                                text: Utils.toDate(finishEvent),
                                onClicked: () => pickfinishEventTime(
                                    context, startEvent, finishEvent,
                                    pickDate: true),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: Utils.toTime(finishEvent),
                                onClicked: () => pickfinishEventTime(
                                    context, startEvent, finishEvent,
                                    pickDate: false),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget dropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future<void> pickstartEventTime(
      BuildContext context, DateTime startEvent, DateTime finishEvent,
      {required bool pickDate}) async {
    final date = await pickDateTime(context, startEvent, pickDate: pickDate);
    if (date != null) {
      if (date.isAfter(finishEvent)) {
        finishEvent = DateTime(
          date.year,
          date.month,
          date.day,
          finishEvent.hour,
          finishEvent.minute,
        );
      }
      startEvent = date;
      context.read<CalendarBloc>().add(PickTimeEvent(startEvent, finishEvent));
    }
  }

  Future<void> pickfinishEventTime(
      BuildContext context, DateTime startEvent, DateTime finishEvent,
      {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      finishEvent,
      pickDate: pickDate,
      firstDate: pickDate ? startEvent : null,
    );
    finishEvent = date ?? finishEvent;
    context.read<CalendarBloc>().add(PickTimeEvent(startEvent, finishEvent));
  }

  Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2022, 1),
        lastDate: DateTime(2100),
      );
      if (date == null) {
        return null;
      } else {
        final Duration time =
            Duration(hours: initialDate.hour, minutes: initialDate.minute);
        return date.add(time);
      }
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) {
        return null;
      } else {
        final date =
            DateTime(initialDate.year, initialDate.month, initialDate.day);
        final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
        return date.add(time);
      }
    }
  }

  Future<void> saveForm(BuildContext context, DateTime startEvent,
      DateTime finishEvent, String text) async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      final saveEvent = Event(
        title: text,
        start: startEvent,
        finish: finishEvent,
      );
      context.read<CalendarBloc>().add(SaveFormEvent(saveEvent));
      Navigator.of(context).pop();
    }
  }
}
