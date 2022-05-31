import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      title: 'Weather App',
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async{
    http.Response response= await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Ranchi&units=metric&appid=9a184e1d6661830da9926697073c4f36')); //this is where our url will be our API key..
    var result = jsonDecode(response.body);
    setState(() {
      //as the data is stored in the api code..we have to take like that only..
      //like in ['main'] their is ['temp'] where temperature data is stored...
      temp= result['main']['temp']; 
      description= result['weather'][0]['description']; 
      currently= result['weather'][0]['main'];//getting values for those particular data and storing..
      humidity= result['main']['humidity'];
      windSpeed= result['wind']['speed'];

    });
  }

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3, //take height and width of the SCREEN...
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // ye Poore RED container k text ko center mai krega....
              crossAxisAlignment: CrossAxisAlignment.center,//ye Poore RED container k text ko center mai krega....
              children: [
                const Padding (
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Currently in Ranchi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900,
                    )
                  ),
                ),

                Text(
                  temp != null ? temp.toString()+ "\u00B0" : "Loading", //Degree Symbol...
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children:[
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.temperatureHalf),
                    title: const Text('Temperature'),
                    trailing: Text(temp != null ? temp.toString()+ "\u00B0" : 'Loading'),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.cloud),
                    title: const Text('Weather'),
                    trailing: Text(description != null ? description.toString() : 'Loading'),
                  ),
                  ListTile(
                    leading:const FaIcon(FontAwesomeIcons.sun),
                    title: const Text('Humidity'),
                    trailing: Text(humidity != null ? humidity.toString() : 'Loading'),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.wind),
                    title: const Text('Wind Speed'),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : 'Loading'),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}

