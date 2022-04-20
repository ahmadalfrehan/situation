import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exanorated extends StatefulWidget {
  List<dynamic> m;
  Exanorated(this.m);
  @override
  _ExanoratedState createState() => _ExanoratedState(this.m);
}

class _ExanoratedState extends State<Exanorated> {
  List<dynamic> m;
  _ExanoratedState(this.m);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF2E282A),
        title: Text(
          'Universities List',
          style: TextStyle(
            color: Color(0xFFFAD8D6),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Scrollbar(
          radius: Radius.circular(140),
          interactive: true,
          showTrackOnHover: true,
          thickness: 20,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: m.length,
            itemBuilder: (context, index) => Container(
              //color: Colors.teal,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(1, 5, 1, 10),
                decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xFF2E282A),
                        spreadRadius: 3,
                        blurRadius: 1,
                      ),
                    ],
                    color: const Color(0xFF17BEBB),
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.width * 0.3,
                child: ListTile(
                    title: Text(
                      m[index]['name'].toString(),
                      style: const TextStyle(
                          color: Color(0xFF2E282A),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,),
                    ),
                    //visualDensity: BouncingScrollPhysics(),

                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  m[index]['country'].toString(),
                                  style: const TextStyle(
                                      color: Color(0xFF2E282A),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                                Expanded(
                                  child: Text(
                                    m[index]['web_pages'][0].toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF2E282A),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF2E282A),
                      child: Text(
                        index.toString(),
                        style: const TextStyle(),
                      ),
                    )),
              ),
              padding: const EdgeInsets.all(5),
              /*
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(index.toString(),style: const TextStyle(color: Colors.teal),)),





                ],
              )),
            ),*/
            ),
          ),
        ),
      ),
    );
  }
}
