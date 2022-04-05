import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConnection {
  static EnvConnection _instance = EnvConnection._init();
  EnvConnection._init();
  static EnvConnection get instance => _instance;

  dynamic get googleMapsApiKey =>
      dotenv.env['GOOGLE_MAPS_API_KEY'].toString();
}
