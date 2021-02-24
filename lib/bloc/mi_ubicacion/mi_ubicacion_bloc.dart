import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  
  StreamSubscription<Position> _positionSubscription;
  
  MiUbicacionBloc() : super(MiUbicacionState());

  void iniciarSeguimiento() {
    this._positionSubscription = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high, distanceFilter: 10)
    .listen((Position position) {
      // print(position);
      final nuevaUbicacion = new LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    });
  }

  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {
    if (event is OnUbicacionCambio) { // Tenemos ubicacion nueva
      yield state.copyWith(existeUbicacion: true, ubicacion: event.ubicacion);
    }
  }
}
