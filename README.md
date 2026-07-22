# Galaxy Buds Link

Galaxy Buds Link 的最小双端原生骨架：Android 使用 Kotlin 与 Jetpack Compose，macOS 使用 Swift 与 SwiftUI。两端启动后均显示 `设备归属：未知`。

## 环境

- Xcode 26.6 或兼容的 Swift 6.2+ 工具链
- JDK 17+
- Android SDK Platform 36.1 与 Build Tools 36.0.0
- `ANDROID_HOME` 指向 Android SDK

## macOS

```bash
swift test
swift build --product GalaxyBudsLinkMac
swift run GalaxyBudsLinkMac
```

协调器行为测试通过 `SwitchCoordinator` 公开接缝发送强意图、设备锁定和平台结果，并用 `advanceTime(by:)` 推进可控时间。

## Android

```bash
./gradlew :androidApp:testDebugUnitTest :androidApp:assembleDebug
adb install -r android/build/outputs/apk/debug/androidApp-debug.apk
adb shell am start -n com.galaxybudslink.android/.MainActivity
```
