# Besitos Offerwall SDK

Embed the Besitos Offerwall inside your iOS, Android, or React Native app with a few lines of code.

---

## Requirements

| Platform     | Minimum Version      |
| :----------- | :------------------- |
| Android      | API 21 (Android 5.0) |
| iOS          | iOS 12               |
| React Native | 0.73+                |

---

## Installation

### Android

**Step 1.** Add the JitPack repository to your `settings.gradle`:

```gradle
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }
}
```

**Step 2.** Add the SDK to your app `build.gradle`:

```gradle
dependencies {
    implementation 'com.github.Jay-7stallions:besitos-offerwall-sdk:v1.0.0-beta'
}
```

**Step 3.** Add internet permission to your `AndroidManifest.xml` (place it **above** the `<application>` tag):

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

### iOS

**Option A — Swift Package Manager (Recommended)**

In Xcode: **File → Add Package Dependencies** and paste:

```
https://github.com/Jay-7stallions/besitos-offerwall-sdk
```

**Option B — CocoaPods**

Add to your `Podfile`:

```ruby
pod 'BesitosOfferwall', :git => 'https://github.com/Jay-7stallions/besitos-offerwall-sdk.git', :branch => 'main'
```

Then run:

```bash
pod install
```

---

### React Native / Expo

```bash
npm install https://github.com/Jay-7stallions/besitos-offerwall-sdk
```

---

## Usage

### Android

```kotlin
import ai.besitos.offerwall.BesitosOfferwall
import ai.besitos.offerwall.config.OfferwallConfig

val config = OfferwallConfig(
    partnerId = "your_partner_id",
    userId = "user_123"
)

BesitosOfferwall.show(context = this, config = config)
```

With error handling:

```kotlin
try {
    BesitosOfferwall.show(context = this, config = config)
} catch (e: IllegalArgumentException) {
    Log.e("SDK", e.message ?: "Invalid config")
}
```

---

### iOS

```swift
import BesitosOfferwall

let config = OfferwallConfig(
    partnerId: "your_partner_id",
    userId: "user_123"
)

try? BesitosOfferwall.show(from: self, config: config)
```

With error handling:

```swift
do {
    try BesitosOfferwall.show(from: self, config: config)
} catch BesitosOfferwallError.invalidConfig(let reason) {
    print("Config error: \(reason)")
} catch {
    print("SDK error: \(error)")
}
```

---

### React Native / Expo

```tsx
import { BesitosOfferwall } from "@besitos/offerwall-sdk";

// One line — opens the native Offerwall screen.
BesitosOfferwall.show({
  partnerId: "your_partner_id",
  userId: "user_123",
});
```

With optional parameters:

```tsx
BesitosOfferwall.show({
  partnerId: "your_partner_id",
  userId: "user_123",
  subId: "sub_001",
  hideHeader: true,
  hideFooter: true,
});
```

````

---

## Configuration

| Parameter | Type | Required | Description |
| :--- | :--- | :---: | :--- |
| `partnerId` | String | ✅ | Your unique partner identifier |
| `userId` | String | ✅ | Unique ID for the current user |
| `subId` | String | ❌ | Sub-publisher / tracking ID |
| `deviceId` | String | ❌ | Hardware device identifier |
| `idfa` | String | ❌ | iOS Advertising ID (requires ATT permission) |
| `gdfa` | String | ❌ | Android Advertising ID |
| `info` | String | ❌ | Additional metadata string |
| `hideHeader` | Boolean | ❌ | Hide the offerwall header (`false` by default) |
| `hideFooter` | Boolean | ❌ | Hide the offerwall footer (`false` by default) |

**Allowed characters** for all string parameters: `A–Z`, `a–z`, `0–9`, `-`, `_`.

---

## Troubleshooting

| Problem | Solution |
| :--- | :--- |
| Android: crash on launch | Ensure `minSdk` is 21 or higher |
| Android: `ERR_CACHE_MISS` | Ensure internet permission is **outside** the `<application>` tag |
| Android: white/blank screen | Confirm internet permission is in `AndroidManifest.xml` |
| iOS: white screen | Verify the device has network access |
| iOS: `invalidConfig` error | Check that `partnerId` and `userId` use only `A-Z a-z 0-9 - _` |
| React Native: module not found | Run `npm install` and `npx expo prebuild` |
| React Native: blank WebView on Android | Ensure `react-native-webview` is linked (`npx expo prebuild`) |

---

## Integration Guides

For detailed, step-by-step instructions for each platform, see:

