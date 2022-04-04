
class eventHistory {

  final String date, event,device;



  eventHistory({required this.date, required this.event, required this.device});

  factory eventHistory.fromJson(Map<String, dynamic> json) {
    return new eventHistory(
      date: json['date'],
      event: json['event'],
      device: json['device'],
    );
  }
}