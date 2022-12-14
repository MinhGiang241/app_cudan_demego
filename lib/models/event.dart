// ignore_for_file: non_constant_identifier_names

class Event {
  Event(
      {this.approveManId,
      this.approve_date,
      this.code,
      this.content_event,
      this.cost_event,
      this.create_time,
      this.createdTime,
      this.end_time,
      this.event_for,
      this.file_upload,
      this.human_paticipate,
      this.id,
      this.location,
      this.notice,
      this.staffCreatedId,
      this.start_time,
      this.status_ticket,
      this.title,
      this.updatedTime,
      this.valid,
      this.human_number,
      this.due_regist,
      this.e,
      this.isParticipation,
      this.time_status,
      this.isShowButtonParticipate});
  String? id;
  String? createdTime;
  String? updatedTime;
  String? code;
  String? title;
  String? start_time;
  String? end_time;
  String? status_ticket;
  String? location;
  String? staffCreatedId;
  String? create_time;
  String? event_for;
  String? human_paticipate;
  String? time_status;
  int? human_number;
  int? cost_event;
  bool? notice;
  bool? valid;
  bool? isShowButtonParticipate;
  String? approveManId;
  String? approve_date;
  String? content_event;
  String? due_regist;
  bool? isParticipation;
  List<FileUpload>? file_upload;
  EventParticipation? e;
  Event.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    code = json['code'];
    title = json['title'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    status_ticket = json['status_ticket'];
    location = json['location'];
    staffCreatedId = json['staffCreatedId'];
    event_for = json['event_for'];
    human_paticipate = json['human_paticipate'];
    human_number = json['human_number'];
    cost_event = json['cost_event'];
    notice = json['notice'];
    valid = json['valid'];
    approveManId = json['approveManId'];
    approve_date = json['approve_date'];
    content_event = json['content_event'];
    time_status = json['time_status'];
    due_regist = json['due_regist'];
    isShowButtonParticipate = json['isShowButtonParticipate'];
    isParticipation = json['isParticipation'];
    e = (json['e'] != null) ? EventParticipation.fromJson(json['e']) : null;
    file_upload = json['file_upload'] != null
        ? json['file_upload'].length != 0
            ? json['file_upload']
                .map<FileUpload>((e) => FileUpload.fromJson(e))
                .toList()
            : []
        : [];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['code'] = code;
    data['title'] = title;
    data['start_time'] = start_time;
    data['end_time'] = end_time;
    data['status_ticket'] = status_ticket;
    data['location'] = location;
    data['staffCreatedId'] = staffCreatedId;
    data['event_for'] = event_for;
    data['human_paticipate'] = human_paticipate;
    data['cost_event'] = cost_event;
    data['notice'] = notice;
    data['valid'] = valid;
    data['approveManId'] = approveManId;
    data['approve_date'] = approve_date;
    data['content_event'] = content_event;
    data['due_regist'] = due_regist;
    data['file_upload'] =
        file_upload != null ? [...file_upload!.map((e) => e.toJson())] : [];
    return data;
  }
}

class FileUpload {
  String? id;
  String? name;
  FileUpload.fromJson(Map<String, dynamic> json) {
    id = json['file_id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_id'] = id;
    data['name'] = name;
    return data;
  }
}

class EventParticipation {
  EventParticipation(
      {this.accountId,
      this.createdTime,
      this.eventId,
      this.event_for,
      this.id,
      this.updatedTime,
      this.residentId});

  String? id;
  String? createdTime;
  String? updatedTime;
  String? eventId;
  String? accountId;
  String? event_for;
  String? residentId;

  EventParticipation.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
    eventId = json['eventId'];
    accountId = json['accountId'];
    event_for = json['event_for'];
    residentId = json['residentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdTime'] = createdTime;
    data['updatedTime'] = updatedTime;
    data['eventId'] = eventId;
    data['accountId'] = accountId;
    data['event_for'] = event_for;
    data['residentId'] = residentId;

    return data;
  }
}
