# Moondial
Shimmer library for ios

Example how to use

1. View which is shimmered should implements protocol 

```
class ShimmerDemoView: UIView, ShimmersContainer {

    var shimmers: [ShimmerSettings] {
       return [
        childView1.shimmer(style: .transparent).width(40.ui).height(40.ui),
        childView2.shimmer(style: .transparent).customShape(ShimmerView.hexagonShaper),
        childView3.shimmer(style: .transparent),
        childView4.shimmer(style: .hidden)
       ]
    }
}
```

2. In your view/controller add shimmer view

```
    private let shimmerView2 = ShimmerDemoView()

    private lazy var shimmerView = ShimmerView(shimmers: {
        shimmerView2.shimmers
    })
```

3. Add shimmer view into your view hierarchy and set real content view to be displayed when shimmer stopped.

```
    self.view.addSubviews(shimmerView)
    shimmerView.addSubviews(shimmerView2)
    shimmerView.set(realContentView: realContentView)
```

4. You don't need to layout real content view. It will fill the whole parent.

```
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        demoView1.pin.top(50.ui).horizontally().height(120.ui)
        shimmerView.pin.below(of: demoView1).marginTop(20.ui).horizontally().height(120.ui)
        demoView2.pin.all()
    }
```

To start / stop shimmer use next code:

```
shimmerView.startShimmer()

shimmerView.stopShimmer()
```