# Podcast App (Flutter)

A modern podcast player app built with Flutter, supporting audio, video episodes, rich images, and user recording features.

## Features
- Browse and play podcasts (RSS feed support)
- Audio & **Video** playback (video podcasts/videocasts)
- Dynamic episode **images** and artwork
- Dark/Light mode support
- Background playback
- **Recording**: Record audio notes or reactions directly in the app
- Offline download (coming soon)

## Screenshots


![Podcast Home Screen](https://github.com/user-attachments/assets/e83198a6-b2e0-4d66-b4d2-429ce9769b36)

![Episode List / Player View](https://github.com/user-attachments/assets/e71493f4-1010-4474-b158-696cd011941c)

![Dark Mode Home](https://github.com/user-attachments/assets/a11eda79-142e-4293-ad36-6d0fcc40f0fd)

![Player Screen](https://github.com/user-attachments/assets/d4b844ce-072a-4b31-bd04-1e249a53911e)

![Additional View 1](https://github.com/user-attachments/assets/d7171fbf-28b0-4675-973c-d0e574fc0af9)

![Additional View 2](https://github.com/user-attachments/assets/a63c5871-5da3-47e7-9ddd-e82752ebc778)

*(More screenshots can be added as the app evolves!)*

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites
- Flutter SDK (3.x or higher)
- Dart

### Installation
1. Clone the repo:  
   `git clone https://github.com/yourusername/your-podcast-app.git`
2. Install dependencies:  
   `flutter pub get`
3. Run the app:  
   `flutter run`

## Key Packages Used
- `just_audio` + `audio_service`: Audio playback & background mode
- `video_player` + `chewie`: **Video** support
- `cached_network_image`: Efficient **image** loading and caching
- `record` or `flutter_sound`: Audio **recording**
- `provider` or `riverpod`: State management
- `http` or `dio`: For fetching RSS feeds
- `shared_preferences`: Local storage (e.g., favorites, theme)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Contributing
Pull requests are welcome! Especially for:
- Web3 integrations (e.g., NFT rewards for listening)
- Enhanced monetization features
- More media support (transcripts, chapters, etc.)

Feel free to open issues for bugs or feature requests.

---

Happy coding! 🎧🚀
