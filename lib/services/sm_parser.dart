class SmParser {
  static String youTubeThumbnailUrl(String id) =>
      'https://img.youtube.com/vi/$id/hqdefault.jpg';

  static String getYoutubeThumbnailUrl(String url) {
    if (url.contains('youtu.be')) {
      return youTubeThumbnailUrl(
          url.substring(url.lastIndexOf('youtu.be/') + 9));
    }
    return youTubeThumbnailUrl(url.substring(url.lastIndexOf('watch?v=') + 8));
  }
}
