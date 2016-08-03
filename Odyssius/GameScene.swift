//
//  GameScene.swift
//  Odyssius
//
//  Created by Scott Ha on 7/26/16.
//  Copyright (c) 2016 HappyViet. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	let playerMask:UInt32 = 0x1 << 0 // 1
	let enemyMask:UInt32 = 0x1 << 1 // 2
	let bulletMask:UInt32 = 0x1 << 2 // 4
	
	var testPlayer:SKSpriteNode!
	var touchLocation:CGPoint = CGPointZero
	var button:SKSpriteNode!
	
	var shootingSpeed = 10
	var bulletSpeed:CGFloat = 10.0
	var shipSpeed = 0.5
	var currentFrame = 0
	var touching = false
	
    override func didMoveToView(view: SKView) {
		testPlayer = self.childNodeWithName("playerShip") as! SKSpriteNode
		button = self.childNodeWithName("button") as! SKSpriteNode
		
		let enemy:SKSpriteNode = SKScene(fileNamed: "testEnemy")!.childNodeWithName("testEnemy")! as! SKSpriteNode
		enemy.removeFromParent()
		self.addChild(enemy)
		enemy.position = CGPointMake(325, 1000)
		
		self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		touchLocation = touches.first!.locationInNode(self)
		
		if button.containsPoint(touchLocation){
			print("button pressed %f", currentFrame)
		}else{
			if !touching{
				touching = true
				//testPlayer.position = touchLocation
			}
		}
    }
	
	
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		if touching{
			touchLocation = touches.first!.locationInNode(self)
			//testPlayer.position = touchLocation
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		touchLocation = touches.first!.locationInNode(self)
		
		if button.containsPoint(touchLocation){
			print("button released %f", currentFrame)
		}else{
			if touching{
				touching = false
				//testPlayer.position = touchLocation
			}
		}
	}
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
		currentFrame += 1
		if touching{
			fireBullet()
			let a1 = SKAction.moveTo(touchLocation, duration: shipSpeed)
			testPlayer.runAction(a1)
		}
		else{
		}
    }
	
	func didBeginContact(contact: SKPhysicsContact) {
		let bullet = (contact.bodyA.categoryBitMask == bulletMask) ? contact.bodyA : contact.bodyB
		let other = (contact.bodyA.categoryBitMask == bulletMask) ? contact.bodyB : contact.bodyA
		
		if other.categoryBitMask == enemyMask{
			let spark:SKEmitterNode = SKEmitterNode(fileNamed: "BulletHit")!
			spark.position = other.node!.position
			self.addChild(spark)
			bullet.node?.removeFromParent()
		}
		
	}
	
	func fireBullet(){
		if(currentFrame % shootingSpeed == 0)
		{
			let bullet:SKSpriteNode = SKScene(fileNamed: "testBullet")!.childNodeWithName("testBullet")! as! SKSpriteNode
			bullet.removeFromParent()
			self.addChild(bullet)
			bullet.position = testPlayer.position
			bullet.physicsBody?.collisionBitMask = enemyMask
			bullet.physicsBody?.contactTestBitMask = bullet.physicsBody!.collisionBitMask
			
			bullet.physicsBody?.applyImpulse(CGVectorMake(0.0, bulletSpeed))
		}
	}
}
