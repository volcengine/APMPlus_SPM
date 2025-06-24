# APMPlus_iOS_SPM

This is a SPM version for [APMPlus](https://www.volcengine.com/docs/6431/68850).

## Usage

### 1. Open Package Dependencies in Xcode，and click the Add button.
![](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_06242b259d0d74e231cdefc657af49d4.png)

### 2. Find the git address of APMPlus SPM version from [project address](https://github.com/volcengine/APMPlus_SPM): git@github.com:volcengine/APMPlus_SPM.git. Then, retrieve and add the required library in Xcode.
![](https://portal.volccdn.com/obj/volcfe/cloud-universal-doc/upload_54a6f639e52505fe80bda8850c0f995c.png)


> [!NOTE]   
> In order to prevent library name conflicts in SPM, the APMPlus_ prefix is ​​added to the subspec name of CocoaPods. For example, if we want to know the function of the library named APMPlus_Disk, we can remove the prefix and search for the function description of Disk in [this document](https://www.volcengine.com/docs/6431/68850#f391c95d).

### 3. Add -ObjC, -Xlinker options to the OTHER_LDFLAGS build setting.
> [!WARNING]
> Without the options above, there might be linking errors or runtime errors in your project.

### 4. Access method
The access method of this solution is basically the same as [the access method of CocoaPods](https://www.volcengine.com/docs/6431/68850#878f6178). When importing the header file, just change it to #import <APMPlus_Public/APMPlus_Public.h>.

## Change Log
> Note
> SPM is available from version 5.2.1
https://github.com/volcengine/APMInsight_iOS/blob/master/README.md
