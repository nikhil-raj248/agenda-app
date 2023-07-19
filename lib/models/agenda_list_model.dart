class AgendaListModel {
  String? replyCode;
  String? replyMsg;
  List<Data>? data;
  String? cmd;
  String? imgPath;
  String? attendeeImgPath;

  AgendaListModel(
      {this.replyCode,
        this.replyMsg,
        this.data,
        this.cmd,
        this.imgPath,
        this.attendeeImgPath});

  AgendaListModel.fromJson(Map<String, dynamic> json) {
    replyCode = json['replyCode'];
    replyMsg = json['replyMsg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    cmd = json['cmd'];
    imgPath = json['imgPath'];
    attendeeImgPath = json['attendeeImgPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyCode'] = this.replyCode;
    data['replyMsg'] = this.replyMsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['cmd'] = this.cmd;
    data['imgPath'] = this.imgPath;
    data['attendeeImgPath'] = this.attendeeImgPath;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  int? myAgenda;
  List<Attendees>? attendees;

  Data(
      {this.id,
        this.name,
        this.startDate,
        this.endDate,
        this.myAgenda,
        this.attendees});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    myAgenda = json['my_agenda'];
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(new Attendees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['my_agenda'] = this.myAgenda;
    if (this.attendees != null) {
      data['attendees'] = this.attendees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendees {
  String? image;
  String? companyName;
  String? name;

  Attendees({this.image, this.companyName, this.name});

  Attendees.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    companyName = json['company_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['company_name'] = this.companyName;
    data['name'] = this.name;
    return data;
  }
}
