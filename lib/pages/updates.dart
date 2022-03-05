import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Updates extends StatefulWidget {
  const Updates({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future getdata(id) async {
    var url = Uri.parse(
        "http://rwangafinalapp.infinityfreeapp.com/staff/api/viewdevice.php?id=$id");
    Response response = await http.get(url);
    debugPrint(response.body.length.toString());
    var json = jsonDecode(response.body);
    return json;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A37EF),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFFFF5F5),
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        title: const Text(
          'Devises',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFF1F4F7),
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEAE9EE),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
            child: FutureBuilder(
                future: getdata(widget.id),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading Data');
                  } else if (snapshot.hasError) {
                    return const Text('Check your internet');
                  }
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: Container(
                            width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data[i]['device_name'] ??
                                        'null name',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 78, 58, 189),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[i]['company_id'] ??
                                        'null date',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 78, 58, 189),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
