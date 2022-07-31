import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:calendar_of_events/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventEditingPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EventEditingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>(),
        builder: (context, state) {
          final titleController =
              TextEditingController(text: state.selectedEvent?.title ?? '');
          Event selectedEvent = Event(
              title: state.selectedEvent?.title ?? '',
              start: state.selectedEvent?.start ?? DateTime.now(),
              finish: state.selectedEvent?.finish ??
                  DateTime.now().add(const Duration(hours: 2)));
          DateTime startEvent = selectedEvent.start;
          DateTime finishEvent = selectedEvent.finish;
          String toDateStart = Utils.toDate(startEvent);
          String toTimeStart = Utils.toTime(startEvent);
          String toDateFinish = Utils.toDate(finishEvent);
          String toTimeFinish = Utils.toTime(finishEvent);
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green.shade700,
                leading: CloseButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) => const HomePage()));

                    context.read<CalendarBloc>().add(GoToBackEvent());
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () => updateForm(context, selectedEvent),
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
                      onFieldSubmitted: (_) =>
                          updateForm(context, selectedEvent),
                      validator: (title) => title != null && title.isEmpty
                          ? 'Title cannot be empty'
                          : null,
                      controller: titleController,
                      onChanged: (value) {
                        selectedEvent.title = value;
                      },
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: dropDownField(
                                text: toDateStart,
                                onClicked: () => pickstartEventTime(
                                    context, selectedEvent,
                                    pickDate: true),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: toTimeStart,
                                onClicked: () => pickstartEventTime(
                                    context, selectedEvent,
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
                                text: toDateFinish,
                                onClicked: () => pickfinishEventTime(
                                    context, selectedEvent,
                                    pickDate: true),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: toTimeFinish,
                                onClicked: () => pickfinishEventTime(
                                    context, selectedEvent,
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

  Future<void> pickstartEventTime(BuildContext context, Event selectedEvent,
      {required bool pickDate}) async {
    final date =
        await pickDateTime(context, selectedEvent.start, pickDate: pickDate);
    if (date != null) {
      if (date.isAfter(selectedEvent.finish)) {
        selectedEvent.finish = DateTime(
          date.year,
          date.month,
          date.day,
          selectedEvent.finish.hour,
          selectedEvent.finish.minute,
        );
      }
      selectedEvent.start = date;
      context.read<CalendarBloc>().add(PickTimeEditEvent(selectedEvent));
    }
  }

  Future<void> pickfinishEventTime(BuildContext context, Event selectedEvent,
      {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      selectedEvent.finish,
      pickDate: pickDate,
      firstDate: pickDate ? selectedEvent.start : null,
    );
    selectedEvent.finish = date ?? selectedEvent.finish;
    context.read<CalendarBloc>().add(PickTimeEditEvent(selectedEvent));
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

  Future<void> updateForm(BuildContext context, Event updateEvent) async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      context.read<CalendarBloc>().add(UpdateFormEvent(updateEvent));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
      context.read<CalendarBloc>().add(LoadingCalendarEvent());
    }
  }
}
