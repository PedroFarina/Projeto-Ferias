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
    
    public static func sendNotification(){
        if NotificationHandler.allowed && NotificationHandler.notificationsOnHold == 0{
            let title:String = Bundle.main.localizedString(forKey: "Notification Title", value: nil, table: nil)
            let body:String = Bundle.main.localizedString(forKey: "Notification \(Int.random(in: 1...4))", value: nil, table: nil)
            let more:String = Bundle.main.localizedString(forKey: "Quero saber mais!", value: nil, table: nil)
            NotificationHandler.notify(title: title, body: body, time: Double.random(in: 300...500), sound: false, badges: true)
        }
    }
}
