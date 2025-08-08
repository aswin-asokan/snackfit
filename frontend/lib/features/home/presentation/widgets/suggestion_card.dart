import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuggestionCard extends StatefulWidget {
  final String title;
  final String suggestion;
  final String date;

  const SuggestionCard({
    Key? key,
    required this.title,
    required this.suggestion,
    required this.date,
  }) : super(key: key);

  @override
  State<SuggestionCard> createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final dateParsed = DateTime.tryParse(widget.date);
    final formattedDate = dateParsed != null
        ? DateFormat('dd MMM yyyy').format(dateParsed)
        : widget.date;

    final showToggle = widget.suggestion.length > 100;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.suggestion,
              maxLines: isExpanded ? null : 2,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            if (showToggle)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(isExpanded ? "Show less" : "Show more"),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
