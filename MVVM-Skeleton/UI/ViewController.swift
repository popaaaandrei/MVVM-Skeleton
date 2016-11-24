//
//  ViewController.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController {
    
    // UI components
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    private let keyboard = RxKeyboard()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupTheme()
    }
    
    
    func setupTheme() {
        
        username.setupTheme(borderColor: UIColor(white: 1, alpha: 0.2), borderWidth: 1, cornerRadius: 4, textColor: UIColor.white)
        
        password.setupTheme(borderColor: UIColor(white: 1, alpha: 0.2), borderWidth: 1, cornerRadius: 4, textColor: UIColor.white)
        
        loginButton.setupTheme(borderColor: UIColor.clear, borderWidth: 0, backgroundColorNormal: UIColor(white: 1, alpha: 0.8), cornerRadius: 4)
    }
    
    
    /// here we do all the bindings
    func setupBindings() {
        
        // 1) transfer input to viewModel
        viewModel.credentials = Observable.combineLatest(username.rx.text, password.rx.text) { ($0, $1) }
        
        // 2) transfer output to an action on the viewModel
        loginButton.rx
            .tap
            .bindTo(self.viewModel.loginTrigger)
            .addDisposableTo(disposeBag)
    
        // any clicks on the view closes the keyboard
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .addDisposableTo(disposeBag)
        view.addGestureRecognizer(tapBackground)
        
        
        // keyboard events
        keyboard
            .rx_visibleHeight
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] height in
                // set constraint
                let _height = height > 0 ? height + 10 : 10
                self?.bottomConstraint?.constant = _height
                
                // animate
                self?.view.setNeedsLayout()
                UIView.animate(withDuration: 0) {
                    self?.view.layoutIfNeeded()
                }
            })
            .addDisposableTo(disposeBag)
        
        
        // handle the operations results
        viewModel
            .rx_result
            .showResultHUD()
            .addDisposableTo(disposeBag)
    }


}

