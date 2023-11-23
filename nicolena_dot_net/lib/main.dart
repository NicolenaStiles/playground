
import 'package:flutter/material.dart';
import 'BacklitText.dart';

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
        textTheme: const TextTheme(
        // TODO: test this?
        displayLarge: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        )
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

// TODO: Break navigation row out into its own widget?
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('Nicolena Dot Net', style: TextStyle(fontSize: 52, fontFamily: 'Hyperspace', fontWeight: FontWeight.w700)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BacklitText(textEntry: 'ABOUT'),
                Container( 
                  height: 25,
                  width: 4,
                  child: SizedBox(
                    height: 25,
                    child: VerticalDivider(color: Colors.cyan),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan,
                        blurRadius: 2,
                        offset: Offset(0,0),
                      ),
                    ],
                  ),
                ),
                BacklitText(textEntry: 'BLOG'),
                Container( 
                  height: 40,
                  width: 4,
                  child: SizedBox(
                    height: 40,
                    child: VerticalDivider(color: Colors.cyan),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan,
                        blurRadius: 2,
                        offset: Offset(0,0),
                      ),
                    ],
                  ),
                ),
                BacklitText(textEntry: 'CONTACT'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
