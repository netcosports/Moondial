//
//  ViewController.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit
import Moondial
import Astrolabe
import PinLayout
import RxSwift

class ViewController: UIViewController {
    
    private let contentView = CollectionView<CollectionViewSource>()
    private let eventSubject = PublishSubject<DemoShimmerType>()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(contentView)
        contentView.backgroundColor = .cyan
        
        let data: [DemoShimmerType] = [.demo1, .demo2]
        
        contentView.source.sections = [
            Section(
                cells: data.map { type in
                    Cell.init(
                        data: type,
                        id: "\(type)",
                        eventsEmmiter: eventSubject.asObserver()
                    )
                }
            )
        ]
        contentView.reloadData()
        
        eventSubject.asObservable()
            .subscribe(onNext: { [weak self] event in
                switch event {
                    
                case .demo1:
                    self?.openController(SampleShimmerController1())
                    break
                case .demo2:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.pin.all().marginTop(self.view.safeAreaInsets.top)
    }
    
    private func openController(_ controller: UIViewController) {
      self.navigationController?.pushViewController(controller, animated: true)
    }

    typealias Cell = CollectionCell<HomeCollectionCell>
}

enum DemoShimmerType {
    case demo1
    case demo2
}

