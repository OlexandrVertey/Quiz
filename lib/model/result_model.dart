import 'dart:convert';

class ResultModel {
  final int? id;
  final String result;
  final String correctAnswers;

  ResultModel({
    required this.id,
    required this.result,
    required this.correctAnswers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'result': result,
      'correctAnswers': correctAnswers,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      id: map['id']?.toInt() ?? 0,
      result: map['result'] ?? '',
      correctAnswers: map['correctAnswers'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) => ResultModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResultDB(id: $id, result: $result, correctAnswers: $correctAnswers)';
  }
}
