import 'package:tv/data/models/tv/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvTable = TvTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTvTableJson = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should be json form TvTable', () async {
    final result = tTvTable.toJson();
    expect(result, tTvTableJson);
  });
}
