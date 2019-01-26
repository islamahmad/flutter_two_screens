import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two Screens',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(
        title: 'Multiple Screens App',
        textBack: 'temp text',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.textBack}) : super(key: key);
  final String textBack;
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController tec = TextEditingController();
  void change() {
    setState(() {
      debugPrint('Hello');
    });
  }

  String textedBack = '';
  Future getData(BuildContext context) async {
    var retrievedData = await Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return NextScreen(
            text: tec.text,
          );
        },
      ),
    );
    if (retrievedData != null) {
      this.textedBack = retrievedData;
    } else {
      this.textedBack = 'No data was sent back';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextField(
                controller: tec,
                decoration: InputDecoration(
                    hintText: 'enter text to send to next screen',
                    labelText: 'enter text'),
              ),
              Container(
                child: RaisedButton(
                    child: Text('Send to Next Screen'),
                    onPressed: () {
                      getData(context);
                    }),
              ),
              ListTile(
                  title: Text(this
                      .textedBack) //(textedBack == null ? Text('') : Text(this.textedBack)),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  final String text;
//  NextScreen(this.text);
  NextScreen({Key key, this.text}) : super(key: key);

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  TextEditingController btec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SecondScreen',
        ),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Text('You Sent'),
              title: Text('${widget.text}'),
              subtitle: Text('Successfully'),
            ),
            ListTile(
              title: TextField(
                controller: btec,
                decoration: InputDecoration(
                  hintText: 'to send back',
                  labelText: 'enter text',
                ),
              ),
            ),
            RaisedButton(
              child: Text('Send back'),
              onPressed: () {
                var brouter = MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MyHomePage(
                      title: 'Data came back',
                      textBack: btec.text,
                    );
                  },
                );
                Navigator.pop(context, btec.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
