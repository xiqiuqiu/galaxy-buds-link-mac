# Mac 正式版本直接使用系统蓝牙与音频框架

Mac 菜单栏助手直接使用 `IOBluetooth` 建立和关闭 Buds2 Pro 的经典蓝牙连接，并通过 Core Audio 验证及设置系统音频路由；正式功能不依赖 `blueutil`、Homebrew 或外部命令。开发阶段可以使用 `blueutil` 辅助诊断，以额外的 Swift 与 Objective-C 互操作成本换取可控的分发、错误处理和运行环境。
