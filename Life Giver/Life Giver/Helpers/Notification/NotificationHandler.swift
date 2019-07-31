//
//  NotificationSender.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UserNotifications
import UIKit

public class NotificationHandler{
    private init(){
    }
    
    public static var allowed:Bool = defaults.bool(forKey: "notificationPermission")
    {
        didSet{
            askPermission()
            defaults.set(allowed, forKey: "notificationPermission")
        }
    }
    
    private static func askPermission(){
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                defaults.set(false, forKey: "notificationPermission")
            }
            else{
                defaults.set(true, forKey: "notificationPermission")
            }
        }
    }
    
    private static let defaults = UserDefaults.standard
    
    private static let notificationCenter:UNUserNotificationCenter = UNUserNotificationCenter.current()
    private static var notifications:[MyNotification] = []
    public static var notificationsOnHold:Int{
        get{
            return notifications.count
        }
    }
    
    public static func handleNotification(response:UNNotificationResponse){
        var i = 0
        var found:Bool = false
        for notification in notifications{
            if notification.identifier == response.notification.request.identifier{
                if let actions = notification.actions{
                    for action in actions{
                        if action.0 == response.actionIdentifier{
                            action.1()
                            found =  true
                            break
                        }
                    }
                }
            }
            i+=1
        }
        i-=1
        if found{
            notifications.remove(at: i)
        }
    }
    
    public static func notify(title:String, body:String, time:Double, sound:Bool, badges:Bool){
        notify(title: title, body: body, time: time, sound: sound, badges: badges, actions: nil)
    }
    
    public static func notify(title:String, body:String, time:Double, sound:Bool, badges:Bool, actions:[(title:String, action:() -> Void, appReOpens:Bool)]?){
        if !allowed{
            askPermission()
            return
        }
        
        let df:DateFormatter = DateFormatter()
        df.dateFormat = "ddMMyy hhmmss ZZZ"
        let identifier = "\(df.string(from: Date()))"
        
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus  == .authorized{
                let userActions:String = "\(identifier) actions"
                
                if let actions = actions{
                    var categoryActions:[UNNotificationAction] = []
                    for action in actions{
                        
                        categoryActions.append(UNNotificationAction(identifier: action.0, title: action.0, options: action.2 ? [.foreground] : []))
                    }
                    
                    let category = UNNotificationCategory(identifier: userActions, actions: categoryActions, intentIdentifiers: [], options: [])
                    
                    self.notificationCenter.setNotificationCategories([category])
                }
                
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
                content.sound =  sound ? UNNotificationSound.default : nil
                
                content.badge = badges ? 1 : 0 as NSNumber
                
                content.categoryIdentifier = userActions
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                self.notificationCenter.add(request, withCompletionHandler: { (error:Error?) in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                })
                notifications.append(MyNotification(identifier: identifier, actions: actions))
            }
        }
    }
}
