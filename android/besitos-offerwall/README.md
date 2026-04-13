# Besitos Offerwall - Android Core SDK

This folder contains the core Android implementation of the **Besitos Offerwall SDK**. You can either add this entire folder as a module to your project or copy the source files directly.

---

## Option 1: Add as a Library Module (Recommended)

This is the easiest way. It automatically handles themes, manifest registration, and dependencies for you.

1. **Copy the folder**: Copy this entire `besitos-offerwall` folder into your Android project's root directory.
2. **Include it**: In your project's `settings.gradle.kts`, add it at the bottom:
   ```kotlin
   include(":app")
   include(":besitos-offerwall")
   ```
3. **Add the Dependency**: In your app's `build.gradle.kts`, add:
   ```kotlin
   dependencies {
       implementation(project(":besitos-offerwall"))
   }
   ```
4. **Layout Setup**: Open `app/src/main/res/layout/activity_main.xml` and ensure your button has the correct ID:

   ```xml
   <Button
       android:id="@+id/btnOpenOffers"
       android:layout_width="wrap_content"
       android:layout_height="wrap_content"
       android:text="Open Offers" />
   ```

5. **Trigger the Offerwall**: Update your `MainActivity.kt`. It should look like this (standard template example):

   ```kotlin
   package com.yourpackage

   import android.os.Bundle
   import android.widget.Button // ✅ Add this
   import androidx.appcompat.app.AppCompatActivity
   import ai.besitos.offerwall.BesitosOfferwall // ✅ Add this
   import ai.besitos.offerwall.config.OfferwallConfig // ✅ Add this

   class MainActivity : AppCompatActivity() {
       override fun onCreate(savedInstanceState: Bundle?) {
           super.onCreate(savedInstanceState)
           setContentView(R.layout.activity_main)

           // ✅ Find the button and show the offerwall
           findViewById<Button>(R.id.btnOpenOffers).setOnClickListener {
               val config = OfferwallConfig(
                   partnerId = "CwI606dZ",
                   userId = "test_user_001"
               )
               BesitosOfferwall.show(this, config)
           }
       }
   }
   ```

6. **Sync Gradle**: Click "Sync Now" in Android Studio.
