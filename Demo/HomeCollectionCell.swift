//
//  HomeCollectionCell.swift
//  Demo
//
//  Created by Dzianis Shykunets on 17.01.23.
//

import UIKit
import Astrolabe
import RxSwift
import RxCocoa
import RxGesture

class HomeCollectionCell: CollectionViewCell, Reusable, Eventable {
    var eventSubject =  PublishSubject<DemoShimmerType>()
    
    typealias Event = DemoShimmerType
    private let disposeBag = DisposeBag()
    
    private let title = UILabel {
        $0.textColor = .black
    }
    
    override func setup() {
        super.setup()
        self.addSubviews(title)
        title.rx.tapGesture().when(.recognized)
            .subscribe(onNext: {[weak self] _ in
                guard let self = self, let data = self.data else {
                    return
                }
                self.eventSubject.onNext(data)
            })
            .disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.pin.all().marginStart(20.ui)
    }
    
    func setup(with data: DemoShimmerType) {
        switch data {
            
        case .demo1:
            title.text = "Demo 1"
        case .demo2:
            title.text = "Demo 2"
        }
    }
    
    var data: DemoShimmerType?
    
    typealias Data = DemoShimmerType
    
    static func size(for data: DemoShimmerType, containerSize: CGSize) -> CGSize {
        return .init(width: containerSize.width, height: 50.ui)
    }
    
}
