import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstWidget(),
    );
  }
}

class FirstWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Blog Awal'),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          // Tambahkan Tombol di atas Grid
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke AddDataWidget
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDataWidget()),
                    );
                  },
                  child: Text('Tambah Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke EditDataWidget
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDataWidget(
                          currentName: 'Default Name',
                          currentDescription: 'Default Description',
                        ),
                      ),
                    );
                  },
                  child: Text('Edit Data'),
                ),
              ],
            ),
          ),
          // Tambahkan Grid di bawah tombol
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Jumlah kolom dalam grid
              children: List.generate(100, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Adding Data
class AddDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add data logic will go here
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Editing Data
class EditDataWidget extends StatelessWidget {
  final String currentName;
  final String currentDescription;

  EditDataWidget({required this.currentName, required this.currentDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Edit Item Name',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: currentName),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Edit Description',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: currentDescription),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Edit data logic will go here
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}