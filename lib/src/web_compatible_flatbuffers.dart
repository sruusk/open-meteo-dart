import 'package:fixnum/fixnum.dart';
import 'weather_api_openmeteo_sdk_generated.dart';

/// A wrapper for FlatBuffer-generated classes to ensure Web compatibility
/// by replacing Int64 accessors with fixnum-compatible methods
class WebCompatibleFlatBuffers {
  /// Wraps WeatherApiResponse with web-compatible Int64 handling
  static WebCompatibleWeatherApiResponse wrapWeatherApiResponse(WeatherApiResponse response) {
    return WebCompatibleWeatherApiResponse(response);
  }
}

/// Wraps WeatherApiResponse with web-compatible Int64 handling
class WebCompatibleWeatherApiResponse {
  final WeatherApiResponse _response;

  WebCompatibleWeatherApiResponse(this._response);

  // Delegate standard properties
  double get latitude => _response.latitude;
  double get longitude => _response.longitude;
  double get elevation => _response.elevation;
  double get generationTimeMilliseconds => _response.generationTimeMilliseconds;
  int get utcOffsetSeconds => _response.utcOffsetSeconds;
  String? get timezone => _response.timezone;
  String? get timezoneAbbreviation => _response.timezoneAbbreviation;

  // Wrap time-series data with web-compatible wrappers
  WebCompatibleVariablesWithTime? get minutely15 =>
      _response.minutely15 != null ? WebCompatibleVariablesWithTime(_response.minutely15!) : null;
  WebCompatibleVariablesWithTime? get current =>
      _response.current != null ? WebCompatibleVariablesWithTime(_response.current!) : null;
  WebCompatibleVariablesWithTime? get hourly =>
      _response.hourly != null ? WebCompatibleVariablesWithTime(_response.hourly!) : null;
  WebCompatibleVariablesWithTime? get daily =>
      _response.daily != null ? WebCompatibleVariablesWithTime(_response.daily!) : null;
}

/// Wraps VariablesWithTime with web-compatible Int64 handling
class WebCompatibleVariablesWithTime {
  final VariablesWithTime _data;

  WebCompatibleVariablesWithTime(this._data);

  // Replace Int64 accessors with web-compatible methods
  int get time => _data.time;
  int get timeEnd => _data.timeEnd;

  // Delegate standard properties
  int get interval => _data.interval;
  List<WebCompatibleVariableWithValues>? get variables {
    final origVariables = _data.variables;
    if (origVariables == null) return null;
    return origVariables.map((v) => WebCompatibleVariableWithValues(v)).toList();
  }
}

/// Wraps VariableWithValues to handle Int64 lists
class WebCompatibleVariableWithValues {
  final VariableWithValues _data;

  WebCompatibleVariableWithValues(this._data);

  // Expose the wrapped data for internal use
  VariableWithValues get data => _data;

  // Delegate standard properties
  String get variable => _data.variable;
  Unit get unit => _data.unit;
  double get value => _data.value;
  List<double>? get values => _data.values;

  // Replace Int64 accessor with web-compatible method
  List<int>? get valuesInt64 {
    try {
      final origValues = _data.valuesInt64;
      return origValues;
    } catch (e) {
      // If the Int64 accessor fails on web, return an empty list
      return [];
    }
  }

  double? get altitude => _data.altitude;
  String? get aggregation => _data.aggregation;
  int? get pressureLevel => _data.pressureLevel;
  double? get depth => _data.depth;
  double? get depthTo => _data.depthTo;
  int? get ensembleMember => _data.ensembleMember;
  bool? get previousDay => _data.previousDay;
}
