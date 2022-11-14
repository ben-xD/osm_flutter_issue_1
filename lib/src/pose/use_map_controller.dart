import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

MapController useMapController() {
  // TODO allow more parameters
  return use(
    _MapControllerHook(),
  );
}


class _MapControllerHook extends Hook<MapController> {
  @override
  HookState<MapController, Hook<MapController>> createState() =>
      _MapControllerHookState();
}

class _MapControllerHookState
    extends HookState<MapController, _MapControllerHook> {
  late MapController _controller;

  @override
  MapController build(BuildContext context) {
    // final customTile = CustomTile(
    //     urlsServers: [TileURLs(url: "https://tile.openstreetmap.org/")],
    //     tileExtension: ".png",
    //     sourceName: "osm");
    _controller = MapController(initPosition: GeoPoint(latitude: 0.0, longitude: 0.0),
        initMapWithUserPosition: true);
    return _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
  }

}