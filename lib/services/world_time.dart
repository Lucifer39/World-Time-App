import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location=''; //location name for the UI
  String time=''; //time in that location
  String flag=''; //url for an asset flag
  String url=''; //location for api endpoint
  bool isDayTime=true; //indicates whether its day or night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data

      String dateTime = data['datetime'];
      String offset_hrs = data['utc_offset'].substring(1,3);
      String offset_min = data['utc_offset'].substring(4);

      // print(dateTime);
      // print(offset_min);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset_hrs), minutes: int.parse(offset_min) ));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch(e){
      print('Caught error: $e');
      time = 'could not get time data';
    }


  }



}