import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:get/get.dart';

class CalendarWeekBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CalendarWeekController());
    Get.lazyPut(() => AddEventController());
  }
}
