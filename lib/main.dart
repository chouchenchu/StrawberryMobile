import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  } //test
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//https://192.168.17.53:9233/sandbox/oauth/v2.1/token
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String respone='';
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
 void GetHttpApi() async{
   var headers = {
     'Content-Type': 'application/x-www-form-urlencoded'
   };
   //var uri = Uri.https('192.168.17.53:9233', 'sandbox/oauth/v2.1/token');
   //var uri = Uri.https('openapi.twse.com.tw', 'v1/exchangeReport/STOCK_DAY_ALL');
   var request = http.Request('GET', Uri.parse('http://192.168.17.110:8078/TonyTest/api/Login/Tony,11'));


   http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {
     print(await response.stream.bytesToString());
   }
   else {
     print(response.reasonPhrase);
   }
   ElevatedButton(
     child: Text('Press me!'),
     onPressed: () {
       print('Hello');
     },
   );
 }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              respone,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: GetHttpApi,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//test1


