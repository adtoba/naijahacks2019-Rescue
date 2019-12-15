class Panics {

  String _senderAddress;
  String _senderEmail;
  String _attackType;
  double _lat;
  double _long;

  Panics( 
   this._senderAddress,
   this._senderEmail,
   this._attackType,
   this._lat,
   this._long
  );


  String get senderAddress => _senderAddress;
  String get senderEmail => _senderEmail;
  String get attackType => _attackType;
  double get lat => _lat;
  double get long => _long;

  Panics.fromJson(Map<String, dynamic> map) {
    this._senderAddress = map['senderAddress'];
    this._senderEmail = map['senderEmail'];
    this._attackType = map['attackType'];
    this._lat = map['lat'];
    this._long = map['long'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = Map<String, dynamic>();

    jsonMap['senderAddress'] = this._senderAddress;
    jsonMap['senderEmail'] = this._senderEmail;
    jsonMap['attackType'] = this._attackType;
    jsonMap['lat'] = this._lat;
    jsonMap['long'] = this._long;

    return jsonMap;
  }

  
}