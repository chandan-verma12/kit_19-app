package com.app.kit19App

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val mc = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        mc.setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
            if (methodCall.method == "test") {
                result.success("Hai from android " + methodCall.argument("data"))
                //Accessing data sent from flutter
            } else {
                Log.i("new method came", methodCall.method)
            }
        }
    }

    companion object {
        private const val CHANNEL = "AndySample/test"
    }
}