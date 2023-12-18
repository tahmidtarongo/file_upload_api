import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'add_product_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  Future<void> getImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    // image != null ? productData.image = File(image!.path) : null;
    setState(() {});
  }

  Future<void> getCamera() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  DateTime recordDate = DateTime.now();

  String name = '';
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 40),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        //_________NAME________________________________________________
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name cannot be empty';
                            } else if (value.length < 3) {
                              return 'Please input at least 3 character';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Product Name'),
                          onChanged: (value) {
                            name = value;
                          },
                        ),

                        ///__________Code____________________________________
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Code';
                            } else if (value.length < 3) {
                              return 'Please input at least 3 character';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Product Code'),
                          onChanged: (value) {
                            code = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///____________Image______________________________________________________________
                  const Text(
                    'Product Image',
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black),
                            image: image == null
                                ? const DecorationImage(image: AssetImage('images/no_image.jpeg'), fit: BoxFit.cover)
                                : DecorationImage(image: FileImage(File(image!.path)), fit: BoxFit.cover)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2.0, color: Colors.black),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    {
                                      return AlertDialog(
                                        backgroundColor: Theme.of(context).colorScheme.background,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        title: const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                          height: 60,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.photo_library_outlined,
                                                      size: 30,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        getImage();
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'gallery',
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: 30,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        getCamera();
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'camera',
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  });
                            });
                          },
                          child: const Icon(
                            Icons.camera,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                      onPressed: () async {
                        await addProduct(code: code, name: name, imageFile: File(image!.path));
                      },
                      child: Text('Add Product')),
                ],
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
