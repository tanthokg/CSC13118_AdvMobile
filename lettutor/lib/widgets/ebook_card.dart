import 'package:flutter/material.dart';
import 'package:lettutor/entities/ebook.dart';

class EbookCard extends StatelessWidget {
  const EbookCard({Key? key, required this.ebook}) : super(key: key);

  final EBook ebook;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Image.asset(ebook.imageUrl),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ebook.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  ebook.description,
                  style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  ebook.level,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
