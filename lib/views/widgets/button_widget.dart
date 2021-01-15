import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String textButton;
  final Function onPress;
  final Color color;
  const ButtonWidget({
    Key key,
    this.textButton,
    this.onPress,
    this.color = Colors.lightBlueAccent,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: onPress,
          color: color,
          child: Text(
            textButton,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
