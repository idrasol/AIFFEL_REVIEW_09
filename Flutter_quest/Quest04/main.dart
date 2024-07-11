import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'board_screen.dart';
import 'my_screen.dart';
import 'setting_screen.dart';
import 'onboarding_screen.dart';

void main() {
  // dart 애플리케이션의 진입점
  runApp(MyApp()); // MyApp 위젯을 루트 위젯으로 하여 애플리케이션 실행
}

class MyApp extends StatelessWidget {
  // MyApp 클래스 StatelessWidget 상속
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Material(app.dart) 위젯 반환으로 애플리케이션의 설정 제공
      debugShowCheckedModeBanner: false, // 화면에서 debug 배너 제거
      home: SplashScreen(), // 애플리케이션 시작시 표시할 초기화면 설정
      routes: {
        // 경로와 해당화면 맵핑
        '/main': (context) => MainScreen(),
        '/quiz': (context) => QuizScreen(),
        '/board': (context) => BoardScreen(),
        '/My': (context) => MyScreen(),
        '/Setting': (context) => SettingScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  // SplashScreen 상태 가질 수 있도록 정의
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // _SplashScreenState 클래스는 SplashScreen의 상태를 정의
  @override
  void initState() {
    // initState()는 위젯이 처음 생성될 때 호출
    super.initState();
    _navigateToMain(); // 여기서 메인 화면으로 전환하기 위해서 _navigateToMain을 호출
  }

  _navigateToMain() async {
    await Future.delayed(Duration(seconds: 3), () {}); // 3초 지연
    Navigator.pushReplacement(
      // Navigator.pushReplacement(온보딩 스크린 위젯을 완전히 제거)를 사용하여 MainScreen으로 전환
      context,
      MaterialPageRoute(
          builder: (context) =>
              MainScreen()), // 화면 전환 기본 관리 방법. 슬라이드 인되는 전환 애니메이션 제공. builder 필수 매개변수, 위젯 반환해야 함. 여기서 context는 BuildContext를 의미, MainScreen 위젯을 반환함
    );
  }

  @override
  Widget build(BuildContext context) {
    // State<SplashScreen>를 상속받는 State 클래스의 build 메서드를 재정의
    return OnboardingScreen(); //  build 메서드가 OnboardingScreen 위젯을 반환하도록 함. 즉, SplashScreen이 화면에 표시될 때, 실제로는 OnboardingScreen 위젯이 화면에 표시됨
  }
}

class MainScreen extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState(); //  MyAppState를 생성하여 상태를 관리
}

class MyAppState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    QuizScreen(),
    BoardScreen(),
    MyScreen(),
    SettingScreen(),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.green),
            child: Container(
                height: 48.0, alignment: Alignment.center, child: Text('내팝퀴즈')),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/big.jpg'), fit: BoxFit.fill)),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '출제',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '게시판',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'My',
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '설정',
              backgroundColor: Colors.pink)
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }
}
