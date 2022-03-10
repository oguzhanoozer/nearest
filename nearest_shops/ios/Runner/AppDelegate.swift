import UIKit
import Flutter
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
// Add the GoogleMaps import.
#import "GoogleMaps/GoogleMaps.h"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    NSString* mapsApiKey = [NSProcessInfo processInfo] environment[@"GOOGLE_MAPS_API_KEY"];
    [GMSServices provideAPIKey:mapsApiKey]; 
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

