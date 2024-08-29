import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenwidth * 0.06,
          ),
        ),
      ), //AppBar
      backgroundColor: const Color.fromARGB(97, 97, 94, 94),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              color: const Color.fromARGB(97, 97, 94, 94),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    //User Input section
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            userInput,
                            style: TextStyle(
                                fontSize: screenwidth * 0.08,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        //Output section
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            answer,
                            style: TextStyle(
                                fontSize: 0.09 * screenwidth,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // margin: EdgeInsets.fromLTRB(0, 36, 0, 0),
              padding: const EdgeInsets.all(5.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 144, 165, 165),
              ),
              child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(screenwidth * 0.01,
                      screenheight * 0.04, screenwidth * 0.01, 0),
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio:
                        screenwidth / screenheight * 2, //adjust button
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }

                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            int len = userInput.length;
                            int start = len - 1, end = len - 1;

                            while (
                                start >= 0 && !isOperator(userInput[start])) {
                              start--;
                              if (start < 0) break;
                            }

                            int lastIntSize = end - start;
                            // Check if the userInput is not empty
                            if (userInput.isNotEmpty) {
                              // Remove leading '-' if  length is  less than or equal to 2

                              // Check if last character is not an operator or a negative sign
                              if (len == 1) {
                                // there is a single character without leading '-' then add '-' before the character
                                userInput = '-$userInput';
                              } else if ((len - lastIntSize) == 0) {
                                userInput = '-$userInput';
                              } else {
                                // if (last - 1) character is a negative sign && length is greater than 2
                                if (len - lastIntSize == 1) {
                                  userInput = userInput.substring(
                                          0, len - lastIntSize - 1) +
                                      userInput.substring(len - lastIntSize);
                                } else if (isOperator(
                                    userInput[len - lastIntSize - 2])) {
                                  // if (last - 2) character is an operator && (last-1) character is an operator
                                  userInput = userInput.substring(
                                          0, len - lastIntSize - 1) +
                                      userInput.substring(len - lastIntSize);
                                } else if (isOperator(userInput[len - 1])) {
                                  // if (last) character is an operator
                                  userInput = userInput;
                                } else {
                                  // if (last-2) character is not an operator
                                  userInput =
                                      '${userInput.substring(0, len - lastIntSize)}-${userInput.substring(len - lastIntSize)}';
                                }
                              }
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            answer = (double.parse(userInput) / 100).toString();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange[700],
                        textColor: Colors.white,
                      );
                    }

                    // other buttons
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            int len = userInput.length;

                            if (len >= 1 &&
                                isOperator(userInput[len - 1]) &&
                                isOperator(buttons[index])) {
                              userInput = userInput.substring(0, len - 1) +
                                  buttons[index];
                            } else {
                              userInput += buttons[index];
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = finalUserInput.replaceAll('x', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalUserInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result
      String evalString = eval.toString();

      if (evalString.endsWith(".0")) {
        evalString = evalString.substring(0, evalString.length - 2);
      }
      setState(() {
        if (evalString.compareTo('Infinity') == 0) {
          evalString = 'Can not divide by zero';
        }
        answer = evalString;
      });
    } catch (e) {
      // Handle errors (such as division by zero)
      setState(() {
        answer = 'Error';
      });
    }
  }
}
