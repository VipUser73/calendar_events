import 'package:calendar_of_events/get_routes.dart';
import 'package:calendar_of_events/pages/add_event/add_event_page.dart';
import 'package:calendar_of_events/pages/calendar_month/calendar_month_page.dart';
import 'package:calendar_of_events/pages/calendar_week/calendar_week_binding.dart';
import 'package:calendar_of_events/pages/calendar_week/calendar_week_page.dart';
import 'package:get/get.dart';

final List<GetPage> pages = [
  GetPage(
    name: Routes.initial,
    page: () => const CalendarWeekPage(),
    binding: CalendarWeekBinding(),
  ),
  GetPage(
    name: Routes.addEventPage,
    page: () => const AddEventPage(),
  ),
  GetPage(
    name: Routes.calendarMonthPage,
    page: () => const CalendarMonthPage(),
  ),
];
