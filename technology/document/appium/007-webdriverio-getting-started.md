- https://webdriver.io/docs/gettingstarted/

# Init setup
- create-wdio 002-wdio
- Chọn Typescript cho strong type
- Run theo 1 spec file cụ thể: `npx wdio run ./wdio.conf.ts --spec test.e2e.ts`
- Run theo một suite cụ thể: `npx wdio run ./wdio.conf.ts --suite "My Login application"` -> run đang ko được.

# Code test đầu tiên
```typescript
import { remote } from 'webdriverio'

const browser = await remote({
    capabilities: {
        browserName: 'chrome',
        'goog:chromeOptions': {
            args: process.env.CI ? ['headless', 'disable-gpu'] : []
        }
    }
})

await browser.url('https://webdriver.io')

const apiLink = await browser.$('=API')
await apiLink.click()

await browser.saveScreenshot('./screenshot.png')
await browser.deleteSession()
```