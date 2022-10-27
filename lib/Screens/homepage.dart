import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/Screens/recipe_page.dart';

int index = 0;

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
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
          child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: datacollection.snapshots(),
            builder: (_, snapshot) {
              var listalldocs = snapshot.data?.docs;
              if (snapshot.connectionState == ConnectionState.active) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listalldocs?.length,
                    itemBuilder: (_, index) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              "${(listalldocs?[index].data() as Map<String, dynamic>)['imageurl']}"),
                        ),
                        title: Text(
                          "${(listalldocs![index].data() as Map<String, dynamic>)['name']}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const recipe_details();
                          }));
                          pageindex = index;
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(
                              width: 100,
                            ),
                            Container(
                              child: Text(
                                'LOADING',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
