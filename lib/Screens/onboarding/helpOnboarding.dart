import 'package:flutter/material.dart';
import '../../../components/untere_leiste.dart';
import 'content_model.dart';

class HelpOnboarding extends StatefulWidget {
  @override
  _HelpOnboardingState createState() => _HelpOnboardingState();
}

class _HelpOnboardingState extends State<HelpOnboarding> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: contents.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text(
                      contents[i].title!,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      contents[i].discription!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      child: Image.asset(
                        contents[i].image!,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
        ),
        Container(
          height: 60,
          margin: EdgeInsets.all(40),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UntereLeiste(),
                  ),
                );
              }
              _controller!.nextPage(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceIn,
              );
            },
            child: Text(
                currentIndex == contents.length - 1 ? "Schließen" : "Weiter",
                style: TextStyle(color: Colors.black)),
            style: TextButton.styleFrom(
                primary: Colors.green[200], backgroundColor: Colors.green[200]),
          ),
        ),
        SizedBox(height: 20),
      ],
    ));
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
