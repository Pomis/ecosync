import 'package:flutter/material.dart';
import 'package:junction2023/dashboard_page.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return DashboardPage(true);
                },
              ));
            },
            child: Text('Bad scenario', style: TextStyle(fontSize: 35),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return DashboardPage(false);
                },
              ));
            },
            child: Text('Good scenario', style: TextStyle(fontSize: 35)),
          )
        ]),
      ),
    );
  }
}
