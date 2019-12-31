import 'package:super_enum/super_enum.dart';

part "weather_state.g.dart";

@superEnum
enum _WeatherState {
  @object
  Intial,
  @object
  Loading,
  @Data(fields: [DataField('weather', Weather)])
  Loaded,
  @Data(fields: [DataField('message', String)])
  Error,
}

class Weather {
  @override
  String toString() {
    return 'Weather data just loaded';
  }
}
