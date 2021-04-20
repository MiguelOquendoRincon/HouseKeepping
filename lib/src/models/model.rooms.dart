class Room{
  final String idRoom;
  final String description;
  final String status;
  final String credits;
  final String guest;
  final String checkIn;
  final String checkOut;
  final String internalStatus;
  final String time;
  final int position;

  Room({
    this.idRoom, 
    this.description,
    this.status,
    this.credits,
    this.guest,
    this.checkIn,
    this.checkOut,
    this.internalStatus,
    this.time,
    this.position
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    idRoom: json["idRoom"],
    description: json["description"],
    status: json["status"],
    credits: json["credits"],
    guest: json["guest"],
    checkIn: json["checkIn"],
    checkOut: json["checkOut"],
    internalStatus: json["internalStatus"],
    time: json["time"],
    position: json["position"],

  );

  Map<String, dynamic> toJson() => {
    "idRoom": idRoom,
    "description": description,
    "status": status,
    "credits": credits,
    "guest": guest,
    "checkIn": checkIn,
    "checkOut": checkOut,
    "internalStatus": internalStatus,
    "time": time,
    "position": position
  };

}