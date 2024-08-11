import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/main_provider.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.listQuestions});

  final List<String> listQuestions;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  int _correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        if (value.mainState.questionNumber == 4) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<MainProvider>().changeQuestionNumber();
            context.read<MainProvider>().createResultDB('${ _correctAnswers++}/4');
          });
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Result'),
          ),
          body: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.listQuestions.length,
                  itemBuilder: (context, index) {
                    String item = widget.listQuestions[index];
                    return Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        item,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.mainState.listAnswer.length,
                  itemBuilder: (context, index) {
                    String item = value.mainState.listAnswer[index];
                    bool isTrue = false;
                    switch (item) {
                      case '4':
                        isTrue = true;
                        _correctAnswers++;
                        break;
                      case '0':
                        isTrue = true;
                        _correctAnswers++;
                        break;
                      case '6':
                        isTrue = true;
                        _correctAnswers++;
                        break;
                      case '9':
                        isTrue = true;
                        _correctAnswers++;
                        break;
                    }
                    return Row(
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            item,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _iconWidget(isTrue),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _iconWidget(bool isTrue) {
    return Icon(
      isTrue
        ? Icons.check
        : Icons.close,
      size: 25.0,
    );
  }
}
