import 'package:fp_util/fp_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'field.freezed.dart';

/// Field class for form handling
@Freezed(
  genericArgumentFactories: true,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
class Field<T> with _$Field<T> {
  const Field._();

  const factory Field({
    required T value,
    @Default([]) List<Validator<T>> validators,
    @Default(true) bool isPure,
    String? errorMessage,
    @Default({}) Map<String, dynamic> extra,
  }) = _Field<T>;

  /// method to mark field as dirty
  Field<T> dirty(T updatedValue) {
    return copyWith(
      value: updatedValue,
      isPure: false,
      errorMessage: _validate(updatedValue),
    );
  }

  /// method to update extra data
  /// extra data is used to store any extra data related to field
  /// for example, we can store obscureText value for password field
  Field<T> updateExtra(Map<String, dynamic> updatedExtra) {
    return copyWith(
      isPure: false,
      extra: updatedExtra,
    );
  }

  /// method to make field dirty and validate with new validator
  Field<T> withValidator(
    T updatedValue,
    Validator<T> validator,
  ) {
    final updatedValidators = [
      ...validators,
      validator,
    ];
    return copyWith(
      value: updatedValue,
      validators: updatedValidators,
      isPure: false,
      errorMessage: _validate(updatedValue, updatedValidators),
    );
  }

  /// show error message only when field is dirty
  String? get displayError => isPure ? null : errorMessage;

  /// check field is valid or not
  bool get isValid => validators.isEmpty ? true : _validate(value) == null;

  /// error message for field
  /// validate field with every validators
  String? _validate(T updatedValue, [List<Validator<T>>? optionalValidators]) {
    final updatedValidators = optionalValidators ?? validators;
    for (final validator in updatedValidators) {
      if (!validator.isValid(updatedValue)) {
        return validator.message;
      }
    }
    return null;
  }
}
