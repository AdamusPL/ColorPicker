import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_picker/screens/main_screen_widget.dart';
import 'package:flutter_color_picker/screens/second_screen_widget.dart';
import 'package:flutter_color_picker/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_color_picker/models/color_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) =>null);
  runApp(
    ChangeNotifierProvider(
        create: (context) => ColorModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const MyHomePage(
        title: 'Color Picker',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const SecondScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/images/calculate.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? Colors.amber[800]! : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Konwerter',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'lib/images/palette.svg',
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? Colors.amber[800]! : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Paleta',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        selectedIconTheme: const IconThemeData(size: 24),
        unselectedIconTheme: const IconThemeData(size: 24),
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}
