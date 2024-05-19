#TRTC Lite Version Demo

This open source example Demo mainly demonstrates how to quickly implement some basic functions of audio and video scenarios based on [TRTC Real-time Audio and Video SDK](https://cloud.tencent.com/document/product/647/32689).

The following scenarios are included in this sample project:

- video call
- Video interactive live broadcast

## Environmental requirements
- Xcode 10.2 and above

## Prerequisites
You have [registered Tencent Cloud](https://cloud.tencent.com/document/product/378/17985) account and completed [real-name authentication](https://cloud.tencent.com/document/product/378 /3629).

## Steps
<span id="step1"></span>
### Step 1: Create a new application
1. Log in to the real-time audio and video console, select [Development Assistance] > [Quick Run Demo] (https://console.cloud.tencent.com/trtc/quickstart)].
2. Click [Start Now], enter the application name, such as `TestTRTC`, and click [Create Application].

<span id="step2"></span>
### Step 2: Download SDK and Demo source code
1. Move the mouse to the corresponding card and download the relevant SDK and supporting Demo source code.
   Click [[Github](https://github.com/tencentyun/TRTCSDK/tree/master/Mac)] to jump to Github (or click [[ZIP](https://liteav.sdk.qcloud.com /download/latest/TXLiteAVSDK_TRTC_Mac_latest.tar.bz2?_ga=1.195966252.185644906.1567570704)])
   ![](https://main.qcloudimg.com/raw/3b6d17adff2348fa2363cd608e2e3802.png)

2. After the download is completed, return to the real-time audio and video console and click [I have downloaded, Next] to view the SDKAPPID and key information.

<span id="step3"></span>
### Step 3: Configure the AppID and key in the Demo project
1. Open the [GenerateTestUserSig.h](debug/GenerateTestUserSig.h) file
2. Configure the relevant parameters in the `GenerateTestUserSig.h` file:
   <ul><li>SDKAPPID: The default is 0, please set it to the actual SDKAPPID. </li>
   <li>SDKSECRETKEY: The default is an empty string, please set it to the actual key information. </li></ul>
     <img src="https://main.qcloudimg.com/raw/15d986c5f4bc340e555630a070b90d63.png">
3. Return to the real-time audio and video console and click [Paste Complete, Next].
4. Click [Close the guide and enter the console management application].

>! The solution to generate UserSig mentioned in this article is to configure SDKSECRETKEY in the client code. In this method, SDKSECRETKEY can easily be decompiled and reverse cracked. Once your key is leaked, the attacker can steal your Tencent Cloud traffic. Therefore **This method is only suitable for local run-through Demo and functional debugging**.
>The correct way to issue UserSig is to integrate the UserSig calculation code into your server and provide an App-oriented interface. When UserSig is needed, your App initiates a request to the business server to obtain the dynamic UserSig. For more details, please see [Server-side generation of UserSig](https://cloud.tencent.com/document/product/647/17275#Server).

### Step 4: Compile and run
Use XCode (version 10.2 and above) to open the TRTCSimpleDemo.xcworkspace project in the source directory, compile and run the Demo project.
