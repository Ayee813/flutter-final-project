import 'package:flutter/material.dart';
import 'package:flutter_final_projcet/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I_HVAE_PC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool? isFirstOpen;

  @override
  void initState() {
    super.initState();
    _checkFirstOpen();
  }

  Future<void> _checkFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final firstOpen = prefs.getBool('isFirstOpen') ?? true;
    if (firstOpen) {
      await prefs.setBool('isFirstOpen', false);
    }
    setState(() {
      isFirstOpen = firstOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstOpen == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return isFirstOpen! ? LoginPage() : MainPage();
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add authentication logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ComputerSetPage(),
    DIYComputerPage(),
    NotebookPage(),
    AboutUsPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('I have Pc'),
        backgroundColor: Color(
          0xff0077B6,
        ),
                leading: SizedBox(
          width: 10,
          child: Image.asset("assets/img/ihavepcLogo.png"),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.desktop_mac),
              label: 'Computer Set',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Build Your PC',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.laptop),
              label: 'Notebook',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About Us',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
              backgroundColor: Color(0xff0077B6)),
        ],
      ),
    );
  }
}

class ComputerSetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Computer Set Page'));
  }
}

class DIYComputerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Build Your PC Page'));
  }
}

class NotebookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Notebook Page'));
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('About Us Page'));
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Cart Page'));
  }
}
