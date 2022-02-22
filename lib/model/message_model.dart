class MessageModel {
  String? sendID;
  String? reciveID;
  String? text;
  String? dateTime;
  // String? postimage;

  MessageModel({this.sendID, this.reciveID, this.text, this.dateTime});

  MessageModel.fromJson(Map<String, dynamic>? Json) {
    sendID = Json!['sendID'];
    reciveID = Json['reciveID'];
    text = Json['text'];
    dateTime = Json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sendID': sendID,
      'dateTime': dateTime,
      'reciveID': reciveID,
      'text': text,
    };
  }
}
