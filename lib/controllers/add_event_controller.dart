import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/services/db_provider.dart';
import 'package:get/get.dart';

class AddEventController extends GetxController {
  final CalendarWeekController calendarWeekController = Get.find();
  final dbProvider = DBProvider();

  Rx<DateTime> selectedDate = Get.arguments ??
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;

  void addEvent(Event event) async {
    await dbProvider.addEvent(event);
    calendarWeekController.onInit();
  }
}
