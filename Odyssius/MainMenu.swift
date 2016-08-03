//
//  MainMenu.swift
//  Odyssius
//
//  Created by Scott Ha on 7/26/16.
//  Copyright © 2016 HappyViet. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
	var button_01:SKSpriteNode!
	var button_02:SKSpriteNode!
	var touchLocation:CGPoint = CGPointZero
	
	override func didMoveToView(view: SKView) {
		button_01 = self.childNodeWithName("button_01") as! SKSpriteNode
		button_02 = self.childNodeWithName("button_02") as! SKSpriteNode
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		touchLocation = touches.first!.locationInNode(self)
		
		if button_01.containsPoint(touchLocation){
			let game:GameScene = GameScene(fileNamed: "GameScene")!
			game.scaleMode = .AspectFit
			self.view?.presentScene(game)
		} else if button_02.containsPoint(touchLocation){
			let game:GameScene = GameScene(fileNamed: "Level_02")!
			game.scaleMode = .AspectFit
			self.view?.presentScene(game)
		}
	}
}
