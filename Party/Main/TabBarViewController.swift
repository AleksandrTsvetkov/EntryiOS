//
//  TabBarViewController.swift
//  Party
//
//  Created by Александр Цветков on 31.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let mapVC = generateViewController(vcType: MapViewController.self, title: "Обзор", imageName: "overview")
        let historyVC = generateViewController(vcType: HistoryViewController.self, title: "Мои вечеринки", imageName: "history")
        let profileVC = generateViewController(vcType: ProfileViewController.self, title: "Профиль", imageName: "profile")
        setViewControllers([mapVC, historyVC, profileVC], animated: false)
        selectedViewController = mapVC
        tabBar.tintColor = Colors.pink.getValue()
        tabBar.unselectedItemTintColor = Colors.buttonGray.getValue()
        tabBar.barTintColor = Colors.tabBarBlack.getValue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func generateViewController<T: UIViewController>(vcType: T.Type, title: String, imageName: String) -> T {
        let vc = T()
        let image = UIImage(named: imageName)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let font = UIFont(name: "SFProText-Medium", size: 10) ?? UIFont.systemFont(ofSize: 10)
        let attributesNormal = [NSAttributedString.Key.foregroundColor: Colors.buttonGray.getValue(), NSAttributedString.Key.font: font] as [NSAttributedString.Key: Any]
        let attributesSelected = [NSAttributedString.Key.foregroundColor: Colors.pink.getValue(), NSAttributedString.Key.font: font] as [NSAttributedString.Key: Any]
        tabBarItem.setTitleTextAttributes(attributesNormal, for: .normal)
        tabBarItem.setTitleTextAttributes(attributesSelected, for: .selected)
        vc.tabBarItem = tabBarItem
        return vc
    }
}
