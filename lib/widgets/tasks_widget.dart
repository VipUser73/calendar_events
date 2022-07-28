import 'package:calendar_of_events/models/event_data_source.dart';
import 'package:calendar_of_events/pages/event_viewing_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (selectedEvents.isEmpty) {
    //   return const Center(
    //     child: Text(
    //       'Events not found',
    //       style: TextStyle(color: Colors.white, fontSize: 24),
    //     ),
    //   );
    // }
    return SfCalendarTheme(
      data: SfCalendarThemeData(
          timeTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      )),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        viewHeaderHeight: 50,
        cellBorderColor: Colors.black,
        //dataSource: EventDataSource(provider.events),
        //initialDisplayDate: ,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.greenAccent,
        selectionDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
        ),
        // onTap: (details) {
        //   if (details.appointments == null) return;
        //   final event = details.appointments!.first;
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => EventViewingPage(event: event)));
        // },
      ),
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
