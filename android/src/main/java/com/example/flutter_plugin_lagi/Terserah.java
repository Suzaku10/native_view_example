package com.example.flutter_plugin_lagi;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;

public class Terserah implements MethodChannel.MethodCallHandler, PlatformView, View.OnClickListener {
    private final MethodChannel methodChannel;
    int id;
    Context context;
    PluginRegistry.Registrar registrar;
    Object object;
    String res = "";
    TextView tv;
    private View view;

    public Terserah(int id, Context context, PluginRegistry.Registrar registrar, Object object) {
        this.id = id;
        this.context = context;
        this.registrar = registrar;
        this.object = object;
        methodChannel =
                new MethodChannel(registrar.messenger(), "plugins.flutter.io/flutter_plugin_lagi/" + id);
        methodChannel.setMethodCallHandler(this);
//        view = registrar.activity().getLayoutInflater().inflate(R.layout.image_list, null);

        if (object instanceof HashMap) {
            Map<String, Object> params = (Map<String, Object>) object;
            res = params.get("albumId").toString();
        }

        tv = new TextView(context);
        tv.setOnClickListener(this);
        tv.setText(res);
    }

    @Override
    public View getView() {
        return tv;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d("ini tag", "onMethodCall: " + methodCall.method + methodCall.arguments);
        if(methodCall.method.equals("setText")){
            Log.d("tagggg", "onMethodCall: " + "didalem");
            tv.setText(methodCall.argument("text").toString());
        } else {
            Log.d("987897", "onMethodCall: " + methodCall.method);
        }
    }

    @Override
    public void onClick(View v) {
        HashMap<String, Long> test = new HashMap<>();

        test.put("now", System.currentTimeMillis());

        methodChannel.invokeMethod("onClick", test);
    }
}
