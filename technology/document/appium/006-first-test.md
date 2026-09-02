# Cài đặt
- Cài appium
```
npm install -g appium
```
- Cài Android Studio: https://developer.android.com/studio
- Cài SDK (có vẻ tự cài luôn khi cài Android Studio rồi): https://developer.android.com/studio
- Cài JDK: https://jdk.java.net/
- Cài driver
```
appium driver install uiautomator2
```
- Bật Android SDK Command-line tools from Android Studio Preferences
- Thêm variable vào zshrc
```
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-23.jdk/Contents/Home
```
- Chạy command, đảm bảo ko có lỗi gì
```
appium driver doctor uiautomator2
```
# Chạy first test
- Tạo folder mới
- npm init
- Cài thư viện: npm i --save-dev webdriverio
- Thêm code:
```javascript
const {remote} = require('webdriverio');

const capabilities = {
  platformName: 'Android',
  'appium:automationName': 'UiAutomator2',
  'appium:deviceName': 'Android',
  'appium:appPackage': 'com.android.settings',
  'appium:appActivity': '.Settings',
};

const wdOpts = {
  hostname: process.env.APPIUM_HOST || 'localhost',
  port: parseInt(process.env.APPIUM_PORT, 10) || 4723,
  logLevel: 'info',
  capabilities,
};

async function runTest() {
  const driver = await remote(wdOpts);
  try {
    const batteryItem = await driver.$('//*[@text="Battery"]');
    await batteryItem.click();
  } finally {
    await driver.pause(1000);
    await driver.deleteSession();
  }
}

runTest().catch(console.error);
```
- Bật appium lên: `appium`
- Bật con máy ảo trên Android Studio lên.
- Chạy code: `node test.js`
- App sẽ mở Settings, click vào mục Battery
- Repo: https://github.com/minhphong306/appium-learn