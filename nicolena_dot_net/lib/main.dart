
import 'package:flutter/material.dart';

void main() {
  runApp(const NicolenaDotNet());
}

class NicolenaDotNet extends StatelessWidget {
  const NicolenaDotNet({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Nicolena Dot Net',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Nicolena\'s landing page'),
      // get rid of debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class MenuItem {
  final String title;
  
  const MenuItem({
    required this.title,

  });
}

class MenuItemView {

}

class _HomePageState extends State<HomePage> {

  List<Container> _navList = [];
  List<String> _navListEntires = ['About', 'Blog', 'Stats', 'Contact'];

  Color _hoverColor = Colors.lime;

  TextStyle _hoverStyle = TextStyle(fontSize: 18, color: Colors.white);


  void _changeColors(Color c) {
    setState((){
      _hoverColor = c;
    }
    );
  }

  void _changeStyle(bool _isHover) {
    setState(() {
      if (_isHover) {
        _hoverStyle = TextStyle(
          shadows: [
            Shadow(
              blurRadius: 10,
              color: Colors.teal,
              offset: Offset(5, 5),
            )
          ],
          fontSize: 18,
          color: Colors.teal,
        );
      } else {
        _hoverStyle = TextStyle(fontSize: 18, color: Colors.white);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  color: Colors.pink,
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  child: Text(
                          'About',
                          style: TextStyle(fontSize: 24),
                          ),
                ),

                Container(
                  height: 80,
                  child: VerticalDivider(color: Colors.lime),
                ),

                Container(
                  color: Colors.pink,
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  child: Text(
                          'Blog',
                          style: TextStyle(fontSize: 24),
                          ),
                ),

                Container(
                  height: 80,
                  child: VerticalDivider(color: Colors.lime),
                ),

                Container(
                  color: Colors.pink,
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  child: Text(
                          'Contact',
                          style: TextStyle(fontSize: 24),
                          ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container( 
                  color: Colors.black,
                  alignment: Alignment.center,
                  width: 300,
                  height: 100,
                  child: MouseRegion(
                    onEnter: (_) {                      
                      _changeStyle(true);
                    },

                    onExit: (_) {
                      _changeStyle(false);
                    },

                    child: Text( 
                      'This is the mouse area testing location!',
                      style: _hoverStyle,
                    )
                  ),

                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
