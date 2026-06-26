import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {

  final model = GenerativeModel(

    model: 'gemini-pro',

    apiKey:
        "YOUR_GEMINI_API_KEY",
  );

  Future<String> generateRoadmap(
      String skill) async {

    final prompt = """

Create a complete roadmap for learning $skill.

Include:

1. Beginner topics
2. Intermediate topics
3. Advanced projects
4. Best resources

Format clearly.

""";

    final response =
        await model.generateContent(

      [Content.text(prompt)],
    );

    return response.text ??
        "No roadmap generated";
  }
}