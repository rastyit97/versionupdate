import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:versionupdate/pages/updates.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);
  // final int id;
  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    Future getData(id) async {
      // String id = Get.parameters['id'].toString();
      // var url = Uri.parse(
      //     "https://rastyprojects.000webhostapp.com/staff/api/devices.php?id=$id");
      // var response = await http.get(url);
      // return jsonDecode(response.body);

      var url = Uri.parse(
          "https://rastyprojects.000webhostapp.com/staff/api/devices.php?id=$id");
      var response = await http.get(url);
      return jsonDecode(response.body);

      // debugPrint(response.body.length.toString());
      // debugPrint(response.body[1]['name'].toString());
      // var json = jsonDecode(response.body);
      // return json;
      // json.data.length
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
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        title: Text(
          arguments['name'].toString(),
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
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/updates',
                              arguments: {'id': snapshot.data[i]['id']});
                        },
                        child: Padding(
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
                                    snapshot.data[i]['id'] ?? 'null id',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 113, 89, 221),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[i]['name'] ?? 'null name',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 78, 58, 189),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[i]['date'] ?? 'null date',
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
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
