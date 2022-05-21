import 'package:flutter/material.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double result = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildCard(
            backgroundColor: Colors.white,
            config: CustomConfig(
              gradients: [
                [Colors.transparent, Colors.transparent],
                [Colors.transparent, Colors.transparent],
                [Colors.transparent, Colors.transparent],
                [
                  Color.fromARGB(255, 146, 7, 75),
                  Color.fromARGB(255, 146, 7, 75)
                ]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.20, 0.23, 0.25, 0.30],
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                myHeader(context),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _weightController,
                        cursorColor: Color.fromARGB(255, 233, 243, 33),
                        decoration: InputDecoration(
                          label: Text('Your weight in kg'),
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 233, 243, 33))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 233, 243, 33))),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please fill in this field';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _heightController,
                        cursorColor: Color.fromARGB(255, 233, 243, 33),
                        decoration: InputDecoration(
                          label: Text('Your height in cm'),
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 233, 243, 33))),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please fill in this field';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            double weight =
                                double.parse(_weightController.text);
                            double height =
                                double.parse(_heightController.text);

                            final double bmi =
                                ((weight / (height * height)) * 10000);

                            setState(() {
                              result = bmi;
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 233, 243, 33),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'CALCULATE',
                            style: TextStyle(color: Colors.black, fontSize: 23),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'YOUR RESULT',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    result == 0.0
                        ? result.toString()
                        : result.toStringAsFixed(2),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 80,
                        color: Color.fromARGB(255, 233, 243, 33)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    result < 18.5
                        ? 'Underweight'
                        : result > 18.5 && result < 24.9
                            ? 'Healthy'
                            : result > 24.9 && result < 29.9
                                ? 'Overweight'
                                : result > 29.9
                                    ? 'Obese'
                                    : 'Could not calculate BMI  correctly',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_buildCard({
  Config? config,
  Color backgroundColor = Colors.transparent,
  DecorationImage? backgroundImage,
}) {
  return SizedBox(
    width: double.infinity,
    child: WaveWidget(
      config: config!,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 0,
    ),
  );
}

Widget myHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border(
        left: BorderSide(width: 7, color: Color.fromARGB(255, 146, 7, 75)),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BMI',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 45,
              color: Color.fromARGB(255, 146, 7, 75)),
        ),
        Text(
          'CALCULATOR',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 45,
          ),
        ),
      ],
    ),
  );
}
