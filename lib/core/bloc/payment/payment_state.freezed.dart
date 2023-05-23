// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaymentState {
  bool get isPaying => throw _privateConstructorUsedError;
  bool get isPayed => throw _privateConstructorUsedError;
  bool get isErrorOccurred => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaymentStateCopyWith<PaymentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
          PaymentState value, $Res Function(PaymentState) then) =
      _$PaymentStateCopyWithImpl<$Res, PaymentState>;
  @useResult
  $Res call(
      {bool isPaying, bool isPayed, bool isErrorOccurred, String message});
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res, $Val extends PaymentState>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPaying = null,
    Object? isPayed = null,
    Object? isErrorOccurred = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      isPaying: null == isPaying
          ? _value.isPaying
          : isPaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPayed: null == isPayed
          ? _value.isPayed
          : isPayed // ignore: cast_nullable_to_non_nullable
              as bool,
      isErrorOccurred: null == isErrorOccurred
          ? _value.isErrorOccurred
          : isErrorOccurred // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IntialCopyWith<$Res> implements $PaymentStateCopyWith<$Res> {
  factory _$$_IntialCopyWith(_$_Intial value, $Res Function(_$_Intial) then) =
      __$$_IntialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPaying, bool isPayed, bool isErrorOccurred, String message});
}

/// @nodoc
class __$$_IntialCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$_Intial>
    implements _$$_IntialCopyWith<$Res> {
  __$$_IntialCopyWithImpl(_$_Intial _value, $Res Function(_$_Intial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPaying = null,
    Object? isPayed = null,
    Object? isErrorOccurred = null,
    Object? message = null,
  }) {
    return _then(_$_Intial(
      isPaying: null == isPaying
          ? _value.isPaying
          : isPaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isPayed: null == isPayed
          ? _value.isPayed
          : isPayed // ignore: cast_nullable_to_non_nullable
              as bool,
      isErrorOccurred: null == isErrorOccurred
          ? _value.isErrorOccurred
          : isErrorOccurred // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Intial implements _Intial {
  const _$_Intial(
      {this.isPaying = false,
      this.isPayed = false,
      this.isErrorOccurred = false,
      this.message = ''});

  @override
  @JsonKey()
  final bool isPaying;
  @override
  @JsonKey()
  final bool isPayed;
  @override
  @JsonKey()
  final bool isErrorOccurred;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'PaymentState(isPaying: $isPaying, isPayed: $isPayed, isErrorOccurred: $isErrorOccurred, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Intial &&
            (identical(other.isPaying, isPaying) ||
                other.isPaying == isPaying) &&
            (identical(other.isPayed, isPayed) || other.isPayed == isPayed) &&
            (identical(other.isErrorOccurred, isErrorOccurred) ||
                other.isErrorOccurred == isErrorOccurred) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isPaying, isPayed, isErrorOccurred, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IntialCopyWith<_$_Intial> get copyWith =>
      __$$_IntialCopyWithImpl<_$_Intial>(this, _$identity);
}

abstract class _Intial implements PaymentState {
  const factory _Intial(
      {final bool isPaying,
      final bool isPayed,
      final bool isErrorOccurred,
      final String message}) = _$_Intial;

  @override
  bool get isPaying;
  @override
  bool get isPayed;
  @override
  bool get isErrorOccurred;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_IntialCopyWith<_$_Intial> get copyWith =>
      throw _privateConstructorUsedError;
}
