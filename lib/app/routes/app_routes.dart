part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const PODCAST_PLAYER = _Paths.PODCAST_PLAYER;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const PODCAST_PLAYER = '/podcast-player';
}
