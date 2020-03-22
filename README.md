### Description
an iOS application to save weather conditions for your current location.
### Run Requirements

* Xcode 11.3.
* Swift 5


## Layers
* **Data  Layer** = Repositories Implementations + API (Network) + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views
* **Coordinator Layer** = Routing + ViewController factoring

##### Presentation Logic
* `View` -  user interaction events 
* All `UIViewController`, `UIView`, `UITableViewCell` subclasses belong to the `View` layer
* Usually the view is passive / dumb - it shouldn't contain any complex logic and that's why most of the times we don't need write Unit Tests for it.

* `ViewModel` - contains the presentation logic and tells the `View` what to present

* `Coordinator` - contains navigation / flow logic from one scene (view controller) to another


