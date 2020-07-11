import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double _kScrollThreshold = 300;
const String _kTitle = "Title";
const double _kMaxElevation = 18;

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController scrollController = ScrollController();
  double scrollProgress = 0;

  @override
  void initState() {
    scrollController.addListener(() {
      setState(() {
        scrollProgress = Curves.fastOutSlowIn
            .transform(min(scrollController.offset / _kScrollThreshold, 1));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Opacity(
          opacity: 1 - scrollProgress,
          child: Text(_kTitle),
        ),
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          title: Opacity(
            opacity: scrollProgress,
            child: Text(_kTitle),
          ),
          centerTitle: true,
        ),
        elevation: _kMaxElevation * scrollProgress,
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: 100,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('data$index'),
          );
        },
      ),
    );
  }
}
