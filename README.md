# 🎧 Podcast App (Flutter)

A modern Flutter podcast application built as part of a practical interview task.  
The app demonstrates episode listing and a custom audio player with playback controls, speed selection, and a clean, responsive UI. Episodes are loaded locally for testing and playback is handled using the `just_audio` package.

---

## ✨ Features

- Podcast episode list screen
- Episode player screen with:
  - Podcast cover image
  - Episode title & duration
  - Play / Pause controls
  - Progress bar with seek support
  - Playback speed control (1x, 1.25x, 1.5x)
- Local JSON / static data for episodes
- Dark & Light mode support
- Smooth navigation & subtle animations
- Responsive UI following Flutter best practices

---

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/e83198a6-b2e0-4d66-b4d2-429ce9769b36" width="220" />
  <img src="https://github.com/user-attachments/assets/e71493f4-1010-4474-b158-696cd011941c" width="220" />
  <img src="https://github.com/user-attachments/assets/a11eda79-142e-4293-ad36-6d0fcc40f0fd" width="220" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/d4b844ce-072a-4b31-bd04-1e249a53911e" width="220" />
  <img src="https://github.com/user-attachments/assets/d7171fbf-28b0-4675-973c-d0e574fc0af9" width="220" />
  <img src="https://github.com/user-attachments/assets/a63c5871-5da3-47e7-9ddd-e82752ebc778" width="220" />
</p>

---

## 🎥 Screen Recording (App Demo)

<p align="center">
  <video src="https://github.com/user-attachments/assets/3617f897-0304-4195-80a5-0909e3c5a6ca" width="300" controls></video>
</p>

---

## 🛠️ Tech Stack & Packages

- **Flutter** – UI & navigation
- **just_audio** – Audio playback
- **audio_service** – Background playback support
- **cached_network_image** – Image caching
- **provider / riverpod** – State management
- **shared_preferences** – Local settings storage

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x or above)
- Dart SDK
- Android Studio / VS Code

### Installation

```bash
git clone https://github.com/yourusername/flutter-podcast-app.git
cd flutter-podcast-app
flutter pub get
flutter run
