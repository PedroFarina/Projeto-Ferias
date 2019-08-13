//
//  LevelController.swift
//  Life Giver
//
//  Created by Pedro Giuliano Farina on 23/07/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import Foundation

public class LevelController : UIViewController, ContactDelegate{
    //fix while UIKit doesn't fix
    public var droplets:[Droplet] = []
    public var oldPositions:[CGPoint] = []
    
    public var level:Level?
    private var animatorController:DynamicAnimatorController?
    private var vases:[Vase] = []
    public var delegate:LevelFinishedDelegate?
    
    public override func viewWillAppear(_ animated: Bool) {
        animatorController = DynamicAnimatorController(view: self.view)
        guard let level = level, let state = level.state, let animatorController = animatorController else{
            fatalError("Não foi possível fazer a transição de nível.")
        }
        animatorController.contactDelegate = self
        vases = animatorController.makeLevel(levelState: state, controller: self, delegate: #selector(tapOccur(recognizer:)))
        
        //Fixes while UIKit doesn't fix
        fixInit()
    }
    
    var running:Bool = false
    func scaleUpAndDown(_ obj:UIView, duration:Double){
        if vases.count == 1 && obj.tag < 3 && !running{
            running = true
            obj.tag++
            let originalSize = obj.frame.size
            let center = obj.center
            UIView.animate(withDuration: duration/2, animations: {
                obj.frame.size = obj.frame.size * 1.3
                obj.center = center
            }) { (success) in
                UIView.animate(withDuration: duration/2, animations: {
                    obj.frame.size = originalSize
                    obj.center = center
                    self.running = false
                })
            }
        }
    }
    
    @objc public func tapOccur(recognizer: UITapGestureRecognizer) {
        guard let view = recognizer.view as? AffectedByDynamics, let animatorController = animatorController else{
            fatalError("O objeto de toque não era do tipo correto.")
        }
        if let glass = view as? Glass{
            glass.value++
            if glass.value == 1{
                glass.image = UIImage(named: GeneralProperties.glassBreakingPath)
                SoundManager.playSFX(sound: .glassBreaking)
            }
            else if glass.value == 2{
                glass.image = UIImage(named: GeneralProperties.glassBrokenPath)
                SoundManager.playSFX(sound: .glassBreaking)
            }
            else{
                SoundManager.playSFX(sound: .glassBroke)
                if let glass = glass as? GlassWithApple{
                    if let ap = glass.getApple(){
                        ap.center = glass.center
                        ap.removeFromSuperview()
                        ap.isUserInteractionEnabled = true
                        animatorController.addSubview(ap)
                    }
                }
                animatorController.removeFromView(glass)
            }
        }
        else if let apple = view as? Apple{
            SoundManager.playSFX(sound: .appleJump)
            let multiplier =  Int(apple.frame.size.width / Apple.dimensions.width)
            var rnd:Int = 0
            while rnd == 0{
                rnd = Int.random(in: -1...1)
            }
            animatorController.pushObject(object: apple, pushDirection: CGVector(dx: max(Double(rnd * multiplier), rnd * 0.5), dy: min(Double(-multiplier), -0.5)))
        }
    }
    
    public func contactOccur(contact: UIContact) {
        guard let item1 = contact.item1 as? AffectedByDynamics, let item2 = contact.item2 as? AffectedByDynamics, let _ = animatorController else{
            fatalError("Os itens de contato devem seguir o protocolo ou o animator é nil.")
        }
        
        if item1.categoryBitMask == GeneralProperties.dropletCategoryBitMask{
            if item2.categoryBitMask == GeneralProperties.vaseCategoryBitMask{
                wetVase(item2 as! Vase, droplet: item1)
            }
            else{
                resetDroplet(item1)
                if item2.categoryBitMask == GeneralProperties.glassCategoryBitMask{
                    scaleUpAndDown(item2, duration: 0.6)
                }
            }
            
        }
        else if item2.categoryBitMask == GeneralProperties.dropletCategoryBitMask{
            if item1.categoryBitMask == GeneralProperties.vaseCategoryBitMask{
                wetVase(item1 as! Vase, droplet: item2)
            }
            else{
                resetDroplet(item2)
                if item1.categoryBitMask == GeneralProperties.glassCategoryBitMask{
                    scaleUpAndDown(item1, duration: 0.8)
                }
            }
            
        }
        else if item1.categoryBitMask == GeneralProperties.appleCategoryBitMask{
            if item2.categoryBitMask == GeneralProperties.floorCategoryBitMask{
                turnToSeed(item1 as! Apple)
            }
            else{
                scaleUpAndDown(item1, duration: 0.8)
            }
        }
        else if item2.categoryBitMask == GeneralProperties.appleCategoryBitMask{
            if item1.categoryBitMask == GeneralProperties.floorCategoryBitMask{
                turnToSeed(item2 as! Apple)
            }
            else{
                scaleUpAndDown(item2, duration: 0.8)
            }
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
        if !vase.wet{
            vase.wet = true
            animatorController.removeFromView(droplet)
            SoundManager.playSFX(sound: .waterSuccess)
            
            //fix while UIKit doesn't fix
           dropletFixRemove(droplet as! Droplet)
        }
        else{
            resetDroplet(droplet)
        }
    }
    
    func resetDroplet(_ droplet:AffectedByDynamics){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        SoundManager.playSFX(sound: .waterFail)
        let d = Droplet(image: UIImage(named: GeneralProperties.dropletPath))
        d.frame = animatorController.getInitialFrame(droplet)!
        animatorController.removeFromView(droplet)
        animatorController.addSubview(d)
        
        //Fix while UIKit doens't fix
        dropletFixRemove(droplet as! Droplet)
        dropletFixAdd(d)
    }
    
    func turnToSeed(_ apple:Apple){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        SoundManager.playSFX(sound: .appleToSeed)
        let s = Seed(image: UIImage(named: GeneralProperties.getSeedPathFor(value: apple.value)))
        s.value = apple.value
        s.frame.size = SizeAdapter.getRatioSizeByBiggest(Seed.dimensions, deviceSize: view.frame.size)
        s.center = apple.center
        animatorController.removeFromView(apple)
        animatorController.addSubview(s)
        scaleUpAndDown(s, duration: 1.5)
        let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panPiece(_:)))
        s.isUserInteractionEnabled = true
        s.addGestureRecognizer(panRecognizer)
    }
    
    func createPlant(vase:Vase, seed:Seed){
        guard let animatorController = animatorController else{
            fatalError("O animator controller é nil")
        }
        if vase.wet && vase.animationDuration == 0{
            let oldSize = vase.frame.size
            vase.frame.size = SizeAdapter.getRatioSizeByBiggest(Vase.withPlantDimension, deviceSize: view.frame.size)
            let diff = vase.frame.size - oldSize
            vase.layer.position.x -= diff.width/2
            vase.layer.position.y -= diff.height
            animatorController.removeFromView(seed)
            var imgs:[UIImage] = []
            for imgPath in GeneralProperties.getPlantsPathesFor(value: seed.value + vase.value){
                if let img = UIImage(named: imgPath){
                    imgs.append(img)
                }
            }
            vase.animationImages = imgs
            vase.animationDuration = 1.5
            vase.startAnimating()
            animatorController.removeBehaviors(of: vase)
            _ = Timer.scheduledTimer(withTimeInterval: vase.animationDuration, repeats: false) { (timer) in
                vase.stopAnimating()
                vase.image = vase.animationImages?.last
                vase.tag = seed.value + vase.value
                self.checkEndGame()
            }
        }
        else{
            activeGesture?.isEnabled = false
            activeGesture?.isEnabled = true
        }
    }
    
    func checkEndGame(){
        guard let level = level else{
            fatalError("O nível não existe mais.")
        }
        var finished:Bool = true
        for v in vases{
            finished &= v.tag > 0
        }
        if finished{
            var completionLevel:Int = 0
            if vases.count == 1{
                completionLevel = 3
            }
            else{
                for vase in vases{
                    let red:Bool = vase.tag == GeneralProperties.redAppleValue + GeneralProperties.redVaseValue
                    let green:Bool = vase.tag == GeneralProperties.greenAppleValue + GeneralProperties.greenVaseValue
                    let blue:Bool = vase.tag == GeneralProperties.blueAppleValue + GeneralProperties.blueVaseValue
                    
                    if red || green || blue{
                        completionLevel++
                    }
                }
            }
            if completionLevel == 0 || completionLevel == 1{
                completionLevel++
            }
            else if completionLevel >= 4{
                completionLevel = 3
            }
            
            if completionLevel > level.completion{
                let answer = ModelController.shared().modifyLevel(level: level, newCompletion: Int16(completionLevel))
                level.completion = Int16(completionLevel)
                if !answer.successful{
                    fatalError(answer.description)
                }
            }
            if level.id == GeneralProperties.colorLevelID{
                if !GeneralProperties.colorsUnlocked{
                    GeneralProperties.unlockColors()
                }
                checkColorBlind()
            }
            else{
                myDismiss()
            }
        }
    }
    
    func checkColorBlind(){
        if (UIAccessibility.isGrayscaleEnabled || UIAccessibility.isInvertColorsEnabled || UIAccessibility.isDarkerSystemColorsEnabled) && !GeneralProperties.DaltonismoValue {
            let alertTitle = Bundle.main.localizedString(forKey: "Alert Title", value: nil, table: nil)
            let message = Bundle.main.localizedString(forKey: "Alert Message", value: nil, table: nil)
            let yes = Bundle.main.localizedString(forKey: "Sim", value: nil, table: nil)
            let no = Bundle.main.localizedString(forKey: "Não", value: nil, table: nil)
            
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: yes, style: .default, handler: { (action) in
                GeneralProperties.DaltonismoValue = true
                self.myDismiss()
            }))
            alert.addAction(UIAlertAction(title: no, style: .cancel, handler: {(action) in
                self.myDismiss()
            }))
            self.present(alert, animated: true)
        }
        else{
            myDismiss()
        }
    }
    
    func myDismiss(){
        SoundManager.playSFX(sound: .levelSuccess)
        delegate?.levelFinished(level: level!)
        self.dismiss(animated: true, completion: nil)
    }
    
    var initialCenter = CGPoint()
    var activeGesture:UIPanGestureRecognizer?
    @objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer){
        guard let piece = gestureRecognizer.view as? AffectedByDynamics, let animatorController = animatorController else {
            fatalError("O objeto arrastado não era do tipo correto ou o animador era nulo.")
        }
        activeGesture = gestureRecognizer
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: piece.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            self.initialCenter = piece.center
            animatorController.removeBehaviors(of: piece)
        }
        // Update the position for the .began, .changed, and .ended states
        if gestureRecognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
            if gestureRecognizer.state == .ended{
                animatorController.addBehaviors(to: piece)
                animatorController.updateObject(object: piece)
            }
        }
        else {
            // On cancellation, return the piece to its original location.
            piece.center = initialCenter
            animatorController.updateObject(object: piece)
        }
    }
    
    deinit{
        animatorController = nil
    }
}

//Bug fix while UIKit doesn't fix it
extension LevelController{
    public func fixInit(){
        for view in view.subviews{
            if let v = view as? Droplet{
                droplets.append(v)
                oldPositions.append(v.layer.position)
            }
        }
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            var i:Int = 0
            
            for d in self.droplets{
                if self.oldPositions[i] == d.layer.position{
                    for v in self.vases{
                        if !v.wet{
                            d.center.y += Glass.dimensions.height
                            self.animatorController?.updateObject(object: d)
                            break
                        }
                    }
                }
                self.oldPositions[i] = d.layer.position
                i += 1
            }
            })
    }
    
    public func dropletFixRemove(_ droplet:Droplet){
        for i in 0 ..< droplets.count{
            if droplets[i] == droplet{
                droplets.remove(at: i)
                oldPositions[i] = CGPoint(x: -1, y: -1)
                break
            }
        }
    }
    
    public func dropletFixAdd(_ droplet:Droplet){
        droplets.append(droplet)
    }
}
