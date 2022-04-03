

import 'package:intl/intl.dart' as intl;
import 'messages.dart';

/// The translations for English (`en`).
class ReadyValidationMessagesEn extends ReadyValidationMessages {
  ReadyValidationMessagesEn([String locale = 'en']) : super(locale);

  @override
  String contains(String value, String res) {
    return 'The text should contain $res';
  }

  @override
  String containsItem(dynamic value, dynamic res) {
    return 'The list should contain $res';
  }

  @override
  String endsWith(String value, String res) {
    return 'Text should end with $res';
  }

  @override
  String equal(dynamic value) {
    return 'Only the value $value is allowed.';
  }

  @override
  String greaterThan(bool equal, num value, num min) {
    final String selectString = intl.Intl.select(
      equal,
      {
        'true': 'or equal to',
        'other': ''
      },
      desc: 'No description provided in @greaterThan'
    );

    return 'The value should be greater than, ${selectString}';
  }

  @override
  String hasMaxLength(String value, int max) {
    return 'The text must be no longer than $max';
  }

  @override
  String hasMinLength(String value, int min) {
    return 'The length of the text must be at least $min';
  }

  @override
  String hasRange(String value, int min, int max) {
    return 'You must enter a text of length not less than $min and not more than $max';
  }

  @override
  String isAfter(bool equal, DateTime value, DateTime date) {
    final String selectString = intl.Intl.select(
      equal,
      {
        'true': 'or equal to'
      },
      desc: 'No description provided in @isAfter'
    );

    return 'You must enter a later date ${selectString}';
  }

  @override
  String isBefore(bool equal, DateTime value, DateTime date) {
    final String selectString = intl.Intl.select(
      equal,
      {
        'true': 'or equal to'
      },
      desc: 'No description provided in @isBefore'
    );

    return 'You must enter a date prior ${selectString}';
  }

  @override
  String isBetween(bool equal, num value, num min, num max) {
    final String selectString = intl.Intl.select(
      equal,
      {
        'true': 'or equal'
      },
      desc: 'No description provided in @isBetween'
    );

    return 'Value must be greater ${selectString}';
  }

  @override
  String isDateBetween(bool equal, DateTime value, DateTime min, DateTime max) {
    final String selectString = intl.Intl.select(
      equal,
      {
        'true': 'or equal to one'
      },
      desc: 'No description provided in @isDateBetween'
    );

    return 'You must enter a date ${selectString}';
  }

  @override
  String isDateTime(Object value) {
    return 'You must enter a valid date';
  }

  @override
  String isDecimal(Object value) {
    return 'You must enter a decimal number';
  }

  @override
  String isDivisibleBy(num value, num division) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);
    final intl.NumberFormat divisionNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String divisionString = divisionNumberFormat.format(division);

    return 'The input value must be divisible by $divisionString';
  }

  @override
  String isEven(num value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'The value must be an even number';
  }

  @override
  String isIn(dynamic value, List list) {
    return 'The entered value must be one of the $list';
  }

  @override
  String isInteger(Object value) {
    return 'You must enter a valid number';
  }

  @override
  String isNegative(num value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'Value must be negative';
  }

  @override
  String isNotIn(dynamic value, List list) {
    return 'The entered value must not be in $list';
  }

  @override
  String isNumber(Object value) {
    return 'You must enter a valid number';
  }

  @override
  String isOdd(num value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'The value must be an odd number';
  }

  @override
  String isPositive(num value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'The value should be positive';
  }

  @override
  String isTimeOfDay(Object value) {
    return 'You must enter a valid time';
  }

  @override
  String lessThan(bool equal, num value, num max) {
    final String selectString = intl.Intl.select(
      equal,
      {
        'true': 'or equal to',
        'other': ''
      },
      desc: 'No description provided in @lessThan'
    );

    return 'Value must be less than, ${selectString}';
  }

  @override
  String listMaxLength(String value, int max) {
    return 'The number of items should not be more than $max';
  }

  @override
  String listMinLength(String value, int min) {
    return 'The number of items should not be less than $min';
  }

  @override
  String listRange(String value, int min, int max) {
    return 'The number of items must be at least ${min}and no more than $max';
  }

  @override
  String notContainsItem(dynamic value, dynamic res) {
    return 'The list does not have to contain $res';
  }

  @override
  String get notEmpty => 'You should not enter an empty value';

  @override
  String notEqual(dynamic value) {
    return 'Not allowed to enter $value';
  }

  @override
  String get regexp => 'The requested format is not compatible with the input';

  @override
  String get required => 'Excuse me! This field is required';

  @override
  String startsWith(String value, String res) {
    return 'Text should start with $res';
  }
}
