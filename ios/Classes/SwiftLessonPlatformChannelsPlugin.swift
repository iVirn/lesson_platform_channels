import Flutter
import UIKit

public class SwiftLessonPlatformChannelsPlugin: NSObject, FlutterPlugin {
  var channel: FlutterMethodChannel?
  var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftLessonPlatformChannelsPlugin()
    
    // Method Channel
    let channel = FlutterMethodChannel(name: "lesson_platform_channels", binaryMessenger: registrar.messenger())
    instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    // Application Delegate
    registrar.addApplicationDelegate(instance)
    
    // Event Channel
    let eventChannel = FlutterEventChannel(name: "lesson_platform_channels_event_channel", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)

    // Platform View Factory
    let viewFactory = ExampleViewFactory()
    registrar.register(viewFactory, withId: "ExampleView")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "power2":
        power2(call.arguments as! Int, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func power2(_ value: Int, result: @escaping FlutterResult) {
    let res = value * value

    result(res)
  }
}

extension SwiftLessonPlatformChannelsPlugin: UIApplicationDelegate {
  // Method Channel Usage
  public func applicationDidEnterBackground(_ application: UIApplication) {
    channel?.invokeMethod("enterBackground", arguments: nil)
  }

  // Event Channel Usage
  public func applicationWillEnterForeground(_ application: UIApplication) {
    eventSink?("enterForeground")
  }
}

// Event Channel
extension SwiftLessonPlatformChannelsPlugin: FlutterStreamHandler {
  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }
}
