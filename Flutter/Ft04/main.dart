import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// https://fontawesome.com/icons/cart-shopping?s=solid 에서 아이콘들 확인 가능

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakao UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

// 호출
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// 채팅 방 목록 화면
class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 1; // 현재 [1]번째인 Messages에 오도록 초기화 (bottomNavigationBar에 필요)

  // BottomNavigationBar의 페이지 이동을 관리하는 메서드
  void _onItemTapped(int index) {
    if (index == 2) {
      // StoreScreen으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StoreScreen()),
      );
    } else {  // 현재 페이지가 두개만 구현되어 나머지는 할당없음
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // 화면 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false, // 자동 뒤로가기 아이콘 삭제
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [ // userText를 각 버튼 별로 유저명을 보냄
              ChatUserButton(userText: 'User 1'),
              ChatUserButton(userText: 'User 2'),
              ChatUserButton(userText: 'User 3'),
            ],
          ),
          /*
          // 처음엔 CircularIconButton을 사용해서 크게크게 만들었다가
          // bottomNavigationBar이 확실하게 아래 버튼을 추가해서 바꿈

          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularIconButton(icon: FontAwesomeIcons.user),
                CircularIconButton(icon: FontAwesomeIcons.envelope),
                CircularIconButton(icon: FontAwesomeIcons.store),
                CircularIconButton(icon: FontAwesomeIcons.gear),
              ],
            ),
          ),
          */
        ],
      ),
      // bottomNavigationBar 이용
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // 페이지 이동 메서드 호출함
        backgroundColor: Colors.grey[200], // 연한 회색 배경
        selectedItemColor: Colors.black, // 선택된 아이템의 색
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템의 색
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.envelope),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shoppingBag), // shoppingBag을 쓰지 말라고 의견이 뜨지만 아이콘이미지가 찰떡이라 채용함
            label: 'Shop',                              // Store 아이콘도 써봤지만 카카오톡 아이콘은 shoppingBag와 일치 함
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gear),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ChatUserButton 누를 시
class ChatUserButton extends StatelessWidget {
  final String userText;

  ChatUserButton({required this.userText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,  // ChatUserButton을 누를 시 ChatUserPage로 넘어가며 userText를 같이 보냄
            MaterialPageRoute(builder: (context) => ChatUserPage(userText: userText)),
          );
        },
        child: Container(
          decoration: BoxDecoration(  // 구분하기 쉽게 일단 테두리 선 추가
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            title: Text(userText),
          ),
        ),
      ),
    );
  }
}

/*
// 위에서 적은 것 처럼 원래는 CircularIconButton을 사용해 페이지를 이동할 계획이였음
// 현재 폐기
// CircularIconButton 누를 시
class CircularIconButton extends StatelessWidget {
  final IconData icon;

  CircularIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (icon == FontAwesomeIcons.store) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoreScreen()),
          );
        }
      },
      icon: FaIcon(icon),
      iconSize: 50,
    );
  }
}
*/

// 유저와 채팅방
class ChatUserPage extends StatelessWidget {
  final String userText;

  ChatUserPage({required this.userText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$userText 채팅방'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // 뒤로 보내는 아이콘 버튼
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(  // 채팅 기능은 미구현 상태
        color: Colors.amber[100],
        child: Center(
          child: Text(
            '$userText의 채팅방입니다.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

// 상점 페이지 화면
class _StoreScreenState extends State<StoreScreen> {
  int _selectedIndex = 2;

  // BottomNavigationBar의 페이지 이동을 관리하는 메서드
  void _onItemTapped(int index) {
    if (index == 1) {
      // ChatScreen으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    } else {  // 현재 페이지가 두개만 구현되어 나머지는 할당없음
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('쇼핑'),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false, // 자동 뒤로가기 아이콘 삭제
      ),
      body: Column(
        children: [ // 상점 페이지 body 구성
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AdBox(),
                AdBox(),
                AdBox(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ // 현재 상품 페이지 미구현으로 productName만 받은채 대기
                ProductBox(productName: '상품1'),
                ProductBox(productName: '상품2'),
                ProductBox(productName: '상품3'),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar 구성
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[200], // 연한 회색 배경
        selectedItemColor: Colors.black, // 선택된 아이템의 색
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템의 색
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.envelope),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shoppingBag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gear),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// 광고 영역
// 현재 미구현
class AdBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text('광고\n사진', textAlign: TextAlign.center),
      ),
    );
  }
}

// 상품 영역
// 현재 미구현
class ProductBox extends StatelessWidget {
  final String productName;

  ProductBox({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(productName),
      ),
    );
  }
}
