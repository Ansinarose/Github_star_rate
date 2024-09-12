import 'dart:async';
import 'package:flutter/material.dart';
import 'package:github_star_app/common/constants/color_constant.dart';
import 'package:github_star_app/screens/repository_list_screen.dart';
import 'package:github_star_app/models/repository_model.dart'; // Assume you have this

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds, then navigate to RepositoryListScreen
    Timer(Duration(seconds: 3), () {
      // Example data passed, you'll likely fetch this data elsewhere
      List<Repository> repositories = []; // Replace with actual data fetching
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RepositoryListScreen(
            //repositories: repositories
            ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo here or app icon
           
            //Icon(Icons.code, size: 100, color: Colors.blue),
            SizedBox(height: 20),
                    Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/th (75).jpeg'),
                fit: BoxFit.cover)
              ),
            ),
            Text(
              'GitHub Stars',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
            ), // Progress Indicator to show something is happening
          ],
        ),
      ),
    );
  }
}
