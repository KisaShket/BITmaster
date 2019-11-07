//
//  AppDelegate.swift
//  BIT
//
//  Created by Miska  on 03/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

import UIKit
import GoogleMaps
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK:-Апи ключ гугл карт
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDq52HkZ8qOkIOf4ZENyNcZOC3VjceEF7Y")
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

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

