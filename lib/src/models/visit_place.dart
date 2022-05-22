class VisitPlaceFields{

  static final String id = 'id';
  static final String name ='name';
  static final String description = 'description';
  static final String latitude = 'latitude';
  static final String longitude = 'longitude';

  //crear una lista estatica con el nombre de los valores para ayudar en la obtencion de datos de la bbd
  static final List <String> values =[id,name,description,latitude,longitude];
}

class VisitPlace{
  final int? id;
  final String name;
  final String description;
  final String latitude;
  final String longitude;

  const VisitPlace({this.id,required this.name,required this.description,required this.latitude,required this.longitude});

  factory VisitPlace.fromMap(Map<String,dynamic> value) =>
      VisitPlace(
        id: value["id"],
        name: value["name"],
        description: value["description"],
        latitude: value["latitude"],
        longitude: value["longitude"],
      );

  Map<String,dynamic> toMap() =>{
    VisitPlaceFields.id           :this.id,
    VisitPlaceFields.name         :this.name,
    VisitPlaceFields.description  :this.description,
    VisitPlaceFields.latitude     :this.latitude,
    VisitPlaceFields.longitude    :this.longitude,
  };

  @override
  String toString(){
    return 'VisitPlace{id : $id, name: $name, description : $description, latidude : $latitude, longitude: $longitude}';
  }
}