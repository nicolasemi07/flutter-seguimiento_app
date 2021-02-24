import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapa_app/helpers/helpers.dart';
import 'package:mapa_app/pages/acceso_gps_page.dart';
import 'package:mapa_app/pages/mapa_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
  void initState() { 
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
  }

  @override
    void dispose() {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    }

  @override
    void didChangeAppLifecycleState(AppLifecycleState state) async {
      if (state == AppLifecycleState.resumed) {
        // Verificar permisos GPS
        final permisosGPS = await Permission.location.isGranted;

        // ¿GPS activo?
        final gpsActivo = await Geolocator.isLocationServiceEnabled();

        if (permisosGPS && gpsActivo) {
          Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
        } else if (!permisosGPS) {
          Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
        }

      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsYlocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else {
            return Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
        },
      ),
    );
  }

  Future checkGpsYlocation(BuildContext context) async {

    // Verificar permisos GPS
    final permisosGPS = await Permission.location.isGranted;

    // ¿GPS activo?
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if (permisosGPS && gpsActivo) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if (!permisosGPS) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Por favor, se necesitan permisos para acceder a la geolocalización';
    } else if (!gpsActivo) {
      return 'Esta aplicación requiere que la geolocalización esté activa';
    }
  }
}
