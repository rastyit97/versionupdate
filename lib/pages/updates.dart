import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: prefer_typing_uninitialized_variables
var message;

class Updates extends StatefulWidget {
  const Updates({Key? key}) : super(key: key);

  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    Future getData(id) async {
      var url = Uri.parse(
          "https://rastyprojects.000webhostapp.com/staff/api/viewdevice.php?id=$id");
      var response = await http.get(url);
      message = json.decode(response.body)[0];
      return jsonDecode(response.body);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A37EF),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFFFF5F5),
            size: 24,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/devices', arguments: {
              'id': arguments['comany_id'],
              'name': arguments['comany_name'],
            });
          },
        ),
        title: Text(
          arguments['name'].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFF1F4F7),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: getData(arguments['id']),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return const Text('Check your internet');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.length > 0) {
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: PageView.builder(
                            controller: pageViewController,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              if (message == null) {
                                return Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0xFFF5F5F5),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(0, 0),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: Text(
                                            'No Updates Available',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF020202),
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 5, 5, 5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              'https://rastyprojects.000webhostapp.com/staff/img/' +
                                                  snapshot.data[i]
                                                      ['company_logo'],
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[i]['company_name'],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF0F0E0E),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          9, 9, 9, 9),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data[i]
                                                    ['company_software'] +
                                                " " +
                                                snapshot.data[i]['version'],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF0D0C0C),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          9, 9, 9, 9),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Update Details :',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF090A13),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[i]['details'],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          9, 9, 9, 9),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            snapshot.data[i]['date'],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFFB81012),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, 1),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SmoothPageIndicator(
                              controller: pageViewController,
                              count: snapshot.data.length,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) {
                                pageViewController.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: ExpandingDotsEffect(
                                expansionFactor: 2,
                                spacing: 8,
                                radius: 16,
                                dotWidth: 16,
                                dotHeight: 16,
                                dotColor: Color(0xFF9E9E9E),
                                activeDotColor: Color(0xFF4A37EF),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("No Data Found !"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEFEFFD),
        unselectedItemColor: const Color(0xFF1D97FF),
        selectedItemColor: const Color(0xFF6362E7),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
