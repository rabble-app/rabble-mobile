import '../../config/export.dart';

class AppGoogleMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;

   AppGoogleMap(
      {super.key,
      required this.initialCameraPosition,
      this.zoomControlsEnabled = true,
      this.zoomGesturesEnabled = true,
      this.rotateGesturesEnabled = true,
      this.scrollGesturesEnabled = true});

  final Set<Marker> _markers = {};


  @override
  Widget build(BuildContext context) {
    _markers.add(
      Marker(
        markerId: const MarkerId('defaultMarker'),
        position: initialCameraPosition.target,
        icon: BitmapDescriptor.defaultMarker
      ),
    );
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      zoomControlsEnabled: zoomControlsEnabled,
      markers: _markers,
      myLocationButtonEnabled: false,
      onTap: (latLng) async {
        print('${latLng.latitude},${latLng.longitude}');
        String googleUrl =
            'https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}';
        if (await canLaunchUrl(
        Uri.parse(googleUrl))) {
        await launchUrl(
        Uri.parse(googleUrl));
        } else {
        throw 'Could not open the map.';
        }
      },
      zoomGesturesEnabled: zoomGesturesEnabled,
      rotateGesturesEnabled: rotateGesturesEnabled,
      scrollGesturesEnabled: scrollGesturesEnabled,
    );
  }
}
