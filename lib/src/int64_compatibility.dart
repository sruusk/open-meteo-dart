import 'package:fixnum/fixnum.dart';
import 'weather_api_openmeteo_sdk_generated.dart';

/// A web-compatible wrapper for Int64 values in the OpenMeteo SDK
class Int64Compatibility {
  /// Converts a native int to a fixnum Int64
  static Int64 toInt64(int value) {
    return Int64(value);
  }

  /// Converts a List<int> to a List<Int64>
  static List<Int64>? toInt64List(List<int>? values) {
    if (values == null) return null;
    return values.map((v) => Int64(v)).toList();
  }

  /// Safely reads Int64 values from a VariableWithValues object
  static List<Int64>? getValuesInt64(VariableWithValues variableWithValues) {
    final values = variableWithValues.valuesInt64;
    return toInt64List(values);
  }

  /// Convert a fixnum Int64 to a native int
  /// Note: This may lose precision on web platforms for large values
  static int toInt(Int64 value) {
    return value.toInt();
  }

  /// Safely get time from VariablesWithTime as Int64
  static Int64 getTimeAsInt64(VariablesWithTime data) {
    return Int64(data.time);
  }

  /// Safely get timeEnd from VariablesWithTime as Int64
  static Int64 getTimeEndAsInt64(VariablesWithTime data) {
    return Int64(data.timeEnd);
  }

  /// Safely get locationId from FlatBuffers as Int64
  static Int64 getLocationIdAsInt64(int locationId) {
    return Int64(locationId);
  }

  /// Create a DateTime from an Int64 timestamp (in seconds)
  static DateTime dateTimeFromInt64Seconds(Int64 timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
  }

  /// Helper method to convert Int64 list to a Map with DateTime keys
  static Map<DateTime, num> createTimeValueMap(List<int>? values, List<DateTime> timestamps) {
    if (values == null) return {};

    final result = <DateTime, num>{};
    for (int i = 0; i < values.length && i < timestamps.length; i++) {
      result[timestamps[i]] = values[i];
    }
    return result;
  }
}
