import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:calendar_of_events/pages/event_editing_page.dart';
import 'package:calendar_of_events/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventViewingPage extends StatelessWidget {
  const EventViewingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {
          if (state is LoadedEditingPageState) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventEditingPage()));
          }
        },
        bloc: context.read<CalendarBloc>(),
        builder: (context, state) {
          if (state is LoadedViewingPageState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green.shade700,
                leading: CloseButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<CalendarBloc>().add(LoadingCalendarEvent());
                  },
                ),
                actions:
                    buildViewingActions(context, state.selectedEvent!, state),
              ),
              body: ListView(
                padding: const EdgeInsets.all(30),
                children: [
                  Center(
                    child: Text(
                      state.selectedEvent!.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    Utils.toDateTime(state.selectedEvent!.start),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    Utils.toDateTime(state.selectedEvent!.finish),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }

  List<Widget> buildViewingActions(
          BuildContext context, Event event, CalendarState state) =>
      [
        IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context
                  .read<CalendarBloc>()
                  .add(GoToEditingPageEvent(state.selectedEvent!));
            }),
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<CalendarBloc>().add(DeleteEventEvent(
                    event.title,
                  ));
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }),
      ];
}
