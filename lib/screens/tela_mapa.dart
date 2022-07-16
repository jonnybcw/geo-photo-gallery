import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_final/controllers/controller.dart';
import 'package:projeto_final/screens/janela_foto.dart';

class TelaMapa extends StatefulWidget {
  const TelaMapa({required this.controller, Key? key}) : super(key: key);

  final Controller controller;

  @override
  State<TelaMapa> createState() => _TelaMapaState();
}

class _TelaMapaState extends State<TelaMapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: _getMap(),
    );
  }

  Widget _getMap() {
    return FutureBuilder(
      future: widget.controller.getDeviceLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Object? data = snapshot.data;
          if (data is LatLng) {
            return FlutterMap(
              options: MapOptions(
                center: data,
                zoom: 9.2,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  maxNativeZoom: 18,
                ),
                MarkerLayerOptions(
                  markers: widget.controller.fotos
                      .map((foto) => Marker(
                            point:
                                LatLng(foto.latitude ?? 0, foto.longitude ?? 0),
                            width: 80,
                            height: 80,
                            builder: (context) => IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        JanelaFoto(foto: foto));
                              },
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.red[800],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
              nonRotatedChildren: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black45.withOpacity(0.5),
                    ),
                    child: Text(
                      'FlutterMap - OpenStreetMap',
                    ),
                  ),
                )
              ],
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
