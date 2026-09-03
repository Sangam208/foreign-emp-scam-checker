import 'package:flutter_dotenv/flutter_dotenv.dart';

String host = dotenv.env['HOST'] ?? '';

String googleServerClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '';
