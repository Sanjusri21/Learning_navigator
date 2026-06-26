class LearningPath {
  final String id; // IMPORTANT for roadmap mapping
  final String title;
  final String subtitle;
  final String iconEmoji;
  final int students;
  final String duration;
  final int skills;
  final double progress;

  final String description;
  final List<String> whatYouLearn;

  LearningPath({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconEmoji,
    required this.students,
    required this.duration,
    required this.skills,
    required this.progress,
    required this.description,
    required this.whatYouLearn,
  });
}