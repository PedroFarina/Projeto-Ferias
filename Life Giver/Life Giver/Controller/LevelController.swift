//
//  LevelController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 23/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class LevelController : UIViewController, ContactDelegate{
    public var Level:String?
    private var animatorController:DynamicAnimatorController?
    
    public override func viewWillAppear(_ animated: Bool) {
        animatorController = DynamicAnimatorController(view: self.view)
        guard let Level = Level, let animatorController = animatorController else{
            fatalError("Não foi possível fazer a transição de nível.")
        }
        animatorController.contactDelegate = self
        animatorController.makeLevel(levelState: Level, controller: self, delegate: #selector(tapOccur(recognizer:)))
    }
    
    @objc public func tapOccur(recognizer: UITapGestureRecognizer) {
        guard let view = recognizer.view as? AffectedByDynamics else{
            fatalError("O objeto de toque não era do tipo correto.")
        }
        if let glass = view as? Glass{
            glass.value += 1
            if glass.value == 1{
                glass.image = UIImage(named: GeneralProperties.glassBreakingPath)
            }
            else if glass.value == 2{
                glass.image = UIImage(named: GeneralProperties.glassBrokenPath)
            }
            else{
                animatorController?.removeFromView(glass)
            }
        }
        else if let apple = view as? Apple{
            animatorController?.pushObject(object: apple, pushDirection: CGVector(dx: CGFloat.random(in: -3...3), dy: 3))
        }
    }
    
    public func contactOccur(contact: UIContact) {
        guard let item1 = contact.item1 as? AffectedByDynamics, let item2 = contact.item2 as? AffectedByDynamics, let animatorController = animatorController else{
            fatalError("Os itens de contato devem seguir o protocolo ou o animator é nil.")
        }
        
        if item1.categoryBitMask == GeneralProperties.dropletCategoryBitMask{
            if item2.categoryBitMask == GeneralProperties.vaseCategoryBitMask{
                wetVase(item2 as! Vase, droplet: item1)
            }
            else{
                resetDroplet(item1)
            }
            
        }
        else if item2.categoryBitMask == GeneralProperties.dropletCategoryBitMask{
            if item1.categoryBitMask == GeneralProperties.vaseCategoryBitMask{
                wetVase(item1 as! Vase, droplet: item2)
            }
            else{
                resetDroplet(item2)
            }
            
        }
        else if item1.categoryBitMask == GeneralProperties.appleCategoryBitMask && item2.categoryBitMask == GeneralProperties.floorCategoryBitMask{
            
            turnToSeed(item1 as! Apple)
        }
        else if item2.categoryBitMask == GeneralProperties.appleCategoryBitMask && item1.categoryBitMask == GeneralProperties.floorCategoryBitMask{
            
            turnToSeed(item2 as! Apple)
        }
        else if item1.categoryBitMask == GeneralProperties.seedCategoryBitMask && item2.categoryBitMask == GeneralProperties.vaseCategoryBitMask{
            createPlant(vase: item2 as! Vase, seed: item1 as! Seed)
        }
        else if item2.categoryBitMask == GeneralProperties.seedCategoryBitMask && item1.categoryBitMask == GeneralProperties.vaseCategoryBitMask{
            createPlant(vase: item1 as! Vase, seed: item2 as! Seed)
        }
    }
    
    func wetVase(_ vase:Vase, droplet:AffectedByDynamics){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        vase.wet = true
        animatorController.removeFromView(droplet)
    }
    
    func resetDroplet(_ droplet:AffectedByDynamics){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        let d = Droplet(image: UIImage(named: GeneralProperties.dropletPath))
        d.frame = animatorController.getInitialFrame(droplet)!
        animatorController.removeFromView(droplet)
        animatorController.addSubview(d)
    }
    
    func turnToSeed(_ apple:Apple){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        var path:String
        switch apple.value {
        case 1:
            path = GeneralProperties.redSeedPath
        case 2:
            path = GeneralProperties.blueSeedPath
        default:
            path = GeneralProperties.greenSeedPath
        }
        
        let s = Seed(image: UIImage(named: path))
        //let size = SizeAdapter.getRatioSizeByMinor(Seed.dimensions, deviceSize: view.frame.size)
        //s.frame.size = CGSize(width: size.height, height: size.width)
        s.center = apple.center
        animatorController.removeFromView(apple)
        animatorController.addSubview(s)
        let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panPiece(_:)))
        s.isUserInteractionEnabled = true
        s.addGestureRecognizer(panRecognizer)
    }
    
    func createPlant(vase:Vase, seed:Seed){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        animatorController.removeFromView(seed)
    }
    
    var initialCenter = CGPoint()
    @objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer){
        guard let piece = gestureRecognizer.view as? AffectedByDynamics else {
            fatalError("O objeto arrastado não era do tipo correto.")
        }
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            self.initialCenter = piece.center
        }
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
            animatorController?.updateObject(object: piece)
        }
        else {
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
        }
    }
    
    deinit{
        animatorController = nil
    }
}
