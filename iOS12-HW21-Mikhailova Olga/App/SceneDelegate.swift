//
//  SceneDelegate.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        //        let apiManager = NetworkManagerMarvel()
        let apiManager = NetworkManagerAF()
        let viewController = MarvellViewController(apiManager: apiManager)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

