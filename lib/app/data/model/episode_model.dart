class Episode {
  final String title;
  final String subtitle;
  final String date;
  final String duration;
  final String audioUrl;

  Episode({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.duration,
    required this.audioUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      date: json['date'] ?? '',
      duration: json['duration'] ?? '',
      audioUrl: json['audio_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'duration': duration,
      'audio_url': audioUrl,
    };
  }
}