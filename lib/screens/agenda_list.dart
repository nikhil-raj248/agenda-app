import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/agenda_list_model.dart';
import 'agenda_details.dart';
import 'package:intl/intl.dart';


class AgendaListScreen extends StatefulWidget {
  const AgendaListScreen({Key? key}) : super(key: key);

  @override
  State<AgendaListScreen> createState() => _AgendaListScreenState();
}

class _AgendaListScreenState extends State<AgendaListScreen> {

  bool isLoading = true;
  String? showErrorMessage;
  AgendaListModel? agendaListModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAgendaList();
    });
  }

  void loadAgendaList() async{
    setState(() {
      isLoading = true;
      showErrorMessage = null;
    });
    Map<String, dynamic> data = {
      'eid': '1989',
      'pid': '117195',
    };
    var dio = Dio();
    try {
      // FormData formData = new FormData.fromMap(data);
      var response = await dio.post('http://eventowl.net:3680/demo_agneda_list',
          data: data);
      setState(() {
        isLoading = false;
        agendaListModel = AgendaListModel.fromJson(jsonDecode(response.data));
      });
    } catch (e) {
      DioException temp = e as DioException;
      setState(() {
        isLoading = false;
        showErrorMessage = jsonDecode(temp.response?.data)['replyMsg'];
        print(showErrorMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        body: (isLoading)?Center(child: CircularProgressIndicator()):Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Agenda',style: TextStyle(
                        fontSize: 32,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w600)),
                    Container(
                      height: 48,
                      width: 48,decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        'https://eventowl.net/app/webroot/uploads/speaker/1684988075_97.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error_outline_sharp,color: Colors.red,);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (ctx,idx){
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                            child: Text(DateFormat.MMMMEEEEd().format(DateTime.now()),style: TextStyle(
                              fontFamily: 'poppins',
                                fontSize: 16,
                                color: (idx==0)?Color.fromRGBO(45, 136, 216, 1):Color.fromRGBO(32, 59, 84, 1),
                                //45, 136, 216, 1
                                fontWeight: FontWeight.w500))
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: agendaListModel!.data!.length,
                    itemBuilder: (ctx,idx){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AgendaDetailsScreen(id: agendaListModel!.data![idx].id!,)),);

                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                              border: Border.all(width: 0.2,color: Color.fromRGBO(151, 151, 151, 1))
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(agendaListModel!.data![idx].name!,style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(32, 59, 84, 1),
                                  fontWeight: FontWeight.w600)),
                                  width:250,
                                ),
                                SizedBox(height: 10,),
                                Text(DateFormat('kk:mm:a').format(DateTime.parse(agendaListModel!.data![idx].startDate!))
                                    + ' - ' + DateFormat('kk:mm:a').format(DateTime.parse(agendaListModel!.data![idx].endDate!)),style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(154, 154, 154, 1),
                                    fontWeight: FontWeight.w400)),
                                Container(
                                  height: 45,
                                  child: ListView.builder(
                                    itemCount: getLength(agendaListModel!.data![idx].attendees!.length),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx,idx2){
                                      if(getLength(agendaListModel!.data![idx].attendees!.length) == 7 && idx2 == 6){
                                        return Container(
                                          height: 26,
                                          width: 26,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(right: 8),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            // color: Colors.yellow
                                          ),
                                          child: Text('${agendaListModel!.data![idx].attendees!.length - 6}'),
                                        );
                                      }
                                      return Container(
                                        height: 26,
                                        width: 26,
                                        clipBehavior: Clip.hardEdge,
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            // color: Colors.yellow
                                        ),
                                        child: Image.network(
                                          agendaListModel!.data![idx].attendees![idx2].image!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(Icons.error_outline_sharp,color: Colors.red,);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getLength(int len){
    if(len>6){
      return 7;
    }
    else {
      return len;
    }
  }
}
