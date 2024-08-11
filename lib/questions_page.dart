import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/history_page.dart';
import 'package:quiz/provider/main_provider.dart';
import 'package:quiz/result_page.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {

  final List<String> _listQuestions = [
    "2 + 2",
    "(34 - 2 + 8) * 0",
    "2 + 2 * 2",
    "√81",
  ];

  final List<List<String>> _listAnswerOptions = [
    ["4", "20", "3", "5"],
    ["1", "0", "43", "78"],
    ["55", "2", "6", "90"],
    ["32", "12", "66", "9"],
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        if (value.mainState.questionNumber == 4) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResultPage(listQuestions: _listQuestions),
              ),
            );
          });
        }
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Choose the correct answer'),
            ),
            body: Column(
              children: [
                const SizedBox(height: 100),
                if (value.mainState.questionNumber < 4)
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          _listQuestions[value.mainState.questionNumber],
                        ),
                      );
                    },
                  ),
                ),
                if (value.mainState.questionNumber < 4)
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    reverse: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        _answerOptionsWidget(
                          _listAnswerOptions[value.mainState.questionNumber][0],
                          value.mainState.selectAnswer == _listAnswerOptions[value.mainState.questionNumber][0]
                              ? true
                              : false,
                        ),
                        _answerOptionsWidget(
                          _listAnswerOptions[value.mainState.questionNumber][1],
                          value.mainState.selectAnswer == _listAnswerOptions[value.mainState.questionNumber][1]
                              ? true
                              : false,
                        ),
                        _answerOptionsWidget(
                          _listAnswerOptions[value.mainState.questionNumber][2],
                          value.mainState.selectAnswer == _listAnswerOptions[value.mainState.questionNumber][2]
                              ? true
                              : false,
                        ),
                        _answerOptionsWidget(
                          _listAnswerOptions[value.mainState.questionNumber][3],
                          value.mainState.selectAnswer == _listAnswerOptions[value.mainState.questionNumber][3]
                              ? true
                              : false,
                        ),
                      ],
                    );
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
            bottomNavigationBar: Container(
              height: 170,
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (value.mainState.nextQuestion) {
                        context.read<MainProvider>().next();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff5B75FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        'NEXT',
                        style: TextStyle(
                          color: value.mainState.nextQuestion ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff5B75FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 50,
                      width: double.infinity,
                      child: const Text(
                        'Open History Page',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        );
      },
    );
  }

  Widget _answerOptionsWidget(String selectAnswer, bool selected) {
    return InkWell(
      onTap: () {
        context.read<MainProvider>().selectAnswer(selectAnswer: selectAnswer);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 50,
        width: 50,
        color: selected ? Colors.blue : Colors.blueGrey,
        alignment: Alignment.center,
        child: Text(
          selectAnswer,
        ),
      ),
    );
  }
}
