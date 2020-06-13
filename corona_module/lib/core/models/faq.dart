import 'package:meta/meta.dart';

class Faq {
  final String id;
  final String category;
  final String question;
  final String answer;

  Faq({
    @required this.id,
    @required this.category,
    @required this.question,
    @required this.answer,
  });

  Faq copyWith({
    String id,
    String category,
    String question,
    String answer,
  }) {
    return Faq(
      id: id ?? this.id,
      category: category ?? this.category,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  static Faq fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Faq(
      id: map['_id'],
      category: map['category'],
      question: map['question'],
      answer: map['answer'],
    );
  }

  @override
  String toString() {
    return 'Faq(id: $id, category: $category, question: $question, answer: $answer)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Faq &&
        o.id == id &&
        o.category == category &&
        o.question == question &&
        o.answer == answer;
  }

  @override
  int get hashCode {
    return id.hashCode ^ category.hashCode ^ question.hashCode ^ answer.hashCode;
  }
}
