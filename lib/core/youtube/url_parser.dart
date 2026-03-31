/// Parses a YouTube URL and extracts the video ID.
///
/// Supports:
/// - https://www.youtube.com/watch?v=VIDEO_ID
/// - https://youtu.be/VIDEO_ID
/// - https://www.youtube.com/live/VIDEO_ID
/// - https://youtube.com/watch?v=VIDEO_ID&...
String? extractVideoId(String url) {
  final uri = Uri.tryParse(url.trim());
  if (uri == null) return null;

  // youtu.be/VIDEO_ID
  if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
    return uri.pathSegments.first;
  }

  // youtube.com/watch?v=VIDEO_ID
  if ((uri.host.contains('youtube.com') || uri.host.contains('youtube-nocookie.com'))) {
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }
    // youtube.com/live/VIDEO_ID
    if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'live') {
      return uri.pathSegments[1];
    }
  }

  return null;
}
