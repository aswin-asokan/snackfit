class SuggestionModel {
  int? id;
  final String title;
  final String suggestion;
  final String date;

  SuggestionModel({
    this.id,
    required this.title,
    required this.suggestion,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'suggestion': suggestion, 'date': date};
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> json) {
    return SuggestionModel(
      id: json['id'],
      title: json['title'],
      suggestion: json['suggestion'],
      date: json['date'],
    );
  }
}
