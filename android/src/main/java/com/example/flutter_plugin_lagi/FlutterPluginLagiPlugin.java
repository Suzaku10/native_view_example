package com.example.flutter_plugin_lagi;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * FlutterPluginLagiPlugin
 */
public class FlutterPluginLagiPlugin {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        if (registrar.activity() == null) {
            // When a background flutter view tries to register the plugin, the registrar has no activity.
            // We stop the registration process as this plugin is foreground only.
            return;
        }

        registrar
                .platformViewRegistry()
                .registerViewFactory(
                        "plugins.flutter.io/flutter_plugin_lagi", new ImageListFactory(registrar));
    }
}


class ImageListFactory extends PlatformViewFactory {
    private final PluginRegistry.Registrar mPluginRegistrar;

    ImageListFactory(PluginRegistry.Registrar registrar) {
        super(StandardMessageCodec.INSTANCE);
        mPluginRegistrar = registrar;
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        return new Terserah(id, context, mPluginRegistrar, args);
    }
}
