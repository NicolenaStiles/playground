
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

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image (
            // TODO: scale this correctly! It's way too big!
            image: AssetImage('assets/asteroids_logo.png'),
          ),
          Row(
            // TODO: constrain this better! Also need to be icons!
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.pink,
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'About',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                height: 80,
                child: VerticalDivider(color: Colors.red)
              ),
              Container(
                color: Colors.pink,
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  'Blog',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                height: 80,
                child: VerticalDivider(color: Colors.red)
              ),
              Container(
                color: Colors.pink,
                width: 200,
                height: 100,
                child: const Text(
                  'Contact',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center
                ),
              ),
            ],
          )
        ]
        )
      )
    );
  }
}
