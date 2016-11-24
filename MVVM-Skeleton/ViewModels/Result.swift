//
//  Result.swift
//  MVVM-Skeleton
//
//  Created by andrei on 24/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//

import Foundation
import RxSwift
import PKHUD



/// possible result of operation
public enum ViewModelResult {
    case started
    case success(message: String?)
    case error(message: String?)
    case progress
    case stop
}



extension ObservableType where Self.E == ViewModelResult {
    
    public func showResultHUD() -> Disposable {
        
        return self
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                
                switch result {
                case .started: ()
                HUD.show(.progress)
                case let .success(message):
                    if let message = message {
                        HUD.flash(.labeledSuccess(title: message, subtitle: nil), delay: 1.0)
                    } else {
                        HUD.flash(.success, delay: 1.0)
                    }
                case let .error(message):
                    if let message = message {
                        HUD.flash(.label(message), delay: 2.0)
                    } else {
                        HUD.flash(.error, delay: 2.0)
                    }
                case .stop:
                    HUD.hide(animated: true)
                case .progress(_):
                    HUD.show(.progress)
                }
            })
    }
}


