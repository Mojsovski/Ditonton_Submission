// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/watchlist_tv_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv/tv.dart' as _i7;
import 'package:tv/domain/entities/tv/tv_detail.dart' as _i10;
import 'package:tv/domain/repositories/tv_repository.dart' as _i3;
import 'package:tv/domain/usecases/tv/get_watchlist_tvs.dart' as _i4;
import 'package:tv/domain/usecases/tv/get_watchlist_tvs_status.dart' as _i8;
import 'package:tv/domain/usecases/tv/remove_watchlist_tvs.dart' as _i11;
import 'package:tv/domain/usecases/tv/save_watchlist_tvs.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvRepository_1 extends _i1.SmartFake implements _i3.TvRepository {
  _FakeTvRepository_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [GetWatchlistTvs].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvs extends _i1.Mock implements _i4.GetWatchlistTvs {
  MockGetWatchlistTvs() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: _i5.Future<_i2.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_0<_i6.Failure, List<_i7.Tv>>(
                  this, Invocation.method(#execute, [])))) as _i5
          .Future<_i2.Either<_i6.Failure, List<_i7.Tv>>>);
}

/// A class which mocks [GetWatchListTvStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvStatus extends _i1.Mock
    implements _i8.GetWatchListTvStatus {
  MockGetWatchListTvStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue:
                  _FakeTvRepository_1(this, Invocation.getter(#repository)))
          as _i3.TvRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: _i5.Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTv extends _i1.Mock implements _i9.SaveWatchlistTv {
  MockSaveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue:
                  _FakeTvRepository_1(this, Invocation.getter(#repository)))
          as _i3.TvRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(_i10.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>(
                      this, Invocation.method(#execute, [tv]))))
          as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTv extends _i1.Mock implements _i11.RemoveWatchlistTv {
  MockRemoveWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue:
                  _FakeTvRepository_1(this, Invocation.getter(#repository)))
          as _i3.TvRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(_i10.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>(
                      this, Invocation.method(#execute, [tv]))))
          as _i5.Future<_i2.Either<_i6.Failure, String>>);
}
