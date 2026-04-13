# Android Studio Integration Guide - Besitos Offerwall SDK

> [!TIP]
> **Quick Tip:** This guide uses `com.besitos.example` as the sample package name. When following these steps, simply replace `com.besitos.example` with your actual project package name.

---

## Step 1 — Create a New Project

1. Open **Android Studio**.
2. Click **"New Project"**.
3. Select **"Empty Views Activity"** and click **Next**.
4. Fill in details:
   - **Name:** `BesitosExample`
   - **Package name:** `com.besitos.example`
   - **Minimum SDK:** `API 21` (Android 5.0) or higher.
   - **Language:** `Kotlin`.
5. Click **Finish** and wait for the Gradle sync.

---

## Step 2 — Create the Package Folder

1. In the Project panel (top left), navigate to:
   `app/src/main/java/com/besitos/example/`
2. **Right-click** the `example` folder.
3. Select **New → Package** and name it `besitos`.

---

## Step 3 — Copy SDK Source Files

1. Locate the SDK folder on your computer:
   `besitos-offerwall-sdk/android/besitos-offerwall/src/main/kotlin/ai/besitos/offerwall/`
2. **Copy the entire `offerwall` folder** from that location.
3. **Paste it** into your project's new `besitos` package.

Your final structure should look like this:
```
app/src/main/java/com/besitos/example/besitos/
└── offerwall/
    ├── BesitosOfferwall.kt
    ├── SdkConfig.kt
    ├── ...
    └── webview/
        └── OfferwallActivity.kt
```

> [!IMPORTANT]
> **Fix Package Names:** Open every `.kt` file you just pasted. Change the first line (`package ...`) to match your project. 
> 
> Example: Change `package ai.besitos.offerwall` to `package com.besitos.example.besitos.offerwall`.

---

## Step 4 — Add Dependencies

Open `app/build.gradle.kts` (Module: app) and add these to your `dependencies` block:

```kotlin
dependencies {
    implementation("androidx.webkit:webkit:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
```
Click **"Sync Now"**.

---

## Step 5 — Update Themes

1. Open `app/src/main/res/values/themes.xml`.
2. **Append** this style at the bottom:

```xml
<style name="BesitosTheme.Offerwall" parent="Theme.AppCompat.Light.NoActionBar">
    <item name="android:windowFullscreen">false</item>
    <item name="android:windowLayoutInDisplayCutoutMode" tools:targetApi="o_mr1">shortEdges</item>
    <item name="android:statusBarColor">@android:color/transparent</item>
    <item name="android:navigationBarColor">@android:color/transparent</item>
    <item name="android:windowDrawsSystemBarBackgrounds">true</item>
</style>
```

---

## Step 6 — Update AndroidManifest.xml

Open `app/src/main/AndroidManifest.xml`. You must add the Internet permission and the SDK activity.

> [!CAUTION]
> **Placement is Critical:** The `<uses-permission>` tag must be **INSIDE** the `<manifest>` tag but **OUTSIDE** the `<application>` tag.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <!-- ✅ 1. ADD PERMISSION HERE (Inside manifest, above application) -->
    <uses-permission android:name="android.permission.INTERNET" />

    <application
        ...
        android:theme="@style/Theme.BesitosExample"> <!-- ⚠️ Use your actual theme name here -->

        <activity android:name=".MainActivity" ... />

        <!-- ✅ 2. ADD SDK ACTIVITY HERE -->
        <activity
            android:name=".besitos.offerwall.webview.OfferwallActivity"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar" />

    </application>
</manifest>
```

---

## Step 7 — Launch the Offerwall

In your `MainActivity.kt`, add a button listener to show the offerwall:

```kotlin
package com.besitos.example

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.besitos.example.besitos.offerwall.BesitosOfferwall
import com.besitos.example.besitos.offerwall.config.OfferwallConfig

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<Button>(R.id.btnOpenOffers).setOnClickListener {
            val config = OfferwallConfig(
                partnerId = "your_partner_id",
                userId = "user_123"
            )
            BesitosOfferwall.show(this, config)
        }
    }
}
```

---

## Troubleshooting

- **ERR_CACHE_MISS**: Check that `<uses-permission>` is outside the `<application>` tag.
- **Resource Not Found**: Check that `android:theme` in `<application>` matches your theme name in `themes.xml`.
- **White Screen**: Ensure the device has internet and JavaScript is enabled in `OfferwallActivity.kt`.
