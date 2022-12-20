import 'package:http/io_client.dart';
import 'package:movie/movie.dart';

import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
