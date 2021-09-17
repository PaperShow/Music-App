import 'package:flutter/material.dart';
import 'package:test_app/audio_external.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Incrementing chips'),
      home: AudioExternal(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int i = 0;

  Widget newItem(int i) {
    Key key = Key('$i');
    return Container(
      padding: EdgeInsets.all(10),
      child: Chip(
        label: Text('$i Name Here'),
        deleteIcon: Icon(Icons.clear),
        deleteIconColor: Colors.redAccent,
        avatar: CircleAvatar(
          child: Text('$i'),
        ),
        onDeleted: () {
          removeItem(key);
        },
      ),
    );
  }

  void removeItem(Key key) {
    for (i = 0; i < chips.length; i++) {}
    Widget child = chips.elementAt(i);
    if (child.key == key) {
      setState(() {
        chips.removeAt(i);
      });
      print('removing ${key.toString()}');
    }
  }

  List<Widget> chips = [];
  void addChips() {
    chips.add(newItem(i));
    i++;
  }

  @override
  void initState() {
    super.initState();
    for (i = 0; i < 5; i++) {
      chips.add(newItem(i));
    }
  }

  double _currentSliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              children: chips,
            ),
            SliderTheme(
              data: SliderThemeData(
                  activeTrackColor: Colors.blueGrey[700],
                  inactiveTrackColor: Colors.blueGrey,
                  thumbColor: Colors.pinkAccent),
              child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  // label: _currentSliderValue.toString(),
                  onChanged: (newValue) {
                    setState(() {
                      _currentSliderValue = newValue;
                      print(_currentSliderValue);
                    });
                  }),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: _currentSliderValue / 100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                value: _currentSliderValue / 100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: RefreshProgressIndicator(
                value: _currentSliderValue / 100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addChips();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
