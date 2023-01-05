import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:calendar_of_events/pages/home_page.dart';
import 'package:flutter/material.dart';

class EventViewingPage extends StatelessWidget {
  const EventViewingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        //actions: buildViewingActions(context, state.selectedEvent!),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Center(
            child: Text(
              'text',
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'text',
          ),
          const SizedBox(height: 20),
          Text(
            'text',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) => [
        IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            }),
      ];
}
