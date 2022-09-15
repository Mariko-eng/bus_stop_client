
class ParkLocations{
  String destinationId;
  String destinationName;
  String parkLocationName;
  double positionLat;
  double positionLng;

  ParkLocations(
      {
        this.destinationId,
        this.destinationName,
        this.parkLocationName,
        this.positionLat,
        this.positionLng,
      });

  ParkLocations.fromMap(Map<String, dynamic> data){
    destinationId = data["destinationId"];
    destinationName = data["destinationName"];
    parkLocationName = data["parkLocationName"];
    positionLat = data["positionLat"].toDouble();
    positionLng = data["positionLng"].toDouble();
  }
}