import 'package:app/model/user.dart';
import 'package:app/widget/profile_widget.dart';
import 'package:app/widget/util.dart';
import 'package:flutter/material.dart';

class OutputPage extends StatefulWidget {
  final imagePath;
  final name;
  final alamat;
  final tglLahir;
  final tinggi;
  final berat;

  OutputPage(
      {required this.imagePath,
      required this.name,
      required this.alamat,
      required this.tglLahir,
      required this.tinggi,
      required this.berat});

  @override
  _OutputPageState createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 189, 174, 41),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            _Body2,
          ],
        ),
      ),
    );
  }

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
            child: widget.imagePath == null
                ? Icon(Icons.person)
                : Image.file(
                    widget.imagePath,
                    width: 128.0,
                    height: 128.0,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  Widget get _Body2 => Expanded(
          child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 600.0,
                width: 450.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
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
                      SizedBox(
                        height: 20,
                      ),
                      buildAbout(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ));

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text(
              'About',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, height: 2.0),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.name,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.alamat,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.tglLahir,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.tinggi,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.berat,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
