import '../models/learning_path.dart';

List<LearningPath> samplePaths = [
  LearningPath(
    id: "flutter",
    title: "Flutter Development",
    subtitle: "Build beautiful mobile apps",
    iconEmoji: "📱",
    students: 12000,
    duration: "8 Weeks",
    skills: 15,
    progress: 0.7,
    description:
        "Learn Flutter from beginner to advanced including UI, Firebase and API integration.",
    whatYouLearn: [
      "Flutter Basics",
      "UI Design",
      "Firebase Integration",
      "REST APIs",
      "State Management",
    ],
  ),

  LearningPath(
    id: "ai",
    title: "Artificial Intelligence",
    subtitle: "Master AI and Machine Learning",
    iconEmoji: "🤖",
    students: 9000,
    duration: "10 Weeks",
    skills: 20,
    progress: 0.4,
    description:
        "Learn Machine Learning, Deep Learning and AI applications.",
    whatYouLearn: [
      "Python",
      "Machine Learning",
      "Deep Learning",
      "Neural Networks",
      "AI Projects",
    ],
  ),

  LearningPath(
    id: "cyber_security",
    title: "Cyber Security",
    subtitle: "Become a security expert",
    iconEmoji: "🔐",
    students: 7000,
    duration: "6 Weeks",
    skills: 12,
    progress: 0.2,
    description:
        "Understand ethical hacking, network security and cyber defense.",
    whatYouLearn: [
      "Network Security",
      "Ethical Hacking",
      "Penetration Testing",
      "Cyber Defense",
      "Security Tools",
    ],
  ),

  LearningPath(
    id: "web_dev",
    title: "Web Development",
    subtitle: "Frontend and Backend Development",
    iconEmoji: "💻",
    students: 15000,
    duration: "12 Weeks",
    skills: 18,
    progress: 0.5,
    description:
        "Learn full-stack web development using modern technologies.",
    whatYouLearn: [
      "HTML",
      "CSS",
      "JavaScript",
      "React",
      "Node.js",
    ],
  ),
];