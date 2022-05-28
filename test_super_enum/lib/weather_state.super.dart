// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'weather_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState(this._type);

  factory WeatherState.initial() = Initial.create;

  factory WeatherState.loading() = Loading.create;

  factory WeatherState.loaded({required Weather weather}) = Loaded.create;

  factory WeatherState.error({required String message}) = Error.create;

  final _WeatherState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _WeatherState [_type]s defined.
  R when<R extends Object>(
      {required R Function() initial,
      required R Function() loading,
      required R Function(Loaded) loaded,
      required R Function(Error) error}) {
    assert(() {
      if (initial == null ||
          loading == null ||
          loaded == null ||
          error == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _WeatherState.Initial:
        return initial();
      case _WeatherState.Loading:
        return loading();
      case _WeatherState.Loaded:
        return loaded(this as Loaded);
      case _WeatherState.Error:
        return error(this as Error);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function()? initial,
      R Function()? loading,
      R Function(Loaded)? loaded,
      R Function(Error)? error,
      required R Function(WeatherState) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _WeatherState.Initial:
        if (initial == null) break;
        return initial();
      case _WeatherState.Loading:
        if (loading == null) break;
        return loading();
      case _WeatherState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _WeatherState.Error:
        if (error == null) break;
        return error(this as Error);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function()? initial,
      void Function()? loading,
      void Function(Loaded)? loaded,
      void Function(Error)? error}) {
    assert(() {
      if (initial == null &&
          loading == null &&
          loaded == null &&
          error == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _WeatherState.Initial:
        if (initial == null) break;
        return initial();
      case _WeatherState.Loading:
        if (loading == null) break;
        return loading();
      case _WeatherState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _WeatherState.Error:
        if (error == null) break;
        return error(this as Error);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class Initial extends WeatherState {
  const Initial() : super(_WeatherState.Initial);

  factory Initial.create() = _InitialImpl;
}

@immutable
class _InitialImpl extends Initial {
  const _InitialImpl() : super();

  @override
  String toString() => 'Initial()';
}

@immutable
abstract class Loading extends WeatherState {
  const Loading() : super(_WeatherState.Loading);

  factory Loading.create() = _LoadingImpl;
}

@immutable
class _LoadingImpl extends Loading {
  const _LoadingImpl() : super();

  @override
  String toString() => 'Loading()';
}

@immutable
abstract class Loaded extends WeatherState {
  const Loaded({required this.weather}) : super(_WeatherState.Loaded);

  factory Loaded.create({required Weather weather}) = _LoadedImpl;

  final Weather weather;

  /// Creates a copy of this Loaded but with the given fields
  /// replaced with the new values.
  Loaded copyWith({Weather weather});
}

@immutable
class _LoadedImpl extends Loaded {
  const _LoadedImpl({required this.weather}) : super(weather: weather);

  @override
  final Weather weather;

  @override
  _LoadedImpl copyWith({Object weather = superEnum}) => _LoadedImpl(
        weather: weather == superEnum ? this.weather : weather as Weather,
      );
  @override
  String toString() => 'Loaded(weather: ${this.weather})';
  @override
  List<Object> get props => [weather];
}

@immutable
abstract class Error extends WeatherState {
  const Error({required this.message}) : super(_WeatherState.Error);

  factory Error.create({required String message}) = _ErrorImpl;

  final String message;

  /// Creates a copy of this Error but with the given fields
  /// replaced with the new values.
  Error copyWith({String message});
}

@immutable
class _ErrorImpl extends Error {
  const _ErrorImpl({required this.message}) : super(message: message);

  @override
  final String message;

  @override
  _ErrorImpl copyWith({Object message = superEnum}) => _ErrorImpl(
        message: message == superEnum ? this.message : message as String,
      );
  @override
  String toString() => 'Error(message: ${this.message})';
  @override
  List<Object> get props => [message];
}
