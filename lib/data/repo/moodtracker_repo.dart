abstract class MoodTrackerRepo {
  Future getMoodTrackerService();
  Future postMoodTrackerService(
    String text,
    String mood,
    String emotion,
  );
}
