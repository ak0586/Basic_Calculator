import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final  dynamic color;
  final Color textColor;
  final String buttonText;
  final VoidCallback buttontapped;
  final Color transformcolor = const Color.fromARGB(255, 7, 231, 14);
  const MyButton({
    super.key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.buttontapped,
  });

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    // double screenheight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.buttontapped();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(2),
        transform: Matrix4.identity()..scale(_isTapped ? 0.95 : 1.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          color:
              _isTapped ? widget.transformcolor.withOpacity(0.8) : widget.color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: widget.textColor,
              fontSize: screenwidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
