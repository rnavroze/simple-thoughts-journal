class JournalEntry {
  int id;
  String title;
  int level;
  String details;
  Set distortions;
  Map halt;
  String rationalThought;
  DateTime date;
  bool haltSolution;

  JournalEntry(
      {this.id, this.title, this.level, this.details, this.distortions, this.halt, this.rationalThought, this.date, this.haltSolution});
}
