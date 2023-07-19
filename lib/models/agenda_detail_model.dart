class AgendaDetailModel {
  String? replyCode;
  String? replyMsg;
  Data? data;
  String? cmd;
  String? imgPath;
  String? attendeeImgPath;
  String? speakerImgPath;

  AgendaDetailModel(
      {this.replyCode,
        this.replyMsg,
        this.data,
        this.cmd,
        this.imgPath,
        this.attendeeImgPath,
        this.speakerImgPath});

  AgendaDetailModel.fromJson(Map<String, dynamic> json) {
    replyCode = json['replyCode'];
    replyMsg = json['replyMsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    cmd = json['cmd'];
    imgPath = json['imgPath'];
    attendeeImgPath = json['attendeeImgPath'];
    speakerImgPath = json['speakerImgPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyCode'] = this.replyCode;
    data['replyMsg'] = this.replyMsg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['cmd'] = this.cmd;
    data['imgPath'] = this.imgPath;
    data['attendeeImgPath'] = this.attendeeImgPath;
    data['speakerImgPath'] = this.speakerImgPath;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? eventId;
  String? name;
  String? startDate;
  String? endDate;
  String? description;
  String? sponsorName;
  String? sponsorImg;
  String? locationName;
  String? headerImg;
  int? myAgenda;
  List<Attendees>? attendees;
  List<RegisterLinks>? registerLinks;
  List<AgendaDocuments>? agendaDocuments;
  List<AgendaSpeakers>? agendaSpeakers;

  Data(
      {this.id,
        this.userId,
        this.eventId,
        this.name,
        this.startDate,
        this.endDate,
        this.description,
        this.sponsorName,
        this.sponsorImg,
        this.locationName,
        this.headerImg,
        this.myAgenda,
        this.attendees,
        this.registerLinks,
        this.agendaDocuments,
        this.agendaSpeakers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventId = json['event_id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    sponsorName = json['sponsor_name'];
    sponsorImg = json['sponsor_img'];
    locationName = json['location_name'];
    headerImg = json['header_img'];
    myAgenda = json['my_agenda'];
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(new Attendees.fromJson(v));
      });
    }
    if (json['register_links'] != null) {
      registerLinks = <RegisterLinks>[];
      json['register_links'].forEach((v) {
        registerLinks!.add(new RegisterLinks.fromJson(v));
      });
    }
    if (json['agenda_documents'] != null) {
      agendaDocuments = <AgendaDocuments>[];
      json['agenda_documents'].forEach((v) {
        agendaDocuments!.add(new AgendaDocuments.fromJson(v));
      });
    }
    if (json['agenda_speakers'] != null) {
      agendaSpeakers = <AgendaSpeakers>[];
      json['agenda_speakers'].forEach((v) {
        agendaSpeakers!.add(new AgendaSpeakers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['event_id'] = this.eventId;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['sponsor_name'] = this.sponsorName;
    data['sponsor_img'] = this.sponsorImg;
    data['location_name'] = this.locationName;
    data['header_img'] = this.headerImg;
    data['my_agenda'] = this.myAgenda;
    if (this.attendees != null) {
      data['attendees'] = this.attendees!.map((v) => v.toJson()).toList();
    }
    if (this.registerLinks != null) {
      data['register_links'] =
          this.registerLinks!.map((v) => v.toJson()).toList();
    }
    if (this.agendaDocuments != null) {
      data['agenda_documents'] =
          this.agendaDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.agendaSpeakers != null) {
      data['agenda_speakers'] =
          this.agendaSpeakers!.map((v) => v.toJson()).toList();
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

class RegisterLinks {
  String? registerLink;
  String? registerText;

  RegisterLinks({this.registerLink, this.registerText});

  RegisterLinks.fromJson(Map<String, dynamic> json) {
    registerLink = json['register_link'];
    registerText = json['register_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['register_link'] = this.registerLink;
    data['register_text'] = this.registerText;
    return data;
  }
}

class AgendaDocuments {
  String? documentName;
  String? documentFile;

  AgendaDocuments({this.documentName, this.documentFile});

  AgendaDocuments.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    documentFile = json['document_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['document_file'] = this.documentFile;
    return data;
  }
}

class AgendaSpeakers {
  String? name;
  String? title;
  String? companyName;
  String? image;

  AgendaSpeakers({this.name, this.title, this.companyName, this.image});

  AgendaSpeakers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    companyName = json['company_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['company_name'] = this.companyName;
    data['image'] = this.image;
    return data;
  }
}
