// import 'package:calendar_of_events/models/event_model.dart';
// import 'package:calendar_of_events/pages/event_editing_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class EventViewingPage extends StatelessWidget {
//   final Event event;
//   const EventViewingPage({
//     Key? key,
//     required this.event,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         leading: const CloseButton(),
//         actions: buildViewingActions(context, event),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(30),
//         children: [
//           buildDateTime(event),
//           const SizedBox(height: 30),
//           Text(
//             event.title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             event.description,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ));

//   Widget buildDateTime(Event event) {
//     return Column(
//       children: [
//         buildDate(event.isAllDay ? 'Allday' : 'From', event.from),
//         if (!event.isAllDay) buildDate('To', event.to),
//       ],
//     );
//   }

//   Widget buildDate(String title, DateTime date) {
//     return Text('$title $date');
//   }

//   List<Widget> buildViewingActions(BuildContext context, Event event) => [
//         IconButton(
//           icon: const Icon(Icons.edit),
//           onPressed: () => Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                   builder: (context) => EventEditingPage(event: event))),
//         ),
//         IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               final provider =
//                   Provider.of<EventProvider>(context, listen: false);
//               provider.deleteEvent(event);
//               Navigator.of(context).pop();
//             }),
//       ];
// }
