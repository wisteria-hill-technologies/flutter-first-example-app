import 'package:first_project/details_page.dart';
import 'package:first_project/userService.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          var users = await UserService().getUser();
          setState(() {
            futureUsers = Future.value(users);
          });
        },
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    User user = snapshot.data?[index];
                    return ListTile(
                      title: Text(user.email),
                      subtitle: Text(user.name.first),
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: () => openPage(context, user),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(color: Colors.black26);
                  },
                  itemCount: snapshot.data!.length);
            } else if (snapshot.hasError) {
              return Text('ERROR: ${snapshot.error}');
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ));
  }

  openPage(context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          user: user,
        ),
      ),
    );
  }
}
