import 'package:flutter/material.dart';

class BaseTextFieldDatePicker extends StatefulWidget {
  const BaseTextFieldDatePicker(
      {Key? key,
      required this.textTitle,
      required this.textHint,
      required this.controllerDate,
      required this.onTap})
      : super(key: key);

  final String textTitle;
  final String textHint;
  final TextEditingController controllerDate;
  final Function onTap;

  @override
  _BaseTextFieldDatePickerState createState() =>
      _BaseTextFieldDatePickerState();
}

class _BaseTextFieldDatePickerState extends State<BaseTextFieldDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.textTitle,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              controller: widget.controllerDate,
              readOnly: true,
              onTap: () async {
                widget.onTap();
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(224, 225, 225, 1),
                filled: true,
                hintText: widget.textHint,
                hintStyle: TextStyle(fontSize: 10),
                contentPadding: EdgeInsets.only(left: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BaseTextFieldDate extends StatefulWidget {
  const BaseTextFieldDate(
      {Key? key,
      required this.textTitle,
      required this.textHint,
      required this.controllerDate,
      required this.onTap})
      : super(key: key);
  final String textTitle;
  final String textHint;
  final TextEditingController controllerDate;
  final Function onTap;

  @override
  _BaseTextFieldDateState createState() => _BaseTextFieldDateState();
}

class _BaseTextFieldDateState extends State<BaseTextFieldDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.textTitle,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
          Container(
            height: 40,
            child: TextField(
              controller: widget.controllerDate,
              readOnly: true,
              onTap: () async {
                widget.onTap();
              },
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.blue)),
                  hintText: widget.textHint,
                  hintStyle: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
