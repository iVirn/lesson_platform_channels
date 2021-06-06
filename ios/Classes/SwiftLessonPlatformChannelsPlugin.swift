import Flutter
import UIKit

public class SwiftLessonPlatformChannelsPlugin: NSObject, FlutterPlugin {
  var channel: FlutterMethodChannel?
  var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "lesson_platform_channels", binaryMessenger: registrar.messenger())

    let eventChannel = FlutterEventChannel(name: "lesson_platform_channels_event_channel", binaryMessenger: registrar.messenger())

    let instance = SwiftLessonPlatformChannelsPlugin()
    instance.channel = channel
    eventChannel.setStreamHandler(instance)

    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)

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
  public func applicationDidEnterBackground(_ application: UIApplication) {
    channel?.invokeMethod("enterBackground", arguments: nil)
  }

  public func applicationWillEnterForeground(_ application: UIApplication) {
    eventSink?("enterForeground")
  }
}

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
