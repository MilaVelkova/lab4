import 'package:flutter/material.dart';
import '../models/Event.dart';

class EventDetailsDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final DateTime selectedDay;
  final Function(Event) onSaveEvent;

  EventDetailsDialog({required this.selectedDay, required this.onSaveEvent});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Додај настан'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Предмет'),
          ),
          TextField(
            controller: locationController,
            decoration: InputDecoration(labelText: 'Локација'),
          ),
          TextField(
            controller: timeController,
            decoration: InputDecoration(labelText: 'Време'),
            keyboardType: TextInputType.datetime,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (titleController.text.isNotEmpty) {
              final event = Event(
                title: titleController.text,
                date: selectedDay,
                location: locationController.text,
                time: timeController.text,
              );
              onSaveEvent(event);
              Navigator.of(context).pop();
            }
          },
          child: Text('Додај'),
        ),
      ],
    );
  }
}
