import 'package:flutter/material.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/services/task_dao.dart';
import 'package:todo_app/widgets/task_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  List<Task> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onEditingComplete: () async {
                final data = await TaskDAO.instance.readAllTasks();
                setState(() {
                  result = data
                      .where((task) => task.name.contains(_searchController.text))
                      .toList();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black45,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            result.isEmpty && _searchController.text != ''
                ? const Text('No item match')
                : const SizedBox.shrink(),
            _searchController.text == ''
                ? const SizedBox.shrink()
                : Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) => TaskCard(
                        task: result[index],
                        onCompleteChecked: (value) async {
                          await TaskDAO.instance.deleteTaskById(result[index].id!);
                          setState(() {
                            result.removeAt(index);
                          });
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
