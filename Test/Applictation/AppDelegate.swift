//
//  AppDelegate.swift
//  Test
//
//  Created by 홍정민 on 11/7/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureDependency()
        return true
    }
    
    private func configureDependency() {
        DependencyContainer.register(Lunch(name: "햄버거"))
        DependencyContainer.register(Dinner(name: "치킨"))
        
        let lunch: Lunch = DependencyContainer.resolve()
        let dinner: Dinner = DependencyContainer.resolve()
        DependencyContainer.register(Restaurant(lunch: lunch, dinner: dinner))
        
        let restaurant100: Restaurant = DependencyContainer.resolve()
        restaurant100.showMenu()
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

