import 'package:flutter/material.dart';

class AdminResourceDetailScreen extends StatefulWidget {
  final String sectionName;

  AdminResourceDetailScreen({required this.sectionName});

  @override
  _AdminResourceDetailScreenState createState() =>
      _AdminResourceDetailScreenState();
}

class _AdminResourceDetailScreenState extends State<AdminResourceDetailScreen> {
  List<Map<String, String>> items = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    items = [
      {"title": "Sample Title", "description": "Sample Detail"},
      {"title": "Another Item", "description": "More details"},
    ];
  }

  void _addItem() {
    setState(() {
      items.add({"title": "New Item", "description": "Description"});
    });
  }

  void _editItem(int index) {
    // You can show a dialog or navigate to a form
    setState(() {
      items[index]["title"] = "Edited Title";
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage ${widget.sectionName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text(item["title"] ?? ''),
              subtitle: Text(item["description"] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _editItem(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteItem(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
