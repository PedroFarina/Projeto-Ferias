//
//  AppDelegate.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 14/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let defaults = UserDefaults.standard
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        NotificationSender.sendNotification()
        
        #if DEBUG
        for level in ModelController.shared().getLevels(){
            _ = ModelController.shared().resetLevelState(level: level)
        }
        #else
        checkUpdate()
        #endif
        
        
        GeneralProperties.start()
        DispatchQueue.global(qos: .background).async {
            SoundManager.initPlayers()
        }
        if defaults.integer(forKey: SoundManager.SFXKey) == 0{
            defaults.set(101, forKey: SoundManager.SFXKey)
            SoundManager.SFXValue = 101
        }
        return true
    }
    
    func checkUpdate(){
        guard let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else{
            fatalError("Não foi possível pegar a versão.")
        }
        let previousVersion = defaults.string(forKey: "appVersion") ?? ""
        if previousVersion == ""{
            //Primeira instalação
            defaults.set(currentAppVersion, forKey: "appVersion")
            return
        }
        
        if previousVersion != currentAppVersion{
            for level in ModelController.shared().getLevels(){
                _ = ModelController.shared().resetLevelState(level: level)
            }
            defaults.set(currentAppVersion, forKey: "appVersion")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        defaults.set(SoundManager.SFXValue, forKey: SoundManager.SFXKey)
        defaults.set(GeneralProperties.DaltonismoValue, forKey: GeneralProperties.DaltonismoKey)
        self.saveContext()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return .portrait
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Life_Giver")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
