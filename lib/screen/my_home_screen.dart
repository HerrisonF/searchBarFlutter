import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_search_bar/component/search.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> textos = [
    'Banana',
    'Balde',
    'Macarrão',
    'Escova',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(64.0),
                        child: Container(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              showSearch(context: context, delegate: Search(textos));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Pesquise o item que deseja',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
