//
//  DynamicAnimatorController.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 26/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class DynamicAnimatorController : NSObject, UICollisionBehaviorDelegate{
    public let animator:UIDynamicAnimator
    private let objectsBoundToScreen:Bool
    private lazy var behaviorManager:DynamicBehaviorManager = DynamicBehaviorManager(animator: animator, collisionDelegate: self, translatesReferenceBoundsIntoBoundary: self.objectsBoundToScreen)
    public var contactDelegate:ContactDelegate?
    private var views:[(AffectedByDynamics, CGRect)] = []
    
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
    
    ///MARK : Configurating children to the view
    public func addSubview(_ view:AffectedByDynamics){
        views.append((view, view.frame))
        animator.referenceView?.addSubview(view)
        behaviorManager.config(view)
    }
    
    public func getInitialFrame(_ object:AffectedByDynamics) -> CGRect?{
        for view in views{
            if view.0 == object{
                return view.1
            }
        }
        return nil
    }
    
    public func removeFromView(_ object:AffectedByDynamics){
        var i = 0
        var removed:Bool = false
        for obj in views{
            if obj.0 == object{
                removed = true
                break
            }
            i+=1
        }
        if removed{
            views.remove(at: i)
        }
        behaviorManager.remove(object)
    }
    
    ///MARK : Collision Occur
    public func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint){
        guard let it1 = item1 as? AffectedByDynamics, let it2 = item2 as? AffectedByDynamics else{
            fatalError("The dynamics items where not according to the protocol. Please if in doubt use the DynamicObjectsFactory")
        }
        if (it1.categoryBitMask & it2.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: item1, item2: item2, at: p))
        }
        else if (it2.categoryBitMask & it1.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: item2, item2: item1, at: p))
        }
    }
    
    public func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        guard let identifier = identifier as? UIBezierPath else{
            return
        }
        var item2:AffectedByDynamics? = nil
        for view in views{
            if identifier == view.0.path{
                item2 = view.0
                break
            }
        }
        guard let it1 = item as? AffectedByDynamics, let it2 = item2 else{
            fatalError("The dynamics items were not according to the protocol. Please if in doubt use the DynamicObjectsFactory")
        }
        if contactDelegate == nil{
            print("OPORA")
        }
        if (it1.categoryBitMask & it2.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: it1, item2: it2, at: p))
        }
        else if (it2.categoryBitMask & it1.contactBitMask) > 0{
            contactDelegate?.contactOccur(contact: UIContact(behavior: behavior, item1: it2, item2: it1, at: p))
        }
    }
    
    ///MARK : Pushing Objects
    public func pushObject(object:AffectedByDynamics, pushDirection:CGVector){
        behaviorManager.CreatePushBehavior(objects:[object], magnitude:1, mode:.instantaneous, pushDirection:pushDirection)
    }
    public func pushObject(object:AffectedByDynamics, pushDirection:CGVector, mode:UIPushBehavior.Mode){
        behaviorManager.CreatePushBehavior(objects:[object], magnitude:1, mode:mode, pushDirection:pushDirection)
    }
    public func pushObject(object:AffectedByDynamics, magnitude:CGFloat, pushDirection:CGVector){
        behaviorManager.CreatePushBehavior(objects:[object], magnitude:magnitude, mode:.instantaneous, pushDirection:pushDirection)
    }
    public func pushObject(object:AffectedByDynamics, magnitude:CGFloat, mode:UIPushBehavior.Mode, pushDirection:CGVector){
        behaviorManager.CreatePushBehavior(objects:[object], magnitude:magnitude, mode:mode, pushDirection:pushDirection)
    }
    public func pushObject(objects:[AffectedByDynamics], magnitude:CGFloat, mode:UIPushBehavior.Mode, pushDirection:CGVector){
        behaviorManager.CreatePushBehavior(objects: objects, magnitude: magnitude, mode: mode, pushDirection: pushDirection)
    }
    
    ///MARK: Snaping Objects
    public func snapObject(object:AffectedByDynamics, to p:CGPoint){
        behaviorManager.CreateSnapBehavior(object: object, to: p, damping: 1)
    }
    public func snapObject(object:AffectedByDynamics, to p:CGPoint, damping:CGFloat){
        behaviorManager.CreateSnapBehavior(object: object, to: p, damping: damping)
    }
    
    //MARK: Custom moves
    public func updateObject(object:AffectedByDynamics){
        animator.updateItem(usingCurrentState: object)
    }
}
