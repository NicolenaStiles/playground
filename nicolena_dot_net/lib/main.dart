
import 'package:flutter/material.dart';
import 'BacklitText.dart';
import 'BacklitDivider.dart';

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

// for sliding app bar
class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  SlidingAppBar({
    required this.child,
    required this.controller,
    required this.visible,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;
  
  @override
  Size get preferredSize => child.preferredSize;
  
  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
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
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  bool _visibleNav = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final AppBar _topBar = AppBar(
    title: const Text("This is a visible bar"),
    backgroundColor: Colors.purple,
  );

  void _switchVisibleNav() {
    setState(() {
      // from hidden to visible
      _visibleNav = !_visibleNav;
             
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 

      appBar: SlidingAppBar(
        controller: _controller, 
        visible: _visibleNav,
        child: _topBar, 
      ),

      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const Text('Nicolena Dot Net', style: TextStyle(fontSize: 52, fontFamily: 'Hyperspace', fontWeight: FontWeight.w700)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { 
                    _switchVisibleNav();   
                  },
                  child: const Text('Switch nav bar'),
                ),
              ],

              /*
              children: [
                BacklitText(textEntry: 'ABOUT'),
                BacklitDivider(),
                BacklitText(textEntry: 'BLOG'),
                BacklitDivider(),
                BacklitText(textEntry: 'CONTACT'),
              ],
              */
            ),
          ],
        ),
      ),
    );
  }
}
