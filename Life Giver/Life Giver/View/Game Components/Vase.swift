//
//  Vase.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 16/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class Vase : UIImageView, AffectedByDynamics{
    public var affectedByGravity: Bool = false
    public var stationary: Bool = true
    public var categoryBitMask: UInt32 = 0x1 << 4
    public var collisionBitGroup: UInt32 = 0x1
    public var contactBitMask: UInt32 = 0x0
}
