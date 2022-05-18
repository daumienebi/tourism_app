class VisitPlaceFields{

  static final String id = 'id';
  static final String nombre ='nombre';
  static final String descripcion = 'descripcion';
  static final String latitude = 'coordenada';
  static final String longitude = 'time';

  //crear una lista estatica con el nombre de los valores para ayudar en la obtencion de datos de la bbd
  static final List <String> valores =[id,nombre,descripcion,latitude,longitude];
}

class VisitPlace{
  final int? id;
  final String nombre;
  final String descripcion;
  final String latitude;
  final String longitude;

  const VisitPlace({this.id,required this.nombre,required this.descripcion,required this.latitude,required this.longitude});


//clase para convertir el VisitPlace a un Mapa
  Map<String,Object?> toJson(){
    return{
      VisitPlaceFields.id  : id,
      VisitPlaceFields.nombre : nombre,
      VisitPlaceFields.descripcion : descripcion,
      VisitPlaceFields.latitude : latitude,
      VisitPlaceFields.longitude : longitude
    };
  }

  static VisitPlace fromJson(Map<String, Object?> json) {
    //convertir los datos de un json a objeto de tipo VisitPlace
    return VisitPlace(
        id: json[VisitPlaceFields.id] as int?,
        nombre: json[VisitPlaceFields.nombre] as String,
        descripcion: json[VisitPlaceFields.descripcion] as String,
        latitude: json[VisitPlaceFields.latitude] as String,
        longitude: json[VisitPlaceFields.longitude] as String,
    );
  }


  factory VisitPlace.fromMap(Map<String,dynamic> value) =>
      VisitPlace(
        id: value["id"],
        nombre: value["nombre"],
        descripcion: value["descripcion"],
        latitude: value["latitude"],
        longitude: value["longitude"],
      );

}