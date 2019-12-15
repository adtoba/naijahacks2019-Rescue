class Trustees {

  String _email;
  String _phoneNumber;
  String _name;
  String _docId;

  Trustees( 
    this._email,
    this._name,
    this._phoneNumber,
    this._docId
  );


  String get userId => _docId;
  String get email => _email;
  String get name => _name;
  String get phoneNumber => _phoneNumber;


  Trustees.fromJson(Map<String, dynamic> map) {
    this._email = map['email'];
    this._name = map['name'];
    this._phoneNumber = map['phoneNumber'];
    this._docId = map['docId'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = Map<String, dynamic>();

    jsonMap['email'] = this._email;
    jsonMap['name'] = this._name;
    jsonMap['phoneNumber'] = this._phoneNumber;
    jsonMap['userId'] = this._docId;

    return jsonMap;
  }
  
}