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

**Step 3.** Add internet permission to your `AndroidManifest.xml` if not already present:

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
| Android: white screen | Confirm internet permission is in `AndroidManifest.xml` |
| iOS: white screen | Verify the device has network access |
| iOS: `invalidConfig` error | Check that `partnerId` and `userId` use only `A-Z a-z 0-9 - _` |
| React Native: module not found | Run `npm install` and `npx expo prebuild` |
| React Native: blank WebView on Android | Ensure `react-native-webview` is linked (`npx expo prebuild`) |

---

## Local Development & Testing

If you are a contributor or reviewer and want to test the SDK locally without publishing to a registry:

### 1. Android (Contritube / Local Test)
If you want to test the SDK without using JitPack:

1. **Clone the repo** next to your project folder.
2. In your app's `settings.gradle.kts` (or `.gradle`), link the module:
   ```kotlin
   include(":besitos-offerwall")
   project(":besitos-offerwall").projectDir = File("../besitos-offerwall-sdk/android/besitos-offerwall")
````

3. In your app's `build.gradle.kts`, add the local project dependency:
   ```kotlin
   dependencies {
       implementation(project(":besitos-offerwall"))
   }
   ```
4. Sync Gradle and use `BesitosOfferwall.show(...)` as usual.

### 2. iOS (Local Pod)

In your test app's `Podfile`:

```ruby
pod 'BesitosOfferwall', :path => '../path/to/sdk/ios'
```

### 3. React Native (Local Link)

In your test app's root:

```bash
# This installs the local folder as a package
npm install ../path/to/sdk
```

---

## Manual Integration

If you don't want to use Git or linking, you can manually copy the source files into your project:

### 1. Android Manual

1. Copy the folder `android/besitos-offerwall/src/main/kotlin/ai` into your app's `src/main/kotlin/` directory.
2. Add these dependencies to your app's `build.gradle`:
   ```kotlin
   implementation("androidx.webkit:webkit:1.11.0")
   implementation("androidx.constraintlayout:constraintlayout:2.1.4")
   implementation("androidx.appcompat:appcompat:1.6.1")
   ```
3. Register the Activity in your `AndroidManifest.xml`:
   ```xml
   <activity
       android:name="ai.besitos.offerwall.webview.OfferwallActivity"
       android:screenOrientation="portrait"
       android:theme="@style/Theme.AppCompat.Light.NoActionBar" />
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
import { BesitosOfferwall } from './vendor/besitos';
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
