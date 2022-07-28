import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventEditingPage extends StatelessWidget {
  const EventEditingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    return BlocBuilder<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>(),
        builder: (context, state) {
          String toDateStart = Utils.toDate(state.startEvent ?? DateTime.now());
          String toTimeStart = Utils.toTime(state.startEvent ?? DateTime.now());
          String toDateFinish = Utils.toDate(state.finishEvent ??
              DateTime.now().add(const Duration(hours: 2)));
          String toTimeFinish = Utils.toTime(state.finishEvent ??
              DateTime.now().add(const Duration(hours: 2)));
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green.shade700,
                leading: const CloseButton(),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<CalendarBloc>().add(SaveFormEvent(
                            titleController.text,
                          ));
                      Navigator.of(context).pop();
                    },
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
                      //onFieldSubmitted: (_) => saveForm(),
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
                                text: toDateStart,
                                onClicked: () => context
                                    .read<CalendarBloc>()
                                    .add(PickStartTimeEvent(context,
                                        pickDate: true)),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: toTimeStart,
                                onClicked: () => context
                                    .read<CalendarBloc>()
                                    .add(PickStartTimeEvent(context,
                                        pickDate: false)),
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
                                onClicked: () => context
                                    .read<CalendarBloc>()
                                    .add(PickFinishTimeEvent(context,
                                        pickDate: true)),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: toTimeFinish,
                                onClicked: () => context
                                    .read<CalendarBloc>()
                                    .add(PickFinishTimeEvent(context,
                                        pickDate: false)),
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
}
