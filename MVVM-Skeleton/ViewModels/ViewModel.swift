//
//  ViewModel.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//


import Foundation
import RxSwift
import SwiftyJSON



class ViewModel {
    
    /// output to UI: result of operation
    let rx_result = PublishSubject<ViewModelResult>()
    
    /// input from UI: button
    let loginTrigger = PublishSubject<Void>()
    
    /// input from UI: textboxes
    var credentials : Observable<(String?, String?)>? {
        didSet {
            guard let credentials = credentials else {
                return
            }
            
            loginTrigger
                .withLatestFrom(credentials)

                // unwrap
                .filter({ $0 != nil && $1 != nil })
                .map({ ($0!, $1!) })

                // call backend
                .flatMapLatest({ (username, password) in
                    rx_request(Router.auth(email: username, password: password))
                        // if error don't interrupt the sequence
                        .catchError({ [weak self] error in
                            self?.rx_result.onNext(.error(message: "\(error)"))
                            return Observable.just(JSON([]))
                        })
                })
            
                .subscribe(onNext: { json in
                    print("json: \(json)")
                })
                .addDisposableTo(disposeBag)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    

    init() {
        
    }


    
}
