import 'package:flutter/material.dart';
import 'package:quiz/model/result_model.dart';
import 'package:quiz/result_db/result_db.dart';
import 'package:quiz/shared_preference.dart';

class MainProvider extends ChangeNotifier {
  MainProvider({
    required this.resultDB,
    required this.sharedPreference,
  });

  final ResultDB resultDB;
  final SharedPreference sharedPreference;

  MainState mainState = MainState();

  Future<void> next() async {
    if (mainState.listAnswer.length > 3) {
      mainState.listAnswer.clear();
    }

    mainState.nextQuestion = false;
    mainState.questionNumber = mainState.questionNumber + 1;
    mainState.listAnswer.add(mainState.selectAnswer);
    notifyListeners();
  }

  Future<void> selectAnswer({required String selectAnswer}) async {
    mainState.nextQuestion = true;
    mainState.selectAnswer = selectAnswer;
    notifyListeners();
  }

  void changeQuestionNumber() {
    mainState.questionNumber = 0;
    notifyListeners();
  }

  Future<void> createResultDB(String correctAnswers) async {
    int id = await sharedPreference.getIntPreferenceValue(SharedPreference.id);
    if (id == 0) {
      id = 1;
    } else {
      id++;
    }
    ResultModel resultModel = ResultModel(
      id: id,
      result: '$id poll',
      correctAnswers: correctAnswers,
    );

    resultDB.createResultDB(resultModel);
    await sharedPreference.setIntPreferenceValue(SharedPreference.id, id);
  }

  Future<void> getResultDB() async {
    mainState.resultDB = await resultDB.getResultDB();
    notifyListeners();
  }
}

class MainState {
  bool nextQuestion = false;
  int questionNumber = 0;
  String selectAnswer = '';
  final List<String> listAnswer = [];
  List<ResultModel>? resultDB;
}
