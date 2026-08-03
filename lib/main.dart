import 'package:flutter/material.dart';
import 'screens/blogs_screen.dart';
import 'screens/news_screen.dart';
import 'screens/videos_screen.dart';
import 'screens/notifications_screen.dart';

void main() {
  runApp(const VetResourcesApp());
}

class VetResourcesApp extends StatelessWidget {
  const VetResourcesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetResources',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const RootNav(),
    );
  }
}

class RootNav extends StatefulWidget {
  const RootNav({super.key});

  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int _index = 0;

  static const _titles = ['Blogs', 'News', 'Videos', 'Notifications'];

  static const _screens = [
    BlogsScreen(),
    NewsScreen(),
    VideosScreen(),
    NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.article_outlined), label: 'Blogs'),
          NavigationDestination(icon: Icon(Icons.newspaper_outlined), label: 'News'),
          NavigationDestination(icon: Icon(Icons.ondemand_video_outlined), label: 'Videos'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined), label: 'Alerts'),
        ],
      ),
    );
  }
}
