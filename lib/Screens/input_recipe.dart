import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

String? imageURl;
String? imagepath;
File? imageasli;

class input_recipe extends StatefulWidget {
  @override
  State<input_recipe> createState() => _input_recipeState();
}

class _input_recipeState extends State<input_recipe> {
  final TextEditingController titlecontroller = TextEditingController();

  final TextEditingController deskripsicontroller = TextEditingController();

  Future _getimage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      File? image = File(selectedImage!.path);
      imageasli = image;
      imagepath = basename(imageasli!.path);
    });
  }

  Future _clear() async {
    setState(() {
      imageasli == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    clear() {
      setState(() {
        imageasli == null;
      });
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference datacollection = firestore.collection('Recipe');
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15.0),
            ),
          ),
          titleTextStyle: GoogleFonts.robotoSlab(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          elevation: 0.0,
          title: const Text('MASTHA'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: 450,
                    height: 500,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 30,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          (imageasli == null)
                                              ? const Text('Select Gambar')
                                              : uploudarea(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 15),
                                      child: TextFormField(
                                        style: GoogleFonts.poppins(),
                                        controller: titlecontroller,
                                        decoration: InputDecoration(
                                            hintText: "Masukan Nama Resep",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide()),
                                            labelText: 'Nama resep'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 15),
                                      child: TextFormField(
                                        controller: deskripsicontroller,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 18,
                                        decoration: InputDecoration(
                                          hintText: "Description",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide()),
                                          labelText: 'Decription',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          90,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Container(
                  decoration: const BoxDecoration(),
                  height: 80,
                  width: 420,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(420, 50),
                        backgroundColor: Colors.greenAccent.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () async {
                      if (imageasli == null) {
                        const Text('Masukan Gambar');
                      } else {
                        await uploudimage();
                        datacollection.add({
                          'imagepath': imagepath,
                          'imageurl': imageURl,
                          'name': titlecontroller.text,
                          'deskripsi': deskripsicontroller.text
                        });

                        titlecontroller.text = '';
                        deskripsicontroller.text = '';
                      }
                    },
                    child: Text(
                      'Add Data',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent.shade700,
          onPressed: _getimage,
          tooltip: 'Increment',
          child: const Icon(
            Icons.image_search_outlined,
          ),
        ));
  }
}

Widget uploudarea() {
  return Column(
    children: <Widget>[
      Image.file(
        imageasli!,
        width: double.infinity,
      )
    ],
  );
}

uploudimage() async {
  Reference storageRef = FirebaseStorage.instance.ref(imagepath);
  UploadTask uploadTask = storageRef.putFile(imageasli!);
  var downURL =
      await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
  var url = downURL.toString();
  imageURl = url;
  print("Download : $url");
  return imageURl!;
}
