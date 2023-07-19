import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/agenda_detail_model.dart';

class AgendaDetailsScreen extends StatefulWidget {
  const AgendaDetailsScreen({Key? key,required this.id}) : super(key: key);

  final int id;

  @override
  State<AgendaDetailsScreen> createState() => _AgendaDetailsScreenState();
}

class _AgendaDetailsScreenState extends State<AgendaDetailsScreen> {

  bool isLoading = true;
  String? showErrorMessage;
  int? id;
  AgendaDetailModel? agendaDetailModel;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAgendaDetails();
    });
  }

  void loadAgendaDetails() async{
    setState(() {
      isLoading = true;
      showErrorMessage = null;
    });
    var dio = Dio();
    try {
      var response = await dio.get('http://eventowl.net:3680/demo_agenda_detail?sid=1&eid=1989&pid=117195&aid=${id!}');
      agendaDetailModel = AgendaDetailModel.fromJson(jsonDecode(response.data));
      setState(() {
        isLoading = false;
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
        body: (isLoading)?Center(child: CircularProgressIndicator()):SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.grey,
                      child: Image.network(
                        agendaDetailModel!.imgPath! + agendaDetailModel!.data!.headerImg!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                              color: Colors.red,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error_outline_sharp,color: Colors.red,);
                        },
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_circle_left_outlined,color: Colors.white,size: 40,)
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 100),
                      child: Text(agendaDetailModel!.data!.name!,style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(32, 59, 84, 1),
                          fontWeight: FontWeight.w600)),
                    ),
                    // SizedBox(height: 20,),
                    Container(
                      height: (getLength(agendaDetailModel!.data!.attendees!.length)>0)?70:20,
                      child: ListView.builder(
                        itemCount: getLength(agendaDetailModel!.data!.attendees!.length),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx,idx){
                          if(getLength(agendaDetailModel!.data!.attendees!.length) == 7 && idx == 6){
                            return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.yellow
                              ),
                              child: Text('${agendaDetailModel!.data!.attendees!.length - 6}'),
                            );
                          }
                          return Container(
                            height: 40,
                            width: 40,
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.yellow
                            ),
                            child: Image.network(
                              agendaDetailModel!.data!.attendees![idx].image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error_outline_sharp,color: Colors.red,);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Icon(Icons.location_on_outlined,color: Colors.blue,size: 20,),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat.yMMMEd().format(DateTime.parse(agendaDetailModel!.data!.startDate!)),style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(32, 59, 84, 1),
                                fontWeight: FontWeight.w500)),
                            Text(DateFormat('kk:mm:a').format(DateTime.parse(agendaDetailModel!.data!.startDate!))
                                + ' - ' + DateFormat('kk:mm:a').format(DateTime.parse(agendaDetailModel!.data!.endDate!)),style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(154, 154, 154, 1),
                                fontWeight: FontWeight.w400)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Icon(Icons.calendar_month,color: Colors.blue,size: 20,),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(agendaDetailModel!.data!.locationName!,style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(32, 59, 84, 1),
                                fontWeight: FontWeight.w500)),
                            Text('1823 Medart Drive Tallahassee, FL 32303',style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(154, 154, 154, 1),
                                fontWeight: FontWeight.w400)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 15,),
                                child: Text('Enter Code', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),)
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0, 103, 171, 1),
                                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                // textStyle: TextStyle(
                                //     fontSize: 30,
                                //     fontWeight: FontWeight.bold)
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 30,),
                        Expanded(
                          child: ElevatedButton(
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Text('Take Survey', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),)),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(0, 103, 171, 1),
                              // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                              // textStyle: TextStyle(
                              //     fontSize: 30,
                              //     fontWeight: FontWeight.bold)
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text('Speakers',style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w500)),
                    SizedBox(height: 20,),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: agendaDetailModel!.data!.agendaSpeakers!.length,
                        itemBuilder: (ctx,idx){
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 46,
                                    width: 46,
                                    // clipBehavior: Clip.hardEdge,
                                    clipBehavior: Clip.hardEdge,
                              decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                                border: Border.all(width: 3,color: Colors.blue),
                              ),
                                    child: Container(
                                      height: 42,
                                      width: 42,
                                      clipBehavior: Clip.hardEdge,
                                      decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        agendaDetailModel!.data!.agendaSpeakers![idx].image!,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.error_outline_sharp,color: Colors.red,);
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(agendaDetailModel!.data!.agendaSpeakers![idx].name!,style: const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(32, 59, 84, 1),
                                          fontWeight: FontWeight.w500)),
                                      Text(agendaDetailModel!.data!.agendaSpeakers![idx].title!,style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(154, 154, 154, 1),
                                          fontWeight: FontWeight.w500)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text('Registration Links',style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w500)),
                    SizedBox(height: 20,),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: agendaDetailModel!.data!.registerLinks!.length,
                        itemBuilder: (ctx,idx){
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Center(
                              child: Container(
                                width: 270,
                                margin: EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 15),
                                      child: Text(agendaDetailModel!.data!.registerLinks![idx].registerText!, style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),)
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(0, 103, 171, 1),
                                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                    // textStyle: TextStyle(
                                    //     fontSize: 30,
                                    //     fontWeight: FontWeight.bold)
                                  ),
                                  onPressed: () async{
                                    final Uri url = Uri.parse(agendaDetailModel!.data!.registerLinks![idx].registerLink!);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text('Documents',style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w500)),
                    SizedBox(height: 20,),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: agendaDetailModel!.data!.agendaDocuments!.length,
                        itemBuilder: (ctx,idx){
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Center(
                              child: Container(
                                width: 270,
                                margin: EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 15),
                                      child: Text(agendaDetailModel!.data!.agendaDocuments![idx].documentName!, style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),)
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(0, 103, 171, 1),
                                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                    // textStyle: TextStyle(
                                    //     fontSize: 30,
                                    //     fontWeight: FontWeight.bold)
                                  ),
                                  onPressed: () async{
                                    final Uri url = Uri.parse(agendaDetailModel!.data!.agendaDocuments![idx].documentFile!);
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text('Description',style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w500)),
                    SizedBox(height: 20,),
                    Text(agendaDetailModel!.data!.description!,maxLines: 15,style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w400)),
                    SizedBox(height: 20,),
                    Text(agendaDetailModel!.data!.sponsorName!,style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(32, 59, 84, 1),
                        fontWeight: FontWeight.w500)),
                    Center(
                      child: Container(
                        height: 60,
                        width: 150,
                        child: Image.network(
                          agendaDetailModel!.imgPath! + agendaDetailModel!.data!.sponsorImg!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error_outline_sharp,color: Colors.red,);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
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
