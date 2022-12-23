
import 'package:http/http.dart' as http;
class NotificationUtils{
  final _api = 'https://fcm.googleapis.com/fcm/send';
  send(){
    http.post(Uri.parse(_api) ,headers: {

    });
  }
}