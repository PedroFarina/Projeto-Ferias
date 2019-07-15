//
//  DynamicAnimatorController.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class DynamicAnimatorController : NSObject, UICollisionBehaviorDelegate{
    private let animator:UIDynamicAnimator
    private let objectsBoundToScreen:Bool
    private lazy var behavioManager:DynamicBehaviorManager = DynamicBehaviorManager(animator: animator, collisionDelegate: self, translatesReferenceBoundsIntoBoundary: self.objectsBoundToScreen)
    public var contactDelegate:ContactDelegate?
    
    init(view:UIView, delegate:ContactDelegate?, objectsBoundToScreen:Bool){
        animator = UIDynamicAnimator(referenceView: view)
        contactDelegate = delegate
        self.objectsBoundToScreen = objectsBoundToScreen
        super.init()
    }
    
    convenience init(view:UIView, delegate:ContactDelegate){
        self.init(view:view, delegate:delegate, objectsBoundToScreen:true)
    }
    
    convenience init(view:UIView){
        self.init(view:view, delegate:nil, objectsBoundToScreen:true)
    }
    
    ///MARK : Configurating and children to the view
    public func addSubview(_ view:AffectedByDynamics){
        animator.referenceView?.addSubview(view)
        behavioManager.config(object: view)
    }
    
    ///MARK : Collision Occur
    public func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint){
        guard let it1 = item1 as? AffectedByDynamics, let it2 = item2 as? AffectedByDynamics else{
            fatalError("The dynamics items where not according to the protocol. Please if in doubt use the  DynamicObjectsFactory")
        }
        if (it1.categoryBitMask & it2.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: item1, item2: item2, at: p))
        }
        else if (it2.categoryBitMask & it1.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: item2, item2: item1, at: p))
        }
    }
    
    ///MARK : Pushing Objects
    public func pushObject(object:AffectedByDynamics, pushDirection:CGVector){
        behavioManager.CreatePushBehavior(objects:[object], magnitude:1, mode:.instantaneous, pushDirection:pushDirection)
    }
    public func pushObject(object:AffectedByDynamics, pushDirection:CGVector, mode:UIPushBehavior.Mode){
        behavioManager.CreatePushBehavior(objects:[object], magnitude:1, mode:mode, pushDirection:pushDirection)
    }
    public func pushObject(object:AffectedByDynamics, magnitude:CGFloat, pushDirection:CGVector){
        behavioManager.CreatePushBehavior(objects:[object], magnitude:magnitude, mode:.instantaneous, pushDirection:pushDirection)
    }
    public func pushObject(object:AffectedByDynamics, magnitude:CGFloat, mode:UIPushBehavior.Mode, pushDirection:CGVector){
        behavioManager.CreatePushBehavior(objects:[object], magnitude:magnitude, mode:mode, pushDirection:pushDirection)
    }
    public func pushObject(objects:[AffectedByDynamics], magnitude:CGFloat, mode:UIPushBehavior.Mode, pushDirection:CGVector){
        behavioManager.CreatePushBehavior(objects: objects, magnitude: magnitude, mode: mode, pushDirection: pushDirection)
    }
    
    ///MARK: Snaping Objects
    public func snapObject(object:AffectedByDynamics, to p:CGPoint){
        behavioManager.CreateSnapBehavior(object: object, to: p, damping: 1)
    }
    public func snapObject(object:AffectedByDynamics, to p:CGPoint, damping:CGFloat){
        behavioManager.CreateSnapBehavior(object: object, to: p, damping: damping)
    }
}
