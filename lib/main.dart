// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:github_star_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/repository_provider.dart';
import 'screens/repository_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RepositoryProvider()..loadCachedRepositories()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub Repositories',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
