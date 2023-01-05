// import 'package:calendar_of_events/models/event_model.dart';
// import 'package:flutter/material.dart';

// class EventEditingPage extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   EventEditingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.green.shade700,
//           leading: CloseButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.done),
//             ),
//           ]),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(10),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 style: const TextStyle(fontSize: 20),
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   hintText: 'Add title of the event',
//                 ),
//                 onFieldSubmitted: (_) {},
//                 validator: (title) => title != null && title.isEmpty
//                     ? 'Title cannot be empty'
//                     : null,
//                 //controller: titleController,
//                 onChanged: (value) {},
//               ),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: dropDownField(
//                           text: 'text',
//                           onClicked: () {},
//                         ),
//                       ),
//                       Expanded(
//                         child: dropDownField(
//                           text: 'text',
//                           onClicked: () {},
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: dropDownField(
//                           text: 'text',
//                           onClicked: () {},
//                         ),
//                       ),
//                       Expanded(
//                         child: dropDownField(
//                           text: 'text',
//                           onClicked: () {},
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget dropDownField({
//     required String text,
//     required VoidCallback onClicked,
//   }) =>
//       ListTile(
//         title: Text(text),
//         trailing: const Icon(Icons.arrow_drop_down),
//         onTap: onClicked,
//       );

//   Future<void> pickstartEventTime(BuildContext context, Event selectedEvent,
//       {required bool pickDate}) async {
//     final date =
//         await pickDateTime(context, selectedEvent.start, pickDate: pickDate);
//     if (date != null) {
//       if (date.isAfter(selectedEvent.finish)) {
//         selectedEvent.finish = DateTime(
//           date.year,
//           date.month,
//           date.day,
//           selectedEvent.finish.hour,
//           selectedEvent.finish.minute,
//         );
//       }
//       selectedEvent.start = date;
//     }
//   }

//   Future<void> pickfinishEventTime(BuildContext context, Event selectedEvent,
//       {required bool pickDate}) async {
//     final date = await pickDateTime(
//       context,
//       selectedEvent.finish,
//       pickDate: pickDate,
//       firstDate: pickDate ? selectedEvent.start : null,
//     );
//     selectedEvent.finish = date ?? selectedEvent.finish;
//   }

//   Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate,
//       {required bool pickDate, DateTime? firstDate}) async {
//     if (pickDate) {
//       final date = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: firstDate ?? DateTime(2022, 1),
//         lastDate: DateTime(2100),
//       );
//       if (date == null) {
//         return null;
//       } else {
//         final Duration time =
//             Duration(hours: initialDate.hour, minutes: initialDate.minute);
//         return date.add(time);
//       }
//     } else {
//       final timeOfDay = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(initialDate),
//       );
//       if (timeOfDay == null) {
//         return null;
//       } else {
//         final date =
//             DateTime(initialDate.year, initialDate.month, initialDate.day);
//         final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
//         return date.add(time);
//       }
//     }
//   }

//   Future<void> updateForm(BuildContext context, Event updateEvent) async {
//     final bool isValid = _formKey.currentState!.validate();
//     if (isValid) {}
//   }
// }
