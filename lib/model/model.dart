// class ModelMessage {
//   final bool isPrompt;
//   final String message;
//   final DateTime time;
//
//   ModelMessage({
//     required this.isPrompt,
//     required this.message,
//     required this.time,
//   });
// }
class GenerativeModel {
  final String model;
  final String apiKey;

  GenerativeModel({required this.model, required this.apiKey});
  Future<ModelResponse> generateContent(List<Content> content) async {
    // Simulated API call, replace with actual implementation.
    await Future.delayed(const Duration(seconds: 2));
    return ModelResponse(
        text: "Generated response for '${content.first.text}'");
  }
}

class ModelMessage {
  final bool isPrompt;
  final String message;
  final DateTime time;

  ModelMessage(
      {required this.isPrompt, required this.message, required this.time});
}

class Content {
  final String text;

  Content.text(this.text);
}

class ModelResponse {
  final String? text;

  ModelResponse({this.text});
}
