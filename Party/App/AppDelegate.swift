//
//  AppDelegate.swift
//  Party
//
//  Created by Александр Цветков on 15.10.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let token = UserDefaults.standard.string(forKey: "refresh_token") {
            NetworkService.shared.refresh(refreshToken: token) { result in
                switch result {
                case .success(let data):
                    do {
                        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                        if let accessToken = dict["access_token"] as? String {
                            UserDefaults.standard.set(accessToken, forKey: "access_token")
                            self.showProfile()
                        }
                    } catch {
                        print(error)
                        self.showOnboarding()
                    }
                case .failure(let error):
                    print(error)
                    self.showOnboarding()
                }
            }
        } else {
            //showOnboarding()
            showProfile()
        }
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    private func showOnboarding() {
        let rootViewController = OnboardingViewController()
        //let rootViewController = CitiesViewController()
        let navigationController = NavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = Colors.pink.getValue()
        window?.rootViewController = navigationController
    }
    
    private func showProfile() {
        let tabBarController = TabBarViewController()
//        NetworkService.shared.getUserDetails { result in
//            switch result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let user = try decoder.decode(UserResponse.self, from: data)
//                    guard let vc = tabBarController.viewControllers?[1] as? ProfileViewController else { return }
//                    vc.user = UserRequest(fromUser: user)
//                } catch {
//                    self.showOnboarding()
//                    print(error)
//                }
//                self.window?.rootViewController = tabBarController
//            case .failure(let error):
//                self.showOnboarding()
//                print(error)
//            }
//        }
        self.window?.rootViewController = tabBarController
    }
}

