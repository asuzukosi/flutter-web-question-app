// This clas will help us in managing yes/no response data in our app

class Answer {
  // The answer text
  final String answer;

  // Gif url
  final String image;

  Answer(this.answer, this.image);

  static Answer fromMap(Map<String, dynamic> map) {
    return Answer(map["answer"], map["image"]);
  }
}
