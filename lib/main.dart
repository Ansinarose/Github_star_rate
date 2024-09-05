import 'package:flutter/material.dart';
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
      //  ChangeNotifierProvider(create: (_) => RepositoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub Repositories',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       // home: RepositoryListScreen(),
      ),
    );
  }
}
