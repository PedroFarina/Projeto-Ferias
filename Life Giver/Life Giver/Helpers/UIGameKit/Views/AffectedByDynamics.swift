//
//  AffectedByDynamics.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public protocol AffectedByDynamics : UIView{
    var affectedByGravity:Bool { get }
    var stationary:Bool { get }
    var categoryBitMask:UInt32 { get }
    var collisionBitGroup:UInt32 { get }
    var contactBitMask:UInt32 { get }
}
