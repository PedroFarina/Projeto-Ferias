//
//  ModelStatus.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 15/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

public class ModelStatus{
    public private(set) var successful:Bool
    public private(set) var description:String
    
    init(successful:Bool, description:String) {
        self.successful = successful
        self.description = description
    }
    
    convenience init(successful:Bool){
        self.init(successful:successful, description:"")
    }
}
