# Adkross SDK 💚

#### What it Adkross SDK?

Adkross SDK provides you to increase your installs by doing cross promotion between your own apps. You don't buy a bit new users with huge budget like other ad platforms. You move many users you already have in another app to your brand new app. 

You can visit Adkross SDK with https://www.adkross.com.

You can read Adkross SDK documentation for more detail in [Adkross SDK Notion Documentation](https://tundra-lynx-197.notion.site/829188763a7b4057919078551650cdcd?v=e18c2c8222ba41eda7fc555441b60956).

### How to install Adkross SDK?

Adkross SDK relies on SPM provided by Apple, Inc.

```swift
dependencies: [
    .package(url: "https://github.com/adkross/adkross-ios-sdk.git", .upToNextMajor(from: "1.0.0"))
]
```

### How to implement Adkross SDK?

You should start the Adkross SDK in the one of AppDelegate or SceneDelegate files.

```swift
import Adkross

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  Adkross.startWith(
    apiKey: "YOUR_API_KEY",
    appKey: "YOUR_APP_KEY"
  )
        
  return true
}

```

```swift
import Adkross

class ViewController: UIViewController {
  private var adkross: AdkrossInterstitial!

  override func viewDidLoad() {
    super.viewDidLoad()
    adkross = AdkrossInterstitial()
    adkross.delegate = self // It's optional and no need if you don't want to handle callback from the Adkross SDK.
    adkross.load()
  }

  @IBAction private func presentAdkrossSDKAdButtonTapped(_ sender: Any) {
    adkross.present()
  }
}
```


### Need more?

Don't hesitate Contact with support@adkross.com.

You can visit Adkross SDK with https://www.adkross.com.

You can read Adkross SDK documentation for more detail in [Adkross SDK Notion Documentation](https://tundra-lynx-197.notion.site/829188763a7b4057919078551650cdcd?v=e18c2c8222ba41eda7fc555441b60956).
