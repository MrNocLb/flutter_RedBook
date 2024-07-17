package com.example.sbluebooks

import io.flutter.embedding.android.FlutterActivity
import org.devio.flutter.splashscreen.SplashScreen // add
import android.os.Bundle

class MainActivity: FlutterActivity() {
         override fun onCreate(savedInstanceState: Bundle?) {
 
        SplashScreen.show(this, true)
        super.onCreate(savedInstanceState)
    }
}
