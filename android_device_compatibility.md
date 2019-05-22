Android device compatibility
---
## 1. Overview
There are two types of compatibility: device compatibility and app compatibility. device compatibility is usually considered by hardware manufacture, Application developer will consider the app compatibility.

you can restrict your app's availability to devices through Google Play Store based on the following device characteristics.
- [Device features](https://developer.android.com/guide/practices/compatibility#Features)
  
  Android defines feature IDs for any hardware or software feature that may not be available on all devices, If necessary, you can prevent users from installing your app when their devices don't provide a given feature by declaring it with a <uses-feature> element in your app's manifest file.
  ```
  <manifest ... >
    <uses-feature android:name="android.hardware.sensor.compass"
                  android:required="true" />
    ...
  </manifest>
  ```
  However, if your app's primary functionality does not require a device feature, you should set the required attribute to "false" and check for the device feature at runtime. If the app feature is not available on the current device, gracefully degrade the corresponding app feature.
- [Platform version](https://developer.android.com/guide/practices/compatibility#Version)
  
  The API level allows you to declare the minimum version with which your app is compatible, using the `<uses-sdk>` manifest tag and its `minSdkVersion` attribute, The `minSdkVersion` attribute declares the minimum version with which your app is compatible and the `targetSdkVersion` attribute declares the highest version on which you've optimized your app.
  
  The `targetSdkVersion` attribute does not prevent your app from being installed on platform versions that are higher than the specified value, but it is important because it indicates to the system whether your app should inherit behavior changes in newer versions. If you don't update the `targetSdkVersion` to the latest version, the system assumes that your app requires some backward-compatibility behaviors when running on the latest version
  
  However, beware that attributes in the `<uses-sdk>` element are overridden by corresponding properties in the `build.gradle` file. So if you're using Android Studio, you must specify the `minSdkVersion` and `targetSdkVersion` values there instead
- [Screen configuration](https://developer.android.com/guide/practices/compatibility#Screens)

  In order to categorize devices by their screen type, Android defines two characteristics for each device: screen size (the physical size of the screen) and screen density (the physical density of the pixels on the screen, known as DPI).

  Android generalizes these variants into groups that make them easier to target:
  - Four generalized sizes: small, normal, large, and xlarge.
  - And several generalized densities: mdpi (medium), hdpi (high), xhdpi (extra high), xxhdpi (extra-extra high), and others.

  By default, your app is compatible with all screen sizes and densities, because the system makes the appropriate adjustments to your UI layout and image resources as necessary for each screen. However, you should optimize the user experience for each screen configuration by adding specialized layouts for different screen sizes and optimized bitmap images for common screen densities.
  
## 2. Screen compatibility overview
### 2.1 Considerations on screen sizes
#### 2.1.1 Flexible layouts
The core principle you must follow is to avoid hard-coding the position and size of your UI components. Instead, allow view sizes to stretch and specify view positions relative to the parent view or other sibling views so your intended order and relative sizes remain the same as the layout grows.
#### 2.1.2 Alternative layouts
Android allows you to provide alternative layout files that the system applies at runtime based on the current device's screen size.
#### 2.1.3 Stretchable images
Android supports nine-patch bitmaps in which you specify small pixel regions that are stretchable—the rest of the image remain unscaled.
### 2.2 Considerations on pixel density.
#### 2.2.1 Density independence
Your app achieves "density independence" when it preserves the physical size (from the user's point of view) of your UI design when displayed on screens with different pixel densities

The Android system helps you achieve density independence by providing density-independent pixels (dp or dip) as a unit of measurement that you should use instead of pixels (px).
#### 2.2.2 Alternative bitmaps
if your app provides bitmaps only for medium density (mdpi) screens, Android scales them up when on a high-density screen so that the image occupies the same physical space on the screen. This can cause visible scaling artifacts in bitmaps.
#### 2.2.3 Vector graphics
For simple types of images (usually icons), you can avoid creating separate images for each density by using vector graphics.
## 3. Support different screen sizes