- [Android Studio Setup Guide](ANDROID_SETUP.md)
- [React Native / Expo Guide](#react-native--expo)
> [!TIP]
> **New to Android Dev?** Check out our [Full Android Studio Step-by-Step Guide (BesitosExample)](ANDROID_SETUP.md) for a beginner-friendly walkthrough.

---

## Manual Integration

If you don't want to use Git or linking, you can manually copy the source files into your project:

### 1. Android Manual

A fresh Android developer can integrate the SDK by copying source files directly into their project.

**Step 1 — Clone the SDK repo** (if you haven't already):

```bash
git clone https://github.com/Jay-7stallions/besitos-offerwall-sdk.git
```

**Step 2 — Copy the SDK source files into your project**

In your Android project, open `app/src/main/kotlin/` (or `java/`). Create the folder structure below and copy each file from the SDK repo:

```
YOUR_PROJECT/
└── app/src/main/kotlin/
    └── ai/besitos/offerwall/          ← create this folder
        ├── BesitosOfferwall.kt        ← copy from android/besitos-offerwall/src/main/kotlin/ai/besitos/offerwall/
        ├── SdkConfig.kt               ← copy from android/besitos-offerwall/src/main/kotlin/ai/besitos/offerwall/
        ├── config/
        │   └── OfferwallConfig.kt     ← copy from .../config/
        ├── url/
        │   └── UrlBuilder.kt          ← copy from .../url/
        ├── validation/
        │   └── ValidationUtil.kt      ← copy from .../validation/
        └── webview/
            └── OfferwallActivity.kt   ← copy from .../webview/
```

**Step 3 — Copy the theme resource file**

In your project, open `app/src/main/res/values/`. Copy:

```
android/besitos-offerwall/src/main/res/values/themes.xml
→ app/src/main/res/values/besitos_themes.xml
```

> Rename it so it does not conflict with your existing `themes.xml`.

**Step 4 — Add required dependencies**

In your `app/build.gradle` (or `build.gradle.kts`), add:

```kotlin
dependencies {
    implementation("androidx.webkit:webkit:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
```

Click **Sync Now** in Android Studio.

**Step 5 — Update `AndroidManifest.xml`**

Open `app/src/main/AndroidManifest.xml`. **Merge** these into your existing file:

1. Add inside the `<manifest>` tag:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

2. Add inside the `<application>` tag, below your other activities:

```xml
<activity
    android:name="ai.besitos.offerwall.webview.OfferwallActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar" />
```

**Step 6 — Use the SDK in your Activity**

```kotlin
import ai.besitos.offerwall.BesitosOfferwall
import ai.besitos.offerwall.config.OfferwallConfig

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val config = OfferwallConfig(
            partnerId = "your_partner_id",
            userId = "user_123"
        )

        findViewById<Button>(R.id.btnOpenOffers).setOnClickListener {
            BesitosOfferwall.show(this, config)
        }
    }
}
```

### 2. iOS Manual Copy

1. Drag the folder `ios/Sources/BesitosOfferwall` directly into your Xcode project.
2. Ensure "Copy items if needed" is checked.
3. Import with `#import "BesitosOfferwall-Swift.h"` (if using ObjC) or `import BesitosOfferwall` (if using Swift).

### 3. React Native Manual

Since the SDK uses a **native bridge**, you need to copy both the JS layer and the native bridge files:

**Step 1 — JS Layer:**
Copy `react-native/src/index.ts` into your project (e.g., as `./vendor/besitos/index.ts`) and update imports:

```ts
import { BesitosOfferwall } from "./vendor/besitos";
```

**Step 2 — Android Bridge:**

1. Copy `react-native/android/src/main/kotlin/ai/besitos/offerwall/rn/` into your app's `src/main/kotlin/` directory.
2. Also copy `android/besitos-offerwall/src/main/kotlin/ai` into `src/main/kotlin/` (the core SDK).
3. Add to your `build.gradle`:
   ```kotlin
   implementation("androidx.webkit:webkit:1.11.0")
   implementation("androidx.constraintlayout:constraintlayout:2.1.4")
   implementation("androidx.appcompat:appcompat:1.6.1")
   ```
4. Register the package in your `MainApplication.kt`:
   ```kotlin
   import ai.besitos.offerwall.rn.OfferwallPackage
   // inside getPackages():
   packages.add(OfferwallPackage())
   ```
5. Register the Activity in `AndroidManifest.xml`:
   ```xml
   <activity
       android:name="ai.besitos.offerwall.webview.OfferwallActivity"
       android:screenOrientation="portrait"
       android:theme="@style/Theme.AppCompat.Light.NoActionBar" />
   ```

**Step 3 — iOS Bridge:**

1. Copy `react-native/ios/BesitosOfferwallModule.swift` and `react-native/ios/BesitosOfferwallModule.m` into your iOS project.
2. Also drag `ios/Sources/BesitosOfferwall` into your Xcode project.
3. Run `pod install`.

### 4. Expo Manual

Expo has two workflows. Follow the one that matches your project:

---

**Expo Bare Workflow** (`npx expo run:android` / `npx expo run:ios`)

This is the recommended path for testing the SDK in Expo.

1. Install the package:

   ```bash
   npm install https://github.com/Jay-7stallions/besitos-offerwall-sdk --force
   ```

2. Delete the cached native folder and run a full prebuild so autolinking picks up the SDK:

   ```bash
   rm -rf android
   npx expo run:android
   ```

3. If the module is still not linked after prebuild, open the generated `android/app/src/main/java/.../MainApplication.kt` and add the package manually:

   ```kotlin
   import ai.besitos.offerwall.rn.OfferwallPackage

   // Inside getPackages():
   packages.add(OfferwallPackage())
   ```

4. Rebuild:
   ```bash
   npx expo run:android
   ```

---

**Expo Managed Workflow** (`npx expo start` only — no native folders)

The SDK uses native code and **cannot run in Expo Go**. To use it in a managed project, you must first eject to bare:

```bash
npx expo prebuild
```

Then follow the **Expo Bare Workflow** steps above.

---

## License

MIT
