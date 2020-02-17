//
//  SceneDelegate.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/16.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        guard let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let dataManager = DataManager(persistentContainer: persistentContainer)
        let viewController = UINavigationController(rootViewController: MainViewController(dataManager: dataManager))
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

