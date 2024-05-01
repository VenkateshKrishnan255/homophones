import 'package:flutter/material.dart';
import 'package:flutter_homophones_venkat/AppData/appdatatext.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import '../Screen/displaytext.dart';

class PageViewtext extends StatefulWidget {
  const PageViewtext({super.key});

  @override
  State<PageViewtext> createState() => _PageViewtextState();
}

class _PageViewtextState extends State<PageViewtext> {
  FlutterTts flutterTts = FlutterTts();
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(
          'Homophones',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  'Share',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
            elevation: 10,
            onSelected: (value) {
              if (value == 1) {
                _shareInfo();//method call
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 50),
            height: 300,
            child: PageView.builder(//loop
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              controller: PageController(viewportFraction: 0.7),
              itemCount: appDataList.length,
              itemBuilder: (context, index) {
                var _scale = _selectedIndex == index ? 1.0 : 0.8;//Conditional opertor
                return TweenAnimationBuilder(
                    tween: Tween(begin: _scale, end: _scale),
                    duration: Duration(milliseconds: 300),
                    child: DisplayText(appDataText: appDataList[index]),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  (_selectedIndex + 1).toString() +
                      '/' +
                      appDataList.length.toString(),
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
              _speak(appDataList[_selectedIndex].text);
            },
            child: Icon(Icons.mic),
          )
        ],
      ),
    );
  }

  _shareInfo() {
    print('------------------->Share');
    print(appDataList[_selectedIndex].text);
    Share.share(appDataList[_selectedIndex].text);
  }

  void _speak(String text) async{
    print('------------------->Speak');
    await flutterTts.setLanguage('En');
    await flutterTts.setPitch(0.4);
    await flutterTts.speak(text);
  }
}
