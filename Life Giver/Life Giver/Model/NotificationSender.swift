//
//  NotificationSender.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 30/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class NotificationSender{
    private init(){
    }
    
    private static let defaults = UserDefaults.standard
    public static var permitted:Bool = defaults.bool(forKey: "ntfPermitted"){
        didSet{
            defaults.set(permitted, forKey: "ntfPermitted")
        }
    }
    
    public static func sendNotification(){
        if permitted{
            if NotificationHandler.allowed && NotificationHandler.notificationsOnHold == 0{
                let title:String = Bundle.main.localizedString(forKey: "Notification Title", value: nil, table: nil)
                let body:String = Bundle.main.localizedString(forKey: "Notification \(Int.random(in: 1...5))", value: nil, table: nil)
                NotificationHandler.notify(title: title, body: body, time: Double.random(in: 120...300), sound: false, badges: false)
            }
        }
    }
}
