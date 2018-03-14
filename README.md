KolodaView [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Swift 4.0.x](https://img.shields.io/badge/Swift-4.0.x-orange.svg)
--------------

![Preview](https://github.com/Yalantis/Koloda/blob/master/Koloda_v2_example_animation.gif)
![Preview](https://github.com/Yalantis/Koloda/blob/master/Koloda_v1_example_animation.gif)

Purpose
--------------

KolodaView is a class designed to simplify the implementation of Tinder like cards on iOS. It adds convenient functionality such as a UITableView-style dataSource/delegate interface for loading views dynamically, and efficient view loading, unloading .

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 11.0 (Xcode 9)

ARC Compatibility
------------------

KolodaView requires ARC.

Сocoapods version
------------------

```ruby
pod 'Koloda', '~> 4.3.2'
```

Thread Safety
--------------

KolodaView is subclassed from UIView and - as with all UIKit components - it should only be accessed from the main thread. You may wish to use threads for loading or updating KolodaView contents or items, but always ensure that once your content has loaded, you switch back to the main thread before updating the KolodaView.

Installation
--------------
To install via CocoaPods add this lines to your Podfile. You need CocoaPods v. 1.1 or higher
```ruby
use_frameworks!
pod "Koloda"
```

To install via Carthage add this lines to your Cartfile
```ruby
github "Eratos1122/Koloda"
```

To install manually the KolodaView class in an app, just drag the KolodaView, DraggableCardView, OverlayView class files (demo files and assets are not needed) into your project. Also you need to install facebook-pop. Or add bridging header if you are using CocoaPods.

Usage
--------------

1. Import `Koloda` module to your `MyKolodaViewController` class

    ```swift
    import Koloda
    ```
2. Add `KolodaView` to `MyKolodaViewController`, then set dataSource and delegate for it
    ```swift
    class ViewController: UIViewController {
        @IBOutlet weak var kolodaView: KolodaView!

        override func viewDidLoad() {
            super.viewDidLoad()

            kolodaView.dataSource = self
            kolodaView.delegate = self
        }
    }
    ```
3. Conform your `MyKolodaViewController` to `KolodaViewDelegate` protocol and override some methods if you need, e.g.
    ```swift
    extension MyKolodaViewController: KolodaViewDelegate {
        func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
            koloda.reloadData()
        }

        func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
            UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        }
    }
    ```
4. Conform `MyKolodaViewController` to `KolodaViewDataSource` protocol and implement all the methods , e.g.
    ```swift
    extension MyKolodaViewController: KolodaViewDataSource {

        func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
            return images.count
        }

        func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
            return .fast
        }

        func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
            return UIImageView(image: images[index])
        }

        func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
            return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)[0] as? OverlayView
        }
    }
    ```
5. `KolodaView` works with default implementation. Override it to customize its behavior

Also check out [an example project with carthage](https://github.com/serejahh/Koloda-Carthage-usage).

Properties
--------------

The KolodaView has the following properties:
```swift
weak var dataSource: KolodaViewDataSource?
```
An object that supports the KolodaViewDataSource protocol and can provide views to populate the KolodaView.
```swift
weak var delegate: KolodaViewDelegate?
```
An object that supports the KolodaViewDelegate protocol and can respond to KolodaView events.
```swift
private(set) public var currentCardIndex
```
The index of front card in the KolodaView (read only).
```swift
private(set) public var countOfCards
```
The count of cards in the KolodaView (read only). To set this, implement the `kolodaNumberOfCards:` dataSource method.
```swift
public var countOfVisibleCards
```
The count of displayed cards in the KolodaView.
```swift
public var allowedDirections
```
The array of allowed swipe directions in the KolodaCardView.

Methods
--------------

The KolodaView class has the following methods:
```swift
public func reloadData()
```
This method reloads all KolodaView item views from the dataSource and refreshes the display.
```swift
public func resetCurrentCardIndex()
```
This method resets currentCardIndex and calls reloadData, so KolodaView loads from the beginning.
```swift
public func revertAction()
```
Applies undo animation and decrement currentCardIndex.
```swift
public func applyAppearAnimationIfNeeded()
```
Applies appear animation if needed.
```swift
public func swipe(_ direction: SwipeResultDirection, force: Bool = false)
```
Applies swipe animation and action, increment currentCardIndex.

```swift
open func frameForCard(at index: Int) -> CGRect
```

Calculates frames for cards. Useful for overriding. See example to learn more about it.

Protocols
---------------

The KolodaView follows the Apple convention for data-driven views by providing two protocol interfaces, KolodaViewDataSource and KolodaViewDelegate.

#### The KolodaViewDataSource protocol has the following methods:
```swift
func koloda(_ kolodaNumberOfCards koloda: KolodaView) -> Int
```
Return the number of items (views) in the KolodaView.
```swift
func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView
```
Return a view to be displayed at the specified index in the KolodaView.
```swift
func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView?
```
Return a view for card overlay at the specified index. For setting custom overlay action on swiping(left/right), you should override didSet of overlayState property in OverlayView. (See Example)
```swift
func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed
```
Allow management of the swipe animation duration

#### The KolodaViewDelegate protocol has the following methods:
```swift
func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection]
```
Return the allowed directions for a given card, defaults to `[.left, .right]`
```swift
func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool
```
This method is called before the KolodaView swipes card. Return `true` or `false` to allow or deny the swipe.
```swift
func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
```
This method is called whenever the KolodaView swipes card. It is called regardless of whether the card was swiped programatically or through user interaction.
```swift
func kolodaDidRunOutOfCards(_ koloda: KolodaView)
```
This method is called when the KolodaView has no cards to display.
```swift
func koloda(_ koloda: KolodaView, didSelectCardAt index: Int)
```
This method is called when one of cards is tapped.
```swift
func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool
```
This method is fired on reload, when any cards are displayed. If you return YES from the method or don't implement it, the koloda will apply appear animation.
```swift
func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool
```
This method is fired on start of front card swipping. If you return YES from the method or don't implement it, the koloda will move background card with dragging of front card.
```swift
func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool
```
This method is fired on koloda's layout and after swiping. If you return YES from the method or don't implement it, the koloda will transparentize next card below front card.
```swift
func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection)
```
This method is called whenever the KolodaView recognizes card dragging event.
```swift
func kolodaSwipeThresholdRatioMargin(_ koloda: KolodaView) -> CGFloat?
```
Return the percentage of the distance between the center of the card and the edge at the drag direction that needs to be dragged in order to trigger a swipe. The default behavior (or returning NIL) will set this threshold to half of the distance
```swift
func kolodaDidResetCard(_ koloda: KolodaView)
```
This method is fired after resetting the card.
```swift
func koloda(_ koloda: KolodaView, didShowCardAt index: Int)
```
This method is called after a card has been shown, after animation is complete
```swift
func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool
```
This method is called when the card is beginning to be dragged. If you return YES from the method or
don't implement it, the card will move in the direction of the drag. If you return NO the card will
not move.
