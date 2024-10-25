import 'package:tugas1/api.dart';
import 'package:tugas1/create.dart';
import 'package:tugas1/model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override                                                                                            
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ThirdWidget(),
    );
  }
}

class ThirdWidget extends StatefulWidget {
  @override
  _ThirdWidgetState createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  late Api api;

  @override
  void initState() {
    super.initState();
    api = Api();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Blog",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              // Arahkan ke CreateScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateScreen()),
              ).then((value) {
                // Refresh data setelah kembali dari CreateScreen
                setState(() {});
              });
            },
          )
        ],
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Blog>?>(
          future: api.getBlogs(),
          builder: (BuildContext context, AsyncSnapshot<List<Blog>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child:
                    Text("Something went wrong: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Blog>? blogs = snapshot.data; // Allow blogs to be nullable
              if (blogs == null || blogs.isEmpty) {
                return Center(child: Text("Tidak ada data Blog."));
              }
              return _buildListView(blogs);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Blog> blogs) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          Blog blog = blogs[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      blog.title ?? 'Tanpa Judul',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      blog.title_sub ?? 'Tanpa Sub Judul',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Image.network(
                      blog.image_url ?? 'fallback_image_url.png',
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Text('-');
                      },
                    ),
                    SizedBox(height: 8),
                    Text(blog.description ?? 'Tanpa Deskripsi'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
