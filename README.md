# Besitos Offerwall SDK

Embed the Besitos Offerwall inside your iOS, Android, or React Native app with a few lines of code.

---

## Requirements

| Platform | Minimum Version |
| :--- | :--- |
| Android | API 21 (Android 5.0) |
| iOS | iOS 12 |
| React Native | 0.73+ |

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
npm install https://github.com/Jay-7stallions/besitos-offerwall-sdk#main:react-native
npm install react-native-webview react-native-safe-area-context
```

For Expo managed workflow, also run:

```bash
npx expo install react-native-webview react-native-safe-area-context
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
import React, { useState } from 'react';
import { Button, ActivityIndicator, Text } from 'react-native';
import { Offerwall } from '@besitos/offerwall-sdk';

export default function App() {
  const [open, setOpen] = useState(false);

  if (open) {
    return (
      <Offerwall.Root
        config={{
          partnerId: 'your_partner_id',
          userId: 'user_123',
        }}
        onFullClose={() => setOpen(false)}
      >
        <Offerwall.Content />
        <Offerwall.Loader>
          <ActivityIndicator size="large" />
        </Offerwall.Loader>
        <Offerwall.Error>
          {(err) => <Text>Error: {err.description}</Text>}
        </Offerwall.Error>
        <Offerwall.CloseButton />
      </Offerwall.Root>
    );
  }

  return <Button title="Open Offers" onPress={() => setOpen(true)} />;
}
```

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

## License

MIT
