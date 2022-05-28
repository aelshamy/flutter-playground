import 'package:super_enum/super_enum.dart';

part "weather_state.super.dart";

@superEnum
enum _WeatherState {
  @object
  Initial,
  @object
  Loading,
  @Data(fields: [DataField<Weather>('weather')])
  Loaded,
  @Data(fields: [DataField<String>('message')])
  Error,
}

class Weather {
  @override
  String toString() {
    return 'Weather data just loaded';
  }
}
