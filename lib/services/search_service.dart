class SearchService {
  Future<List<SearchResult>> search(String query) async {
    final lower = query.toLowerCase();
    final results = <SearchResult>[
      const SearchResult(title: 'Firebase setup evidence', type: 'Resource'),
      const SearchResult(title: 'Firestore data model', type: 'Resource'),
      const SearchResult(title: 'Firestore indexing guide', type: 'Resource'),
      const SearchResult(title: 'Assignment brief', type: 'Assignment'),
    ];

    return results
        .where((result) => result.title.toLowerCase().contains(lower))
        .toList();
  }
}

class SearchResult {
  const SearchResult({required this.title, required this.type});

  final String title;
  final String type;
}
