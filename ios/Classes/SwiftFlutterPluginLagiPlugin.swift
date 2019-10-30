import Flutter
import UIKit

public class SwiftFlutterPluginLagiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let imageListViewFactory = ImageListViewFactory(with: registrar)
    registrar.register(imageListViewFactory, withId: "plugins.flutter.io/flutter_plugin_lagi")

  }
}

public class ImageListViewFactory : NSObject, FlutterPlatformViewFactory {
    var _registrar: FlutterPluginRegistrar
    
    init(with registrar: FlutterPluginRegistrar) {
        _registrar = registrar
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return ImageListView(frame, viewId: viewId, args: args, with: _registrar)
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
public class ImageListView : NSObject, FlutterPlatformView {
    var textview: UITextView
    var albumId: String = ""
    var _channel: FlutterMethodChannel
    
    init(_ frame: CGRect, viewId: Int64, args: Any?, with registrar: FlutterPluginRegistrar) {
        if let dict = args as? [String: Any] {
            self.albumId = (dict["albumId"] as? String)!
        }
        
    textview = UITextView(frame: frame)
//        var test: String
        textview.text = "kokoko"
        
        
          _channel = FlutterMethodChannel(name: "plugins.flutter.io/flutter_plugin_lagi/\(viewId)", binaryMessenger: registrar.messenger())
        
        super.init()
//        let tapOutTextField: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector("gestureRecognizer:"))
//
//
////        tapTerm = UITapGestureRecognizer(target: self, action: "tapTextView:")
////        tapTerm.delegate = self
////        textView.addGestureRecognizer(tapTerm)
//
//        textview.addGestureRecognizer(tapOutTextField)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureRecognizer(_:)))
        textview.addGestureRecognizer(tap)
        
//        textview.tap
        _channel.setMethodCallHandler { call, result in
            if call.method == "setText" {
                if let map = call.arguments as? Dictionary<String, Any>{
                  self.textview.text = (map["text"] as? String) ?? "kosong"
                }
            }
        }
    }
    @objc func gestureRecognizer(_ sender: UITapGestureRecognizer? = nil) {
        _channel.invokeMethod("onClick", arguments: [ "now" : NSDate().timeIntervalSince1970])
//        return true
    }
    
    public func view() -> UIView {
        return textview
    }
    
    
}
