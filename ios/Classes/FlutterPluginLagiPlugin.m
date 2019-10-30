#import "FlutterPluginLagiPlugin.h"
#import <flutter_plugin_lagi/flutter_plugin_lagi-Swift.h>

@implementation FlutterPluginLagiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginLagiPlugin registerWithRegistrar:registrar];
}
@end
