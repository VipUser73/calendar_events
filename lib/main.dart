import 'package:calendar_of_events/bloc/calendar_bloc.dart';
import 'package:calendar_of_events/pages/home_page.dart';
import 'package:calendar_of_events/repository/local_repository.dart';
import 'package:calendar_of_events/services/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(CalendarApp());

class CalendarApp extends StatelessWidget {
  CalendarApp({Key? key}) : super(key: key);
  final LocalRepository _storageRepository = LocalRepository(DBProvider());

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: _storageRepository,
        child: BlocProvider<CalendarBloc>(
          create: (context) => CalendarBloc(context.read<LocalRepository>()),
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: const HomePage()),
        ),
      );
}
