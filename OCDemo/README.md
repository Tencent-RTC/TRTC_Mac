# TRTC MacOS Demo (Objective-C)

This open source example Demo mainly demonstrates how to quickly implement some basic functions of audio and video scenarios based on [TRTC Real-time Audio and Video SDK](https://cloud.tencent.com/document/product/647/32689).

The following scenarios are included in this sample project:

- video call
- Video interactive live broadcast

## Environmental requirements
- Xcode 10.2 and above

## Prerequisites
You have [registered Tencent Cloud](https://cloud.tencent.com/document/product/378/17985) account and completed [real-name authentication](https://cloud.tencent.com/document/product/378 /3629).

## Steps

### Step 1: Create a new application
1. Log in to the real-time audio and video console, select [Development Assistance] > [Quick Run Demo] (https://console.cloud.tencent.com/trtc/quickstart)].
2. Click [Start Now], enter the application name, such as `TestTRTC`, and click [Create Application].
3. Click [I have downloaded] and you will see your SDKAppID and key displayed on the page.

### Step 2: Configure the AppID and key in the Demo project
1. Open the [GenerateTestUserSig.h](TRTCDemo/TRTC/GenerateTestUserSig.h) file in the project
2. Configure the relevant parameters in the `GenerateTestUserSig.h` file:
   <ul><li>SDKAPPID: The default is 0, please set it to the actual SDKAppID. </li>
   <li>SDKSECRETKEY: The default is an empty string, please set it to the actual key information. </li></ul>
     <img src="https://main.qcloudimg.com/raw/15d986c5f4bc340e555630a070b90d63.png">
3. Return to the real-time audio and video console and click [Paste Complete, Next].
4. Click [Close the guide and enter the console management application].

>! The solution to generate UserSig mentioned in this article is to configure SDKSECRETKEY in the client code. In this method, SDKSECRETKEY can easily be decompiled and reverse cracked. Once your key is leaked, the attacker can steal your Tencent Cloud traffic. Therefore **This method is only suitable for local run-through Demo and functional debugging**.
>The correct way to issue UserSig is to integrate the UserSig calculation code into your server and provide an App-oriented interface. When UserSig is needed, your App initiates a request to the business server to obtain the dynamic UserSig. For more details, please see [Server-side generation of UserSig](https://cloud.tencent.com/document/product/647/17275#Server).

## 5. Compile and run
In the terminal window, cd to the directory where the Podfile is located and execute the following command to install TRTC SDK
```
pod install
```
Or use the following command to update the local library version:
```
pod update
```
Use XCode (version 9.0 or above) to open the TRTCDemo.xcworkspace project in the source directory, compile and run the Demo project.