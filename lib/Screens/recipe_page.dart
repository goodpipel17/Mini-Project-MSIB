import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class recipe_details extends StatefulWidget {
  const recipe_details({super.key});

  @override
  State<recipe_details> createState() => _MyWidgetState();
}

int? pageindex;

class _MyWidgetState extends State<recipe_details> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference datacollection = firestore.collection('Recipe');
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
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
          title: Text('MASTHA'),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(top: 15, bottom: 15),
          child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: datacollection.snapshots(),
            builder: (_, snapshot) {
              int page = pageindex!;
              var listalldocs = snapshot.data?.docs;
              if (snapshot.connectionState == ConnectionState.active) {
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            width: 200,
                            height: 200,
                            child: Image.network(
                              "${(listalldocs?[page].data() as Map<String, dynamic>)['imageurl']}",
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(20)),
                        Container(
                          width: 400,
                          height: 500,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "${(listalldocs?[page].data() as Map<String, dynamic>)['name']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      "${(listalldocs?[page].data() as Map<String, dynamic>)['deskripsi']}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center();
              }
            },
          ),
        )));
  }
}
