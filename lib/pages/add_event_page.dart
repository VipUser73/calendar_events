import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    return BlocBuilder<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>(),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green.shade700,
                leading: const CloseButton(),
                actions: [
                  IconButton(
                    onPressed: () =>
                        context.read<CalendarBloc>().add(SaveFormEvent(
                              titleController.text,
                            )),
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
                                text: Utils.toDate(
                                    state.startEvent ?? DateTime.now()),
                                onClicked: () => context
                                    .read<CalendarBloc>()
                                    .add(PickStartTimeEvent(context,
                                        pickDate: true)),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: Utils.toTime(
                                    state.startEvent ?? DateTime.now()),
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
                                text: Utils.toDate(state.finishEvent ??
                                    DateTime.now()
                                        .add(const Duration(hours: 2))),
                                onClicked: () => context
                                    .read<CalendarBloc>()
                                    .add(PickFinishTimeEvent(context,
                                        pickDate: true)),
                              ),
                            ),
                            Expanded(
                              child: dropDownField(
                                text: Utils.toTime(state.finishEvent ??
                                    DateTime.now()
                                        .add(const Duration(hours: 2))),
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
