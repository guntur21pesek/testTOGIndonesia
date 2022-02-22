import 'dart:async';
import 'dart:io';

import 'package:app/image_from_gallery.dart';
import 'package:app/model/user.dart';
import 'package:app/pages/output.dart';
import 'package:app/widget/profile_widget.dart';
import 'package:app/widget/util.dart';
// import 'package:app/widget/base_text_field_date_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';

enum ImageSourceType { gallery, camera }

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    super.initState();
    startTimer();
    tgl = _tglController.text;
    imagePicker = new ImagePicker();
  }

  var _image;
  var imagePicker;
  late String tgl;
  bool isButtonActive = true;

  static const maxSeconds = 60;
  int second = maxSeconds;
  Timer? timer;
  late Image imgFromPref;
  late Future<File> imageFile;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (second > 0) {
        setState(() {
          second--;
          isButtonActive;
        });
      } else {
        _button(context) == false;
        // isButtonActive = false;
      }
    });
  }

  Future getImage() async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image!.path);
      Utility.saveImageToPref(Utility.base64String(_image.readAsBytes()));
      // imagePath = _image;
    });
  }

  loadImageFromPref() {
    Utility.getImageFromPref().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imgFromPref = Utility.imageFromBase64String(img);
      });
    });
  }

  // late User user;

  DateTime _selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2030));

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _tglController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TextEditingController _namaController = new TextEditingController();
  TextEditingController _alamatContoller = new TextEditingController();
  TextEditingController _tglController = new TextEditingController();
  TextEditingController _tinggiController = new TextEditingController();
  TextEditingController _beratController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromARGB(255, 189, 174, 41),
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Body,
                  _button(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _Body => Expanded(
          child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 800.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0))),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    // imagePath = _image,
                    // ProfileWidget(
                    //   imagePath: _image,
                    //   isEdit: true,
                    //   onCliked: () async {
                    //     getImage();
                    //   },
                    // ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        buildImage(),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: buildEditIcon(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    new TextField(
                      controller: _namaController,
                      maxLength: 50,
                      decoration: new InputDecoration(
                          hintText: "Nama",
                          labelText: "Nama",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          )),
                    ),
                    SizedBox(height: 5),
                    new TextField(
                      controller: _alamatContoller,
                      maxLength: 200,
                      decoration: new InputDecoration(
                          hintText: "Alamat",
                          labelText: "Alamat",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          )),
                    ),
                    SizedBox(height: 5),
                    new TextField(
                      controller: _tglController,
                      decoration: new InputDecoration(
                          hintText: "Tanggal Lahir",
                          labelText: "Tanggal Lahir",
                          prefixIcon: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Icon(Icons.calendar_today),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          )),
                    ),
                    SizedBox(height: 10),
                    new TextField(
                      controller: _tinggiController,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Tinggi",
                          labelText: "Tinggi",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          )),
                    ),
                    SizedBox(height: 5),
                    new TextField(
                      controller: _beratController,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Berat",
                          labelText: "Berat",
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Color.fromARGB(255, 7, 44, 87),
                      child: Text(
                        "Pick Image from Camera",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      onPressed: getImage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));

  Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: Colors.white,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      Container(
        padding: EdgeInsets.all(all),
        color: Colors.transparent,
        child: child,
      );

  Widget buildImage() {
    return ClipOval(
      child: Material(
        child: Container(
          height: 128,
          width: 128,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Center(
            child: _image == null
                ? Icon(Icons.person)
                : Image.file(
                    _image,
                    width: 128.0,
                    height: 128.0,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              // imagePath = _image;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OutputPage(
                  imagePath: _image,
                  name: _namaController.text,
                  alamat: _alamatContoller.text,
                  tglLahir: _tglController.text,
                  tinggi: _tinggiController.text,
                  berat: _beratController.text,
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              width: double.infinity,
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 44, 87),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
