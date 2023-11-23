
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

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold( 
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BacklitText(textEntry: 'Test One'),
                BacklitText(textEntry: 'Test Two'),
                BacklitText(textEntry: 'Test Three'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
