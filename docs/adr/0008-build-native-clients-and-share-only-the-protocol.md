# 双端使用原生客户端，只共享控制协议

Android 客户端使用 Kotlin 与 Jetpack Compose，macOS 客户端使用 Swift 与 SwiftUI，并在系统接口需要时桥接 AppKit 或 Objective-C。两端不通过 Flutter、React Native、Electron 或共享业务运行时复用代码，只共享版本化的 BLE 协议定义与测试向量，以重复实现部分协调逻辑为代价换取可靠的后台运行、系统权限、蓝牙和音频集成。
