> https://appium.io/docs/en/latest/intro/clients/

- Appium implement client-server architechture.
- Đại khái bài này nói về cách mà client code hoạt động.

```
const element = await driver.$('//*[@text="Foo"]');
await element.click();
console.log(await element.getText())
console.log(await driver.getPageSource())
```