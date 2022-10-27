import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class kalkulator_page extends StatefulWidget {
  @override
  State<kalkulator_page> createState() => _kalkulator_pageState();
}

class _kalkulator_pageState extends State<kalkulator_page> {
  final TextEditingController heightcontroller = TextEditingController();

  final TextEditingController weightcontroller = TextEditingController();
  String _message = 'Masukan Tinggi dan berat badan anda';

  double height = 0;
  double weight = 0;

  double _hasil = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.0),
          ),
        ),
        titleTextStyle: GoogleFonts.robotoSlab(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
        title: const Text('BMI Kalkulator'),
      ),
      body: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: 420,
          height: 430,
          child: Center(
            child: Row(
              children: [
                Container(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextFormField(
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.number,
                          controller: weightcontroller,
                          decoration: InputDecoration(
                              hintText: "Masukan Berat badan",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide()),
                              labelText: 'Berat badan'),
                        ),
                        TextField(
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.number,
                          controller: heightcontroller,
                          decoration: InputDecoration(
                              hintText: "Masukan Tinggi badan",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  borderSide: const BorderSide()),
                              labelText: 'Tinggi Badan'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 90,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.greenAccent)),
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Column(
                            children: [
                              Text(
                                _hasil == null
                                    ? 'No Result'
                                    : _hasil.toStringAsFixed(2),
                                style: GoogleFonts.poppins(
                                    fontSize: 50, color: Colors.black54),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                _message,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 18, color: Colors.black54),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(420, 50),
                                  backgroundColor: Colors.greenAccent.shade700,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {
                                if (heightcontroller.text == 0 ||
                                    weightcontroller.text == 0) {
                                  heightcontroller.text = "0";
                                  weightcontroller.text = "0";
                                } else {
                                  calculateBMI();
                                }
                              },
                              child: Text(
                                'HITUNG BMI',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void calculateBMI() {
    height = double.parse(heightcontroller.text) / 100;
    weight = double.parse(weightcontroller.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;
    _hasil = result;
    setState(() {
      if (height == null || height <= 0 || weight == null || weight <= 0) {
        setState(() {
          _message =
              "Masukan Tinggi dan berat badan anda atau Gunakan bilangan bulat lebih dari Nol";
          _hasil = 0;
        });
        return;
      }
      _hasil = weight / (height * height);
      if (_hasil < 18.5) {
        _message = "Anda Sekarang Kekurangan berat badan ";
      } else if (_hasil < 25) {
        _message = 'Berat Badan Anda ideal';
      } else if (_hasil < 30) {
        _message = 'Anda Kelebihan berat badan';
      } else {
        _message = 'Anda sekarang obesitas';
      }
    });
  }
}
