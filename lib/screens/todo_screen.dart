import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_todo_screen.dart';

class todoScreen extends StatefulWidget {
  @override
  State<todoScreen> createState() => _todoScreenState();
}

class _todoScreenState extends State<todoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 4,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.to(addScreen(page: 'update',));
              },
              title: const Text('duration'),
              subtitle: const Text('2022/05/21  20:40'),
              leading: const CircleAvatar(
                radius: 30,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to( addScreen(page: 'add',));
          },
          child: const Icon(Icons.post_add_outlined),
          backgroundColor: Colors.blue),
    );
  }
}
