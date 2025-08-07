// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RangersAPM",
    platforms: [ .iOS(.v12)],
    products: [
        .library(
            name: "APMPlus_Above",
            targets: [ "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_Zyone",
            targets: [ "APMPlus_Zyone" ]
        ),
        .library(
            name: "APMPlus_Public",
            targets: [ "APMPlus_Public", "APMPlus_Above", "APMPlus_HMDLite", "APMPlus_Core", "APMPlus_Zyone" ]
        ),
        .library(
            name: "APMPlus_Core",
            targets: [ "APMPlus_Core", "APMPlus_HMDLite" ]
        ),
        .library(
            name: "APMPlus_HMD",
            targets: [ "APMPlus_HMD", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_HMDLite",
            targets: [ "APMPlus_HMDLite" ]
        ),
        .library(
            name: "APMPlus_Crash",
            targets: [ "APMPlus_Crash", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Zyone", "APMPlus_HMD", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_WatchDog",
            targets: [ "APMPlus_WatchDog", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_OOM",
            targets: [ "APMPlus_OOM", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_WatchDog", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Crash", "APMPlus_Zyone", "APMPlus_HMD", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_UserException",
            targets: [ "APMPlus_UserException", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_LAG",
            targets: [ "APMPlus_LAG", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Hybrid",
            targets: [ "APMPlus_Hybrid", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_UITrackers",
            targets: [ "APMPlus_UITrackers", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Monitors",
            targets: [ "APMPlus_Monitors", "APMPlus_UITrackers", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_HybridPro",
            targets: [ "APMPlus_HybridPro", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_MemoryGraph",
            targets: [ "APMPlus_MemoryGraph", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_CrashProtector",
            targets: [ "APMPlus_CrashProtector", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_HMD", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_EventMonitor",
            targets: [ "APMPlus_EventMonitor", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Flutter",
            targets: [ "APMPlus_Flutter", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core", "APMPlus_EventMonitor" ]
        ),
        .library(
            name: "APMPlus_CN",
            targets: [ "APMPlus_CN", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Global",
            targets: [ "APMPlus_Global", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_BytePlus",
            targets: [ "APMPlus_BytePlus", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_SessionTracker",
            targets: [ "APMPlus_SessionTracker", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_APMLog",
            targets: [ "APMPlus_APMLog", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_CloudCommand", "APMPlus_HMD", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Network",
            targets: [ "APMPlus_Network", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_NetworkBasic", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_NetworkPro",
            targets: [ "APMPlus_NetworkPro", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_NetworkBasic", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_NetworkBasic",
            targets: [ "APMPlus_NetworkBasic", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_CPUException",
            targets: [ "APMPlus_CPUException", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_MetricKit",
            targets: [ "APMPlus_MetricKit", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_SessionTracker", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Zombie",
            targets: [ "APMPlus_Zombie", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_BootingProtectLite",
            targets: [ "APMPlus_BootingProtectLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_Zip", "APMPlus_WatchDog", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_BootingProtect",
            targets: [ "APMPlus_BootingProtect", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_Zip", "APMPlus_WatchDog", "APMPlus_HMDLite", "APMPlus_BootingProtectLite", "APMPlus_Public", "APMPlus_OOM", "APMPlus_dependency", "APMPlus_Core", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_Disk",
            targets: [ "APMPlus_Disk", "APMPlus_UITrackers", "APMPlus_Zyone", "APMPlus_Monitors", "APMPlus_SessionTracker", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_GWPASan",
            targets: [ "APMPlus_GWPASan", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_Coredump",
            targets: [ "APMPlus_Coredump", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_Zip", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_CloudCommand",
            targets: [ "APMPlus_CloudCommand", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_HMD", "APMPlus_HMDLite", "APMPlus_Public", "APMPlus_dependency", "APMPlus_Core" ]
        ),
        .library(
            name: "APMPlus_Zip",
            targets: [ "APMPlus_Zip" ]
        ),
        .library(
            name: "APMPlus_dependency", 
            targets: [ "APMPlus_dependency" ]
        )
    
    ],
    targets: [
        .binaryTarget(
            name: "APMPlus_Above",
            path: "./Frameworks/APMPlus_Above.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Zyone",
            path: "./Frameworks/APMPlus_Zyone.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Public",
            path: "./Frameworks/APMPlus_Public.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Core",
            path: "./Frameworks/APMPlus_Core.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_HMD",
            path: "./Frameworks/APMPlus_HMD.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_HMDLite",
            path: "./Frameworks/APMPlus_HMDLite.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Crash",
            path: "./Frameworks/APMPlus_Crash.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_WatchDog",
            path: "./Frameworks/APMPlus_WatchDog.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_OOM",
            path: "./Frameworks/APMPlus_OOM.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_UserException",
            path: "./Frameworks/APMPlus_UserException.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_LAG",
            path: "./Frameworks/APMPlus_LAG.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Hybrid",
            path: "./Frameworks/APMPlus_Hybrid.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_UITrackers",
            path: "./Frameworks/APMPlus_UITrackers.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Monitors",
            path: "./Frameworks/APMPlus_Monitors.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_HybridPro",
            path: "./Frameworks/APMPlus_HybridPro.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_MemoryGraph",
            path: "./Frameworks/APMPlus_MemoryGraph.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_CrashProtector",
            path: "./Frameworks/APMPlus_CrashProtector.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_EventMonitor",
            path: "./Frameworks/APMPlus_EventMonitor.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Flutter",
            path: "./Frameworks/APMPlus_Flutter.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_CN",
            path: "./Frameworks/APMPlus_CN.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Global",
            path: "./Frameworks/APMPlus_Global.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_BytePlus",
            path: "./Frameworks/APMPlus_BytePlus.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_SessionTracker",
            path: "./Frameworks/APMPlus_SessionTracker.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_APMLog",
            path: "./Frameworks/APMPlus_APMLog.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Network",
            path: "./Frameworks/APMPlus_Network.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_NetworkPro",
            path: "./Frameworks/APMPlus_NetworkPro.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_NetworkBasic",
            path: "./Frameworks/APMPlus_NetworkBasic.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_CPUException",
            path: "./Frameworks/APMPlus_CPUException.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_MetricKit",
            path: "./Frameworks/APMPlus_MetricKit.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Zombie",
            path: "./Frameworks/APMPlus_Zombie.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_BootingProtectLite",
            path: "./Frameworks/APMPlus_BootingProtectLite.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_BootingProtect",
            path: "./Frameworks/APMPlus_BootingProtect.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Disk",
            path: "./Frameworks/APMPlus_Disk.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_GWPASan",
            path: "./Frameworks/APMPlus_GWPASan.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Coredump",
            path: "./Frameworks/APMPlus_Coredump.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_CloudCommand",
            path: "./Frameworks/APMPlus_CloudCommand.xcframework"
        ),
        .binaryTarget(
            name: "APMPlus_Zip",
            path: "./Frameworks/APMPlus_Zip.xcframework"
        ),
        .target(
            name: "APMPlus_dependency",
            dependencies: [],
            path: "APMPlus",
            exclude: [
                "APMPlus_DSYMUploader_v3.sh"
            ],
            resources: [
                .copy("webpro_trigger.js"),
                .copy("APMInsightInfo.plist"),
                .copy("PrivacyInfo.xcprivacy"),
                .copy("APMInsightSDKAddressRange.plist"),
                .copy("webviewMonitor.strings"),
                .copy("js_hybrid"),
                .copy("js_bridge")
            ],
            publicHeadersPath: "",
            linkerSettings: [
                .linkedFramework("MetricKit"),
                .linkedFramework("WebKit"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("Security"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("SystemConfiguration"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedLibrary("c++abi"),
                .linkedLibrary("resolv")
            ]
        ),
    ]
)
