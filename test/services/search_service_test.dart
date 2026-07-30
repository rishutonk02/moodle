import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/services/search_service.dart';

void main() {
  test('search service filters resource titles by query', () async {
    final results = await SearchService().search('fire');

    expect(results, hasLength(3));
    expect(results.map((result) => result.title),
        contains('Firebase setup evidence'));
    expect(results.map((result) => result.title),
        contains('Firestore data model'));
    expect(results.map((result) => result.title),
        contains('Firestore indexing guide'));
  });

  test('search service returns assignment results when queried', () async {
    final results = await SearchService().search('assignment');

    expect(results, hasLength(1));
    expect(results.single.type, 'Assignment');
  });
}
