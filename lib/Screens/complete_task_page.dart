
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/to_do_model.dart';

class complete_task_page extends StatelessWidget {
   final List<Item> completedItems;
   const complete_task_page(this.completedItems, );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: completedItems.length,
        itemBuilder: (context, index) {
          final Item item = completedItems[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.description),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(DateFormat.yMMMd().format(item.uploadDateTime), style: TextStyle(fontSize: 12)),
                    SizedBox(width: 16),
                    Icon(Icons.watch_later, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(DateFormat.jm().format(item.uploadDateTime), style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
