import 'package:calendar_of_events/pages/add_event/widgets/events_list_widget.dart';
import 'package:calendar_of_events/pages/add_event/widgets/top_sliver_box.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          body: CustomScrollView(
            slivers: [
              TopSliverBox(),
              EventsListWidget(),
            ],
          ),
        ));
  }
}
