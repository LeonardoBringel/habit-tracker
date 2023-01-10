import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/manage_goal_page.dart';
import 'screens/my_goals_page.dart';

class RouteManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'Home':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const HomePage();
          },
        );

      case 'ManageGoal':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ManageGoalPage();
          },
        );

      case 'MyGoals':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const MyGoalsPage();
          },
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
