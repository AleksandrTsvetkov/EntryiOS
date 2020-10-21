//
//  LoginViewController.swift
//  Party
//
//  Created by Александр Цветков on 21.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var delegate: OnboardingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            guard let navigationVC = navigationController else { return }
            if navigationVC.viewControllers.count > 2 {
                navigationVC.removeControllers(in: 1...2)
            }
            delegate?.blurEffectView.isHidden = true
            delegate?.authView.isHidden = true
            delegate?.authView.transform = .identity
            delegate?.authViewIsVisibleConstraint.isActive = false
            delegate?.authViewIsHiddenConstraint.isActive = true
            navigationController?.navigationBar.isHidden = true
        }
    }
}
