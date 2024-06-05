import 'package:first_project/userService.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final User user;
  const DetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          '${user.name.first} ${user.name.last}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.network(
              user.picture,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(user.email),
          ],
        ),
      ),
    );
  }
}
