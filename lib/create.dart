import 'package:tugas1/api.dart';
import 'package:tugas1/model.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool _isLoading = false;
  late Api _api = Api();

  // Inisialisasi variabel boolean untuk validasi field
  bool _isFieldTitleValid = false;
  bool _isFieldTitleSubValid = false;
  bool _isFieldKategoriValid = false;
  bool _isFieldDescriptionValid = false;

  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerTitleSub = TextEditingController();
  TextEditingController _controllerKategori = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Tambah Blog",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldTitle(),
                _buildTextFieldTitleSub(),
                _buildTextFieldKategori(),
                _buildTextFieldDescription(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitBlog, // Disable button if loading
                    child: Text(
                      "Simpan".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (_isLoading)
            Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _submitBlog() async {
    // Validate fields
    if (!_isFieldTitleValid ||
        !_isFieldTitleSubValid ||
        !_isFieldKategoriValid ||
        !_isFieldDescriptionValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Create Blog object
    Blog newBlog = Blog(
      title: _controllerTitle.text,
      title_sub: _controllerTitleSub.text, // Change to title_sub
      category: _controllerKategori.text, // Change to category
      description: _controllerDescription.text,
    );

    // Save Blog data
    bool success = await _api.createBlog(newBlog);
    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Blog created successfully!")),
      );
      Navigator.pop(context); // Close the CreateScreen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create blog")),
      );
    }
  }

  Widget _buildTextFieldTitle() {
    return TextField(
      controller: _controllerTitle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Judul",
        errorText: _isFieldTitleValid ? null : "Isi judul",
      ),
      onChanged: (value) {
        setState(() {
          _isFieldTitleValid = value.trim().isNotEmpty;
        });
      },
    );
  }

  Widget _buildTextFieldTitleSub() {
    return TextField(
      controller: _controllerTitleSub,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Sub Judul",
        errorText: _isFieldTitleSubValid ? null : "Isi sub judul",
      ),
      onChanged: (value) {
        setState(() {
          _isFieldTitleSubValid = value.trim().isNotEmpty;
        });
      },
    );
  }

  Widget _buildTextFieldKategori() {
    return TextField(
      controller: _controllerKategori,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kategori",
        errorText: _isFieldKategoriValid ? null : "Isi kategori",
      ),
      onChanged: (value) {
        setState(() {
          _isFieldKategoriValid = value.trim().isNotEmpty;
        });
      },
    );
  }

  Widget _buildTextFieldDescription() {
    return TextField(
      controller: _controllerDescription,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Deskripsi",
        errorText: _isFieldDescriptionValid ? null : "Isi deskripsi",
      ),
      onChanged: (value) {
        setState(() {
          _isFieldDescriptionValid = value.trim().isNotEmpty;
        });
      },
    );
  }
}