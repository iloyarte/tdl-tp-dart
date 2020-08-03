import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndividualQuestionWidget extends StatefulWidget {
  int questionNumber;

  _IndividualQuestionWidgetState _individualQuestion;

  IndividualQuestionWidget(int questionNumber) {
    this.questionNumber = questionNumber;
  }

  @override
  State<IndividualQuestionWidget> createState() =>
      _individualQuestion = _IndividualQuestionWidgetState(questionNumber);

  bool questionAndTwoOptionsFull() {
    return _individualQuestion._questionAndTwoOptionsFull();
  }

  bool individualQuestionsWithCorrectOptionError() {
    return _individualQuestion.noCorrectOptionSelected();
  }
}

class _IndividualQuestionWidgetState extends State<IndividualQuestionWidget> {
  int questionNumber;
  TextEditingController _questionController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();

  int correctOption = 0;

  _IndividualQuestionWidgetState(int questionNumber) {
    this.questionNumber = questionNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 300,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _questionController,
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pregunta $questionNumber",
                  //labelStyle: TextStyle(fontSize: 0.1),
                  prefixIcon: const Icon(Icons.live_help)),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _option1Controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Opción 1',
                      suffixIcon: Radio(
                        value: 1,
                        groupValue: correctOption,
                        activeColor: Colors.blueGrey[700],
                        onChanged: (newValue) {
                          setState(() {
                            correctOption = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  TextField(
                    controller: _option2Controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Opción 2',
                      suffixIcon: Radio(
                        value: 2,
                        groupValue: correctOption,
                        activeColor: Colors.blueGrey[700],
                        onChanged: (newValue) {
                          setState(() {
                            correctOption = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  TextField(
                    controller: _option3Controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Opción 3',
                      suffixIcon: Radio(
                        value: 3,
                        groupValue: correctOption,
                        activeColor: Colors.blueGrey[700],
                        onChanged: (newValue) {
                          setState(() {
                            correctOption = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  TextField(
                    controller: _option4Controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Opción 4',
                      suffixIcon: Radio(
                        value: 4,
                        groupValue: correctOption,
                        activeColor: Colors.blueGrey[700],
                        onChanged: (newValue) {
                          setState(() {
                            correctOption = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _twoOptionsFull() {
    int optionsFull = 0;
    if (_option1Controller.text.isNotEmpty) optionsFull++;
    if (_option2Controller.text.isNotEmpty) optionsFull++;
    if (_option3Controller.text.isNotEmpty) optionsFull++;
    if (_option4Controller.text.isNotEmpty) optionsFull++;

    return (optionsFull >= 2);
  }

  bool _questionAndTwoOptionsFull() {
    return (_questionController.text.isNotEmpty && _twoOptionsFull());
  }

  bool emptyCorrectOptionSelected(int correctOption) {
    if (correctOption == 1)
      return _option1Controller.text.isEmpty;
    else if (correctOption == 2)
      return _option4Controller.text.isEmpty;
    else if (correctOption == 3)
      return _option3Controller.text.isEmpty;
    else
      return _option4Controller.text.isEmpty;
  }

  bool noCorrectOptionSelected() {
    return ((correctOption == 0) || emptyCorrectOptionSelected(correctOption));
  }
}
