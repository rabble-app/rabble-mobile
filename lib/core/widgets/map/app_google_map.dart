import '../../config/export.dart';

class AppGoogleMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final bool rotateGesturesEnabled;
  final bool scrollGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;

  const AppGoogleMap(
      {super.key,
      required this.initialCameraPosition,
      this.zoomControlsEnabled = true,
      this.zoomGesturesEnabled = true,
      this.rotateGesturesEnabled = true,
      this.scrollGesturesEnabled = true});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      zoomControlsEnabled: zoomControlsEnabled,
      myLocationButtonEnabled: false,
      zoomGesturesEnabled: zoomGesturesEnabled,
      rotateGesturesEnabled: rotateGesturesEnabled,
      scrollGesturesEnabled: scrollGesturesEnabled,
    );
  }
}
