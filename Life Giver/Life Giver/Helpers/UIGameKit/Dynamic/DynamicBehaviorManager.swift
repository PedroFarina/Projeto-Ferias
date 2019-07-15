//
//  DynamicBehaviorManager.swift
//  UIGameKit
//
//  Created by Pedro Giuliano Farina on 27/06/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class DynamicBehaviorManager{
    private let animator:UIDynamicAnimator
    private let referenceBound:Bool
    private let gravityBehavior:UIGravityBehavior
    private var collisionBehaviors:[UICollisionBehavior] = []
    public var collisionDelegate:UICollisionBehaviorDelegate?{
        didSet{
            for b in  collisionBehaviors{
                b.collisionDelegate = self.collisionDelegate
            }
        }
    }
    
    init(animator:UIDynamicAnimator, collisionDelegate:UICollisionBehaviorDelegate?, translatesReferenceBoundsIntoBoundary:Bool){
        self.animator = animator
        self.collisionDelegate = collisionDelegate
        self.referenceBound = translatesReferenceBoundsIntoBoundary
        
        self.gravityBehavior = UIGravityBehavior(items: [])
        self.animator.addBehavior(gravityBehavior)
    }
    
    convenience init(animator:UIDynamicAnimator, translatesReferenceBoundsIntoBoundary:Bool){
        self.init(animator:animator, collisionDelegate:nil, translatesReferenceBoundsIntoBoundary:translatesReferenceBoundsIntoBoundary)
    }
    
    convenience init(animator:UIDynamicAnimator, collisionDelegate:UICollisionBehaviorDelegate?){
        self.init(animator:animator, collisionDelegate:collisionDelegate, translatesReferenceBoundsIntoBoundary:true)
    }
    
    convenience init(animator:UIDynamicAnimator){
        self.init(animator:animator, collisionDelegate:nil, translatesReferenceBoundsIntoBoundary:true)
    }
    
    public func config(object:AffectedByDynamics){
        if object.affectedByGravity{
            self.gravityBehavior.addItem(object)
        }
        if referenceBound && object.collisionBitMask == 0{
            let cvBehavior = UICollisionBehavior(items: [object])
            cvBehavior.translatesReferenceBoundsIntoBoundary = true
            animator.addBehavior(cvBehavior)
        }
        else{
            let binaryReverse:String = String(String(object.collisionBitMask,  radix:2).reversed())
            checkCount(count: binaryReverse.count)
            
            var i:Int = 0
            for c in binaryReverse{
                if c == "1"{
                    collisionBehaviors[i].addItem(object)
                }
                i+=1
            }
        }
    }
    
    private func checkCount(count:Int){
        if(count > collisionBehaviors.count){
            for _ in collisionBehaviors.count...count{
                let behavior:UICollisionBehavior = UICollisionBehavior(items: [])
                behavior.translatesReferenceBoundsIntoBoundary = referenceBound
                behavior.collisionDelegate =  collisionDelegate
                collisionBehaviors.append(behavior)
                animator.addBehavior(behavior)
            }
        }
    }
    
    
    public func CreatePushBehavior(objects:[AffectedByDynamics], magnitude:CGFloat, mode:UIPushBehavior.Mode, pushDirection:CGVector){
        let behavior:UIPushBehavior = UIPushBehavior(items: objects, mode: mode)
        behavior.magnitude = magnitude
        behavior.pushDirection = pushDirection
        animator.addBehavior(behavior)
    }
    
    public func CreateSnapBehavior(object:AffectedByDynamics, to p:CGPoint, damping:CGFloat){
        let behavior:UISnapBehavior = UISnapBehavior(item: object, snapTo: p)
        behavior.damping = damping
        
        animator.addBehavior(behavior)
    }
}