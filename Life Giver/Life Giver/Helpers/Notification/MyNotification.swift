//
//  MyNotification.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

class MyNotification{
    var identifier:String
    var actions:[(title:String, action:() -> Void, appReOpens:Bool)]?
    
    init(identifier:String, actions:[(title:String, action:() -> Void, appReOpens:Bool)]?) {
        self.identifier = identifier
        self.actions = actions
    }
}
