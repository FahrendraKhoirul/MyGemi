class GeminiProVision {
  List<CandidatesVision>? candidates;
  PromptFeedback? promptFeedback;

  GeminiProVision({this.candidates, this.promptFeedback});

  GeminiProVision.fromJson(Map<String, dynamic> json) {
    if (json['candidates'] != null) {
      candidates = <CandidatesVision>[];
      json['candidates'].forEach((v) {
        candidates!.add(CandidatesVision.fromJson(v));
      });
    }
    promptFeedback = json['promptFeedback'] != null
        ? PromptFeedback.fromJson(json['promptFeedback'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (candidates != null) {
      data['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    if (promptFeedback != null) {
      data['promptFeedback'] = promptFeedback!.toJson();
    }
    return data;
  }
}

class CandidatesVision {
  ContentVision? content;
  String? finishReason;
  int? index;
  List<SafetyRatings>? safetyRatings;

  CandidatesVision({this.content, this.finishReason, this.index, this.safetyRatings});

  CandidatesVision.fromJson(Map<String, dynamic> json) {
    content =
        json['content'] != null ? ContentVision.fromJson(json['content']) : null;
    finishReason = json['finishReason'];
    index = json['index'];
    if (json['safetyRatings'] != null) {
      safetyRatings = <SafetyRatings>[];
      json['safetyRatings'].forEach((v) {
        safetyRatings!.add(SafetyRatings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['finishReason'] = finishReason;
    data['index'] = index;
    if (safetyRatings != null) {
      data['safetyRatings'] = safetyRatings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentVision {
  List<PartsVision>? parts;
  String? role;

  ContentVision({this.parts, this.role});

  ContentVision.fromJson(Map<String, dynamic> json) {
    if (json['parts'] != null) {
      parts = <PartsVision>[];
      json['parts'].forEach((v) {
        parts!.add(PartsVision.fromJson(v));
      });
    }
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parts != null) {
      data['parts'] = parts!.map((v) => v.toJson()).toList();
    }
    data['role'] = role;
    return data;
  }
}

class PartsVision {
  String? text;

  PartsVision({this.text});

  PartsVision.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class SafetyRatings {
  String? category;
  String? probability;

  SafetyRatings({this.category, this.probability});

  SafetyRatings.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['probability'] = probability;
    return data;
  }
}

class PromptFeedback {
  List<SafetyRatings>? safetyRatings;

  PromptFeedback({this.safetyRatings});

  PromptFeedback.fromJson(Map<String, dynamic> json) {
    if (json['safetyRatings'] != null) {
      safetyRatings = <SafetyRatings>[];
      json['safetyRatings'].forEach((v) {
        safetyRatings!.add(SafetyRatings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (safetyRatings != null) {
      data['safetyRatings'] = safetyRatings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
