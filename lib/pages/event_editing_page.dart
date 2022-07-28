// import 'package:calendar_of_events/models/event_model.dart';
// import 'package:calendar_of_events/models/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class EventEditingPage extends StatefulWidget {
//   final Event? event;
//   const EventEditingPage({
//     Key? key,
//     required this.event,
//   }) : super(key: key);

//   @override
//   _EventEditingPageState createState() => _EventEditingPageState();
// }

// class _EventEditingPageState extends State<EventEditingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   late DateTime startEvent;
//   late DateTime finishEvent;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.event == null) {
//       startEvent = DateTime.now();
//       finishEvent = DateTime.now().add(const Duration(hours: 2));
//     } else {
//       final event = widget.event!;

//       titleController.text = event.title;
//       startEvent = event.from;
//       finishEvent = event.to;
//     }
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           leading: const CloseButton(),
//           actions: editingActions(),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(10),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   style: const TextStyle(fontSize: 24),
//                   decoration: const InputDecoration(
//                     border: UnderlineInputBorder(),
//                     hintText: 'Add Title',
//                   ),
//                   onFieldSubmitted: (_) => saveForm(),
//                   validator: (title) => title != null && title.isEmpty
//                       ? 'Title cannot be empty'
//                       : null,
//                   controller: titleController,
//                 ),
//                 duildDateTime(),
//               ],
//             ),
//           ),
//         ),
//       );

//   List<Widget> editingActions() => [
//         IconButton(
//           onPressed: saveForm,
//           icon: const Icon(Icons.done),
//         )
//       ];

//   Widget duildDateTime() => Column(
//         children: [
//           duildFrom(),
//           duildTo(),
//         ],
//       );

//   Widget duildFrom() => Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: dropDownField(
//               text: Utils.toDate(startEvent),
//               onClicked: () => pickstartEventTime(
//                 pickDate: true,
//               ),
//             ),
//           ),
//           Expanded(
//             child: dropDownField(
//               text: Utils.toTime(startEvent),
//               onClicked: () => pickstartEventTime(pickDate: false),
//             ),
//           )
//         ],
//       );

//   Future<DateTime?> pickDateTime(DateTime initialDate,
//       {required bool pickDate, DateTime? firstDate}) async {
//     if (pickDate) {
//       final date = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: firstDate ?? DateTime(2020, 1),
//         lastDate: DateTime(2100),
//       );
//       if (date == null) return null;

//       final Duration time =
//           Duration(hours: initialDate.hour, minutes: initialDate.minute);
//       return date.add(time);
//     } else {
//       final timeOfDay = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(initialDate),
//       );
//       if (timeOfDay == null) return null;
//       final date =
//           DateTime(initialDate.year, initialDate.month, initialDate.day);
//       final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
//       return date.add(time);
//     }
//   }

//   Widget duildTo() => Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: dropDownField(
//               text: Utils.toDate(finishEvent),
//               onClicked: () => pickfinishEventTime(pickDate: true),
//             ),
//           ),
//           Expanded(
//             child: dropDownField(
//               text: Utils.toTime(finishEvent),
//               onClicked: () => pickfinishEventTime(pickDate: false),
//             ),
//           )
//         ],
//       );

//   Widget dropDownField({
//     required String text,
//     required VoidCallback onClicked,
//   }) =>
//       ListTile(
//         title: Text(text),
//         trailing: const Icon(Icons.arrow_drop_down),
//         onTap: onClicked,
//       );

//   Future pickstartEventTime({required bool pickDate}) async {
//     final date = await pickDateTime(startEvent, pickDate: pickDate);
//     if (date == null) return;
//     if (date.isAfter(finishEvent)) {
//       finishEvent = DateTime(
//         date.year,
//         date.month,
//         date.day,
//         finishEvent.hour,
//         finishEvent.minute,
//       );
//     }
//     setState(() => startEvent = date);
//   }

//   Future pickfinishEventTime({required bool pickDate}) async {
//     final date = await pickDateTime(
//       finishEvent,
//       pickDate: pickDate,
//       firstDate: pickDate ? startEvent : null,
//     );
//     if (date == null) return;
//     setState(() => finishEvent = date);
//   }

//   Future saveForm() async {
//     final isValid = _formKey.currentState!.validate();

//     if (isValid) {
//       final event = Event(
//         title: titleController.text,
//         description: 'Description',
//         from: startEvent,
//         to: finishEvent,
//         isAllDay: false,
//       );

//       final isEditing = widget.event != null;
//       final provider = Provider.of<EventProvider>(context, listen: false);

//       if (isEditing) {
//         provider.editEvent(event, widget.event!);
//         Navigator.of(context).pop();
//       } else {
//         provider.addEvent(event);
//       }
//     }
//   }
// }
