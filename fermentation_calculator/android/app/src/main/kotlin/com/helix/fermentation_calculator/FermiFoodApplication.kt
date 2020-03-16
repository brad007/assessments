package com.helix.fermentation_calculator

import com.google.firebase.FirebaseApp
import io.flutter.app.FlutterApplication

class FermiFoodApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        if (FirebaseApp.getInstance() == null)
            FirebaseApp.initializeApp(applicationContext)
    }
}