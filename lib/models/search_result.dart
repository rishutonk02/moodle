class SearchResult {
  const SearchResult({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.route,
    this.arguments,
  });

  final String title;
  final String subtitle;
  final SearchResultType type;
  final String route;
  final Object? arguments;
}

enum SearchResultType { course, assignment, resource, notification }
