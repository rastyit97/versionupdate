import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      return jsonDecode(response.body);
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFE76E54),
        automaticallyImplyLeading: false,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: getData(arguments['id']),
              builder: (context, AsyncSnapshot snapshot) {
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
                                      alignment: Alignment(-1, -1),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Text(
                                          "Device Name: " +
                                              snapshot.data[i]['device_name'],
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: 'Rabar',
                                            color: Color(0xFF020202),
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
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
    );
  }
}
