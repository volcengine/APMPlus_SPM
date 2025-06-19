
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
            targets: [ "APMPlus_Public", "APMPlus_Above", "APMPlus_Core", "APMPlus_HMDLite", "APMPlus_Zyone" ]
        ),
        .library(
            name: "APMPlus_Core",
            targets: [ "APMPlus_Core", "APMPlus_HMDLite" ]
        ),
        .library(
            name: "APMPlus_HMD",
            targets: [ "APMPlus_HMD", "APMPlus_Core", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_HMDLite",
            targets: [ "APMPlus_HMDLite" ]
        ),
        .library(
            name: "APMPlus_Crash",
            targets: [ "APMPlus_Crash", "APMPlus_SessionTracker", "APMPlus_Public", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_WatchDog",
            targets: [ "APMPlus_WatchDog", "APMPlus_Core", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_OOM",
            targets: [ "APMPlus_OOM", "APMPlus_SessionTracker", "APMPlus_Public", "APMPlus_Above", "APMPlus_Core", "APMPlus_WatchDog", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Crash" ]
        ),
        .library(
            name: "APMPlus_UserException",
            targets: [ "APMPlus_UserException", "APMPlus_Core", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_LAG",
            targets: [ "APMPlus_LAG", "APMPlus_Core", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_Hybrid",
            targets: [ "APMPlus_Hybrid", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_UITrackers",
            targets: [ "APMPlus_UITrackers", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_Monitors",
            targets: [ "APMPlus_Monitors", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_UITrackers", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_HybridPro",
            targets: [ "APMPlus_HybridPro", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_MemoryGraph",
            targets: [ "APMPlus_MemoryGraph", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_CrashProtector",
            targets: [ "APMPlus_CrashProtector", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Crash", "APMPlus_Public", "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_EventMonitor",
            targets: [ "APMPlus_EventMonitor", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_Flutter",
            targets: [ "APMPlus_Flutter", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_EventMonitor", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_CN",
            targets: [ "APMPlus_CN", "APMPlus_Core", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_Global",
            targets: [ "APMPlus_Global", "APMPlus_Core", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_BytePlus",
            targets: [ "APMPlus_BytePlus", "APMPlus_Core", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_SessionTracker",
            targets: [ "APMPlus_SessionTracker", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_APMLog",
            targets: [ "APMPlus_APMLog", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public", "APMPlus_CloudCommand" ]
        ),
        .library(
            name: "APMPlus_Network",
            targets: [ "APMPlus_Network", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public", "APMPlus_NetworkBasic" ]
        ),
        .library(
            name: "APMPlus_NetworkPro",
            targets: [ "APMPlus_NetworkPro", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public", "APMPlus_NetworkBasic" ]
        ),
        .library(
            name: "APMPlus_NetworkBasic",
            targets: [ "APMPlus_NetworkBasic", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_CPUException",
            targets: [ "APMPlus_CPUException", "APMPlus_Core", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_MetricKit",
            targets: [ "APMPlus_MetricKit", "APMPlus_Core", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
        ),
        .library(
            name: "APMPlus_Zombie",
            targets: [ "APMPlus_Zombie", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Crash", "APMPlus_Public", "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_BootingProtectLite",
            targets: [ "APMPlus_BootingProtectLite", "APMPlus_Core", "APMPlus_WatchDog", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Crash", "APMPlus_Public", "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_BootingProtect",
            targets: [ "APMPlus_BootingProtect", "APMPlus_Core", "APMPlus_WatchDog", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_BootingProtectLite", "APMPlus_Crash", "APMPlus_Public", "APMPlus_Above", "APMPlus_OOM" ]
        ),
        .library(
            name: "APMPlus_Disk",
            targets: [ "APMPlus_Disk", "APMPlus_Core", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_UITrackers", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public", "APMPlus_Monitors" ]
        ),
        .library(
            name: "APMPlus_GWPASan",
            targets: [ "APMPlus_GWPASan", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Crash", "APMPlus_Public", "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_Coredump",
            targets: [ "APMPlus_Coredump", "APMPlus_Core", "APMPlus_Zip", "APMPlus_HMD", "APMPlus_SessionTracker", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Crash", "APMPlus_Public", "APMPlus_Above" ]
        ),
        .library(
            name: "APMPlus_CloudCommand",
            targets: [ "APMPlus_CloudCommand", "APMPlus_Core", "APMPlus_HMD", "APMPlus_dependency", "APMPlus_HMDLite", "APMPlus_Zyone", "APMPlus_Above", "APMPlus_Public" ]
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
                .process("APMInsightHybridPro.bundle"),
                .process("APMInsightCore.bundle"),
                .process("APMInsightCrash.bundle"),
                .process("APMInsightHybrid.bundle")
            ],
            publicHeadersPath: "",
            linkerSettings: [
                .linkedFramework("MetricKit"),
                .linkedFramework("WebKit"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("Security"),
                .linkedFramework("CoreFoundation"),
                .linkedLibrary("c++abi"),
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("c++"),
                .linkedLibrary("resolv")
            ]
        ),
    ]
)
