import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapa_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapa_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapa_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
    void dispose() {
      BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (_, state) => crearMapa(state),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BtnUbicacion(),
            BtnSeguirUbicacion(),
            BtnMiRuta(),
          ]
        ),
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));
    
    // return Text('${state.ubicacion.latitude} ; ${state.ubicacion.longitude}');

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final cameraPosition = new CameraPosition(target: state.ubicacion, zoom: 15);
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      // onMapCreated: (GoogleMapController controller) => mapaBloc.initMapa(controller),
      onMapCreated: mapaBloc.initMapa, // Es lo mismo que la linea de arriba, porque recibe sólo 1 argumento
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        mapaBloc.add(OnMovioMapa(cameraPosition.target));
      }
    );
  }
  
}
