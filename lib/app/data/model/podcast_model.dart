import 'episode_model.dart';

class Podcast {
  final String title;
  final String description;
  final String coverUrl;
  final List<Episode> episodes;

  Podcast({
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.episodes,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'cover_url': coverUrl,
      'episodes': episodes.map((e) => e.toJson()).toList(),
    };
  }
}