//
//  AppDelegate.swift
//  GetOutfit
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  private var mainCoordinator: MainCoordinator?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    startMainCoordinator()
    return true
  }
  
  private func startMainCoordinator() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let rootNavigationController = NavigationController()
    window.rootViewController = rootNavigationController
    self.window = window
    
    let mainCoordinator = MainCoordinator(navigationController: rootNavigationController,
                                          appDependency: AppDependency())
    mainCoordinator.start(animated: false)
    self.mainCoordinator = mainCoordinator
    
    window.makeKeyAndVisible()
  }
}

