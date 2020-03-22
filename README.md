# Weather Task

### Description
an iOS application to save weather conditions for your current location.

### Run Requirements
* Xcode 11.3.
* Swift 5

### Pods used 
-  'SwiftLint'


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




#### Clean Architecture
* [The Clean Architecture, by Uncle Bob](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
* [Architecture: The Lost Years, by Uncle Bob](https://www.youtube.com/watch?v=HhNIttd87xs)
* [Clean Architecture, By Uncle Bob](https://8thlight.com/blog/uncle-bob/2011/11/22/Clean-Architecture.html)
* [Uncle Bob's clean architecture - An entity/model class for each layer?](http://softwareengineering.stackexchange.com/questions/303478/uncle-bobs-clean-architecture-an-entity-model-class-for-each-layer)
