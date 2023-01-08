import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:calendar_of_events/pages/add_event/add_event_page.dart';
import 'package:calendar_of_events/pages/view_week/view_week_page.dart';
import 'package:calendar_of_events/text_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const CalendarApp());

class CalendarApp extends StatelessWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.blue,
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 32, 1)),

      debugShowCheckedModeBanner: false,
      translations: TextResources(),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('ru'),
      ],
      //locale: Get.deviceLocale,
      locale: const Locale('ru'),
      //theme: ThemeData.dark(),
      getPages: [
        GetPage(name: '/', page: () => ViewWeekPage()),
        GetPage(name: '/add_event', page: () => AddEventPage()),
      ],
    );
  }
}
