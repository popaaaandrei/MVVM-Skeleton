//
//  ViewModel.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//


import Foundation
import RxSwift


public class RxKeyboard: NSObject {
    
    let rx_visibleHeight : Observable<CGFloat>
    private let disposeBag = DisposeBag()

    
    public override init() {
        
        let keyboardWillShow = NotificationCenter.default.rx
            .notification(NSNotification.Name.UIKeyboardWillShow)
        
        let keyboardWillHide = NotificationCenter.default.rx
            .notification(NSNotification.Name.UIKeyboardWillHide)
            
        rx_visibleHeight = Observable
            // merge notifications from hide & show
            .of(keyboardWillShow, keyboardWillHide).merge()
            // get visible keyboard rect
            .map({ ($0.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue })
            // unwrap
            .filter({ $0 != nil }).map({ $0! })
            // visible height
            .map({ UIScreen.main.bounds.height - $0.origin.y })
        
        /*
         if let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            print("UIKeyboardWillShow duration: \(duration)")
         }
         */
        super.init()
    }

    
}
