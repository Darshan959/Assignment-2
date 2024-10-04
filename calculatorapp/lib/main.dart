import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0"; // Display output
  String _operand = ""; // Holds the current operator (+, -, *, /)
  double _num1 = 0.0; // First operand
  double _num2 = 0.0; // Second operand

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear button resets the calculator
        _output = "0";
        _operand = "";
        _num1 = 0.0;
        _num2 = 0.0;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        // Operator button is pressed, store the first number and the operator
        _num1 = double.parse(_output);
        _operand = buttonText;
        _output = "0"; // Reset display for second number
      } else if (buttonText == "=") {
        // Equals button calculates the result
        _num2 = double.parse(_output);

        // Perform the operation based on the operand
        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "*":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            if (_num2 != 0) {
              _output = (_num1 / _num2).toString();
            } else {
              _output = "Error"; // Handle division by zero
            }
            break;
        }
        _operand = ""; // Reset the operator
      } else {
        // Handle numbers and decimal point input
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  // Function to create calculator buttons
  Widget _buildButton(String buttonText) {
    return Expanded(
      child: InkWell(
        onTap: () => _buttonPressed(buttonText),
        child: Container(
          height: 80.0,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          // Display area
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          // Button layout
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("C"),
                  _buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
