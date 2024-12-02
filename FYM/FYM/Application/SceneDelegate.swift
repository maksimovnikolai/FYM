//
//  SceneDelegate.swift
//  FYM
//
//  Created by Nikolai Maksimov on 01.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: Coordinator?
    private var appFactory: AppFactoryProtocol?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        runUI(scene)
    }
    
    private func runUI(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        appFactory = Di(window: window)
        appFactory?.makeKeyWindowWithCoordinator(windowScene: windowScene) { [weak self] appCoordinator in
            self?.appCoordinator = appCoordinator
        }
    }
}

