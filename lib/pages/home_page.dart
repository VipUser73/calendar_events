import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_data_source.dart';
import 'package:calendar_of_events/pages/add_event_page.dart';
import 'package:calendar_of_events/widgets/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
        bloc: context.read<CalendarBloc>()..add(LoadingCalendarEvent()),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.green.shade700,
              title: const Text('Сalendar of events'),
            ),
            body: SafeArea(
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
                onLongPress: (details) {
                  // final provider = Provider.of<EventProvider>(context, listen: false);
                  // provider.setDate(details.date!);
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) => const TasksWidget(),
                  // );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.green.shade700,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddEventPage())),
            ),
          );
        });
  }
}
