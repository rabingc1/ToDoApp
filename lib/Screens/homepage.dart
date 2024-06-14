import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import '../Controller/item_controller.dart';
import '../Model/to_do_model.dart';
import 'complete_task_page.dart';
import 'local_Json_Data.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ItemController _itemController = ItemController();

  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  void _showForm({int? index}) {
    String title = '';
    String description = '';

    if (index != null) {
      title = _itemController.items[index].title;
      description = _itemController.items[index].description;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 700,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => title = value,
                      controller: TextEditingController(text: title),
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => description = value,
                      controller: TextEditingController(text: description),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (index == null) {
                            _itemController.addItem(title, description);
                          } else {
                            _itemController.editItem(index!, title, description);
                          }
                          setState(() {});
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(index == null ? 'Add' : 'Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('ToDo App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
              child: Center(
                child: Text(
                  'Menu ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.done_all),
              title: Text('Task Completed'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        complete_task_page(_itemController.completedItems),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pending),
              title: Text('Pending'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.api_outlined),
              title: Text('Local Json Data '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => data(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _itemController.items.length,
        itemBuilder: (context, index) {
          final Item item = _itemController.items[index];
          return Card(
            color:
            index % 2 == 0 ? Colors.lightBlue[50] : Colors.lightGreen[50],
            child: ListTile(
              title: Text(item.title, style: TextStyle(color: Colors.green)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(DateFormat.yMMMd().format(item.uploadDateTime),
                          style: TextStyle(fontSize: 12)),
                      SizedBox(width: 16),
                      Icon(Icons.watch_later, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(DateFormat.jm().format(item.uploadDateTime),
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
              leading: item.isCompleted
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.pending_actions, color: Colors.red), // Added note icon
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Edit') {
                    _showForm(index: index);
                  } else if (value == 'Delete') {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete'),
                        content:
                        Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _itemController.deleteItem(index);
                              setState(() {});
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text('Task deleted',style: TextStyle(color: Colors.white),)),
                              );
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  } else if (value == 'Task_Complete') {
                    _itemController.completeItem(index);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                         backgroundColor: Colors.greenAccent,
                          content: Text('Task marked as completed')),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                  const PopupMenuItem(
                    value: 'Task_Complete',
                    child: Text('Task Complete'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () => _showForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
