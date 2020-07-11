import 'dart:convert';

import 'package:encuestdl_app/constants/constants.dart';
import 'package:encuestdl_app/model/Poll.dart';
import 'package:encuestdl_app/screen/ScreenTemplate.dart';
import 'package:encuestdl_app/widget/QuestionWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PollScreen extends StatefulWidget {
  int id;

  PollScreen(int id) {
    this.id = id;
  }

  @override
  State createState() => _PollScreenState(id);
}

class _PollScreenState extends State<PollScreen> {
  _PollScreenState(int id) {
    this.id = id;
  }

  int id;
  int actualQuestion = 0;
  bool answered = false;

  Future<Poll> futurePoll;
  Poll _poll;

  Future<bool> futureQuestionAnswered;
  bool _questionAnswered;

  @override
  void initState() {
    super.initState();
    futurePoll = fetchPoll();
  }

  Future<Poll> fetchPoll() async {
    final response =
        await http.get(Constants.baseUrl + '/poll/${this.id}');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _poll = Poll.fromJson(json.decode(response.body));
      return _poll;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<bool> _checkAnswer(String answer) async {
    final response = await http
        .patch(Constants.baseUrl + '/submit/${this.id}',body: answer);
  }

  _handleQuestionAnswered(String answer) {
    _checkAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Poll>(
        future: futurePoll,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenTemplate(
              child: QuestionWidget(_poll.questions[actualQuestion],_handleQuestionAnswered,)
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return ScreenTemplate(
              child:
                  Container(child: Center(child: CircularProgressIndicator())));
        });
  }
}
