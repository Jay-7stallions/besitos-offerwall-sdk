# Besitos Offerwall Mobile SDK

Welcome to the **Besitos Offerwall Mobile SDK**, a cross-platform solution for integrating high-conversion offerwalls into your mobile applications.

## 🚀 Quick Start Guide

### 📱 React Native & Expo (Recommended)

This is the easiest way to test the SDK on both Android and iOS inside an Expo 54+ environment.

1. **Navigate to the example directory:**
   ```bash
   cd react-native/example
   ```
2. **Install dependencies:**
   ```bash
   npm install
   ```
3. **Run on Android:**
   ```bash
   npx expo run:android
   ```
4. **Build APK (Local):**
   ```bash
   npm run build:apk
   ```

---

### 🤖 Core Android (Native)

Traditional Kotlin-based integration for native Android apps.

1. **Open the project:**
   Open the `android` folder in **Android Studio**.
2. **Run the Sample App:**
   Select the `sample` module and click **Run**.
3. **Terminal Build:**
   ```bash
   cd android
   ./gradlew :sample:assembleDebug
   ```
   _APK will be at: `android/sample/build/outputs/apk/debug/sample-debug.apk`_

---

### 🍎 Core iOS (Native)

Swift-based integration for native iOS apps.

1. **Open the project:**
   Open `ios/BesitosOfferwall.xcworkspace` (if using CocoaPods) or add the `ios` folder as a **Swift Package**.
2. **Run on Mac:**
   Requires macOS and Xcode to compile.

---

## 🛠️ SDK Configuration

The SDK uses a unified configuration model across all platforms:

| Parameter    | Type    | Required | Description                                       |
| :----------- | :------ | :------- | :------------------------------------------------ |
| `partnerId`  | String  | Yes      | Your unique partner identifier (e.g., `CwI606dZ`) |
| `userId`     | String  | Yes      | Unique ID for the current user                    |
| `subId`      | String  | No       | Custom tracking parameter                         |
| `hideHeader` | Boolean | No       | Hide the offerwall header                         |
| `hideFooter` | Boolean | No       | Hide the offerwall footer                         |

## 📦 Project Structure

```text
/android        - Core Kotlin SDK + Native Sample App
/ios            - Core Swift SDK
/react-native   - React Native Bridge
  /example      - Expo 54 Example Application
```
