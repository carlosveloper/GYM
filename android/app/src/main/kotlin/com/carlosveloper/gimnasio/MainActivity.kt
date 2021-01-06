package com.carlosveloper.gimnasio

import android.os.Bundle
import io.flutter.app.FlutterApplication
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class MainActivity: FlutterActivity() , PluginRegistry.PluginRegistrantCallback {
    override fun onCreate(savedInstanceState: Bundle?) {
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        super.onCreate(savedInstanceState)
    }


    override fun registerWith(registry: PluginRegistry?) {
        registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin");
    }

}