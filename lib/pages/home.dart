import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const api = "https://rastyprojects.000webhostapp.com/staff";

class _HomeState extends State<Home> {
  Future getData() async {
    var url = Uri.parse(api + "/api");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A37EF),
        automaticallyImplyLeading: false,
        title: const Text(
          'Brands',
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
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    itemCount: snapshot.data.length ?? 2,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, i) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/devices',
                                arguments: {
                                  'id': snapshot.data[i]['id'],
                                  'name': snapshot.data[i]['name']
                                });
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: const Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    '$api/img/' + snapshot.data[i]['image'],
                                  ),
                                ),
                                Text(
                                  snapshot.data[i]['name'],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(255, 78, 58, 189),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("Empty..."),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                }
              },
            )),
      ),
    );
  }
}
