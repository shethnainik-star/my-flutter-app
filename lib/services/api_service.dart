import 'dart:convert';
import 'package:http/http.dart' as http;

/// Central place to point the app at your backend.
/// Swap these once your Laravel API has a real domain.
class ApiConfig {
  // Your Laravel API gateway (single gateway pattern discussed earlier).
  static const String laravelBaseUrl = 'https://yourapi.com/api/v1';

  // Direct WordPress REST API — used only until Laravel's blog-mirror
  // endpoint exists. Once Laravel caches WordPress content, point
  // getBlogs() at laravelBaseUrl instead.
  static const String wordpressBaseUrl = 'https://vetresources.com.au/wp-json/wp/v2';
}

class ApiService {
  /// Fetch blog posts. Tries WordPress directly for now.
  static Future<List<Map<String, dynamic>>> getBlogs({int page = 1}) async {
    final uri = Uri.parse('${ApiConfig.wordpressBaseUrl}/posts?page=$page&per_page=10&_embed');
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {
      // fall through to demo data below
    }
    return _demoBlogs;
  }

  static Future<List<Map<String, dynamic>>> getNews() async {
    final uri = Uri.parse('${ApiConfig.laravelBaseUrl}/news');
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final List data = body is List ? body : (body['data'] ?? []);
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return _demoNews;
  }

  static Future<List<Map<String, dynamic>>> getVideos() async {
    final uri = Uri.parse('${ApiConfig.laravelBaseUrl}/videos');
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final List data = body is List ? body : (body['data'] ?? []);
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return _demoVideos;
  }

  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final uri = Uri.parse('${ApiConfig.laravelBaseUrl}/notifications');
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final List data = body is List ? body : (body['data'] ?? []);
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}
    return _demoNotifications;
  }
}

// ---- Demo/fallback data so the app is testable before the backend is live ----

final _demoBlogs = [
  {
    'id': 1,
    'title': {'rendered': 'Welcome to VetResources'},
    'excerpt': {'rendered': 'This is demo content shown while the live API is not yet connected.'},
  },
];

final _demoNews = [
  {'id': 1, 'title': 'Sample news item', 'summary': 'Demo data — replace once Laravel /news is live.'},
];

final _demoVideos = [
  {'id': 1, 'title': 'Sample video', 'thumbnail_url': null},
];

final _demoNotifications = [
  {'id': 1, 'title': 'Welcome', 'body': 'This is a demo notification.'},
];
