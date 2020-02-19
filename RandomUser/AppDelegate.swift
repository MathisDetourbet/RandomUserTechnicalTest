//
//  AppDelegate.swift
//  RandomUser
//
//  Created by Mathis Detourbet on 30/12/19.
//  Copyright © 2019 Mathis Detourbet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configurations
        let userDefaultsConfiguration: Configuration = UserDefaultsConfiguration()
        let apiConfiguration: Configuration = ApiConfiguration()
        
        // Network layer
        let networkService: NetworkLayer = NetworkService(configuration: apiConfiguration)
        
        // Data accessors
        let apiDataAccess: ApiDataAccess = ApiDataAccess(apiConfiguration: apiConfiguration, networkService: networkService)
        let userDefaultsDataAccess: UserDefaultsDataAccess = UserDefaultsDataAccess(userDefaultsConfiguration: userDefaultsConfiguration)
        
        // Business Service
        let businessService = BusinessService(apiDataAccess: apiDataAccess, localStorageDataAccess: userDefaultsDataAccess)
        
        // View models
        let randomUserListViewModel = RandomUserListViewModel(businessService: businessService)
        
        // RootViewController
        let randomUserListViewController = RandomUserListViewController.instantiate(with: randomUserListViewModel)
        
        // Navigation controller
        let navigationController = UINavigationController(rootViewController: randomUserListViewController)
        
        // Window setup
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
