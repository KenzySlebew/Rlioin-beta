import 'dart:io';
import 'package:flutter/material.dart';
import 'package:belajar_sqflite/main.dart';
import 'db_helper.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  final int? userId;

  const FormPage({Key? key, this.userId}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final DBHelper dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _experienceController = TextEditingController();
  File? _image;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  void _refreshUsers() async {
    final data = await dbHelper.queryAllUsers();
    setState(() {
      _users = data;
    });

    if (widget.userId != null) {
      _loadUser(widget.userId!);
    }
  }

  void _loadUser(int id) {
    final existingUser = _users.firstWhere(
      (element) => element['id'] == id,
      orElse: () => {},
    );
    if (existingUser.isNotEmpty) {
      setState(() {
        _nameController.text = existingUser['name'];
        _addressController.text = existingUser['address'];
        _emailController.text = existingUser['email'];
        _contactController.text = existingUser['contact'];
        _birthdateController.text = existingUser['birthdate'];
        _experienceController.text = existingUser['experience'];
        _image = existingUser['imagePath'] != null
            ? File(existingUser['imagePath'])
            : null;
      });
    } else {
      // Handle the case where the user is not found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not found')),
      );
      Navigator.of(context).pop(false);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _addUser() async {
    await dbHelper.insertUser({
      'name': _nameController.text,
      'address': _addressController.text,
      'email': _emailController.text,
      'contact': _contactController.text,
      'birthdate': _birthdateController.text,
      'experience': _experienceController.text,
      'imagePath': _image?.path,
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  Future<void> _updateUser(int id) async {
    await dbHelper.updateUser({
      'id': id,
      'name': _nameController.text,
      'address': _addressController.text,
      'email': _emailController.text,
      'contact': _contactController.text,
      'birthdate': _birthdateController.text,
      'experience': _experienceController.text,
      'imagePath': _image?.path,
    });
    Navigator.of(context).pop(true); // Indicate success
  }

  _textButtonStyle() => TextButton.styleFrom(
    foregroundColor: Colors.white, // Set text and icon color to white
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Card(  // Changed from Container to Card
              color: Color(0x99002D82),
              shape: RoundedRectangleBorder(  // Added rounded rectangle border
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color(0xFF007BFF), width: 3),
              ),
              child: Padding(  // Added Padding inside Card
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                      ),
                      style: TextStyle(color: Colors.white), // Set text color to white
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ketik nama anda';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat',
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                      ),
                      style: TextStyle(color: Colors.white), // Set text color to white
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ketik alamat anda';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                      ),
                      style: TextStyle(color: Colors.white), // Set text color to white
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ketik email anda';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contactController,
                      decoration: const InputDecoration(
                        labelText: 'Kontak',
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                      ),
                      style: TextStyle(color: Colors.white), // Set text color to white
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ketik nomor telpon anda';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _birthdateController,
                      decoration: const InputDecoration(
                        labelText: 'Tempat Tanggal Lahir',
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                      ),
                      style: TextStyle(color: Colors.white), // Set text color to white
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ketik tempat tanggal lahir anda';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _experienceController,
                      decoration: const InputDecoration(
                        labelText: 'Pengalaman',
                        labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                      ),
                      style: TextStyle(color: Colors.white), // Set text color to white
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ketik pengalaman anda';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _image == null
                        ? TextButton.icon(
                            icon: const Icon(Icons.image),
                            label: Text('Pick Image', style: TextStyle(color: Colors.white)),
                            onPressed: _pickImage,
                            style: _textButtonStyle(),
                          )
                        : Column(
                            children: [
                              Image.file(_image!, height: 200, width: 200), // Ukuran gambar diperbesar
                              TextButton.icon(
                                icon: const Icon(Icons.image),
                                label: Text('Change Image', style: TextStyle(color: Colors.white)),
                                onPressed: _pickImage,
                                style: _textButtonStyle(),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: Text(widget.userId == null ? 'Buat' : 'Perbarui'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.userId == null) {
                            _addUser();
                          } else {
                            _updateUser(widget.userId!);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
