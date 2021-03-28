class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({this.id, this.question, this.answer, this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
    "Who is your high school friend?",
    "options": ['Jungkook Jeon', 'Nitin Indukuri', 'Jin Kim', 'Bill Gates'],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question": "Who did you have a this memory with: Going to concert?",
    "options": ['Yoon-gi Min', 'Bill Gates', 'Jin Kim', 'Jungkook Jeon'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "What is your relation with Nitin Indukuri?",
    "options": ['College Friend', 'Mentor', 'Cousin', 'Older Brother'],
    "answer_index": 3,
  },
  {
    "id": 4,
    "question": "Who is your cousin?",
    "options": ['Yoon-gi Min', 'Bill Gates', 'Jin Kim', 'Nitin Indukuri'],
    "answer_index": 0,
  },
  {
    "id": 5,
    "question": "What are your memories with Bill Gates?",
    "options": ['Going to concert', 'Microsoft', 'Karaoke', 'Rooming'],
    "answer_index": 1,
  },
];