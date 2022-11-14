import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'use_map_controller.dart';

class ExampleView extends HookWidget {
  static const routeName = '/pose';

  ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = useMapController();

    Timer? timer;
    void onMapIsReady(bool isReady) {
      print("Map is ready: $isReady");
      if (!isReady) {
        return;
      }
      if (Platform.isAndroid) {
        const rotateIntervalInMs = 500;
        timer = Timer.periodic(const Duration(milliseconds: rotateIntervalInMs),
            (timer) {
            print("This causes a problem:");
            mapController.rotateMapCamera(50);
        });
      }
    }

    useEffect(() {
      return () {
        timer?.cancel();
      };
    }, []);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: OSMFlutter(
                  onMapIsReady: onMapIsReady,
                  controller: mapController,
                  trackMyPosition: false,
                  initZoom: 18,
                  minZoomLevel: 8,
                  stepZoom: 1.0,
                  userLocationMarker: UserLocationMaker(
                    personMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                      ),
                    ),
                    directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                  roadConfiguration: RoadConfiguration(
                    startIcon: const MarkerIcon(
                      icon: Icon(
                        Icons.person,
                        size: 64,
                        color: Colors.brown,
                      ),
                    ),
                    roadColor: Colors.yellowAccent,
                  ),
                  markerOption: MarkerOption(
                      defaultMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
