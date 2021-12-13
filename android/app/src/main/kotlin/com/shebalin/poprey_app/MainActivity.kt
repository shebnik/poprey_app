package com.shebalin.poprey_app

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)
    
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
          // Disable the Android splash screen fade out animation to avoid
          // a flicker before the similar frame is drawn in Flutter.
          splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }
    
        super.onCreate(savedInstanceState)
    }
}
