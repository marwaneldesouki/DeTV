import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/movies_services.dart';

@override
class MySearchDelegate extends SearchDelegate {

  List<String> searchReasults =  ['Movies', 'series','sssss'];
  @override
  List<Widget>? buildActions(BuildContext context) => [
    
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
    
        child: Text(
          query,
          style: const TextStyle(fontSize: 64),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    
    List<String> suggestions = searchReasults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            });
      },
      itemCount: suggestions.length,
    );
  }
}
