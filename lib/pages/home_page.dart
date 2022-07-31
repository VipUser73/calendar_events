import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_data_source.dart';
import 'package:calendar_of_events/pages/add_event_page.dart';
import 'package:calendar_of_events/pages/event_viewing_page.dart';
import 'package:calendar_of_events/widgets/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>()..add(LoadingCalendarEvent()),
        listener: (context, state) {
          if (state is AddEventState) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddEventPage()));
          }
          if (state is LoadedViewingPageState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EventViewingPage()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.green.shade700,
              title: const Text('Сalendar of events'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: SfCalendar(
                  headerHeight: 50,
                  view: CalendarView.month,
                  firstDayOfWeek: 1,
                  selectionDecoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  cellBorderColor: Colors.black,
                  todayHighlightColor: Colors.green,
                  dataSource: EventDataSource(state.events),
                  initialDisplayDate: DateTime.now(),
                  onLongPress: (CalendarLongPressDetails details) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => TasksWidget(details.date!),
                    );
                  },
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.green.shade700,
              onPressed: () =>
                  context.read<CalendarBloc>().add(AddEventEvent()),
            ),
          );
        });
  }
}
