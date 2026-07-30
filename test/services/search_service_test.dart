import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/search_result.dart';
import 'package:moodle/services/search_service.dart';

void main() {
  test('search service filters resource titles by query', () async {
    final results = await SearchService().search('fire');

    expect(results, hasLength(4));
    expect(results.map((result) => result.title),
        contains('Firebase setup evidence'));
    expect(results.map((result) => result.title),
        contains('Firestore data model'));
    expect(results.map((result) => result.title),
        contains('Firestore indexing guide'));
    expect(
        results.any((result) => result.type == SearchResultType.notification),
        isTrue);
  });

  test('search service returns assignment results when queried', () async {
    final results = await SearchService().search('coursework');

    expect(
      results.any((result) => result.type == SearchResultType.assignment),
      isTrue,
    );
  });
}
