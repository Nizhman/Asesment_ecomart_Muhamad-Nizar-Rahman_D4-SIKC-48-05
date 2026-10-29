
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiPage extends StatefulWidget {
  const LokasiPage({super.key});

  @override
  State<LokasiPage> createState() => _LokasiPageState();
}

class _LokasiPageState extends State<LokasiPage> {
  static const LatLng lokasiEcomart = LatLng(
    -6.914744,
    107.609810,
  );

  late final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('Bank Sampah Hijau'),
      position: lokasiEcomart,
      infoWindow: InfoWindow(
        title: 'Ecomart Bandung',
        snippet: 'Lokasi simulasi komunitas Ecomart',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Ecomart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: lokasiEcomart,
                zoom: 15,
              ),
              markers: markers,
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 32,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ecomart Bandung',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Lokasi komunitas simulasi',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Lat: -6.914744, Long: 107.609810',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
