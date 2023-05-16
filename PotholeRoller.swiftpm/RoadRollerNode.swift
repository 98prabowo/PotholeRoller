//
//  RoadRollerNode.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import SpriteKit

public final class RoadRollerNode: SKSpriteNode {
    private let rollerTexture: SKTexture
    
    public init(_ texture: SKTexture) {
        rollerTexture = texture
        super.init(texture: rollerTexture, color: .clear, size: rollerTexture.size())
        setupPhysicsBody()
        setupAnimation()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody() {
        physicsBody = SKPhysicsBody(
            rectangleOf: rollerTexture.size(),
            center: CGPoint(x: rollerTexture.size().width / 2, y: rollerTexture.size().height / 2)
        )
        
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        
        physicsBody?.contactTestBitMask = physicsBody?.collisionBitMask ?? 0
        physicsBody?.collisionBitMask = 0
    }
    
    private func setupAnimation() {
        let rollerTexture1 = SKTexture(image: #imageLiteral(resourceName: "roadroller_1.png"))
        let rollerTexture2 = SKTexture(image: #imageLiteral(resourceName: "roadroller_2.png"))
        let animate: SKAction = .animate(
            with: [rollerTexture, rollerTexture1, rollerTexture2],
            timePerFrame: 0.3
        )
        let forever: SKAction = .repeatForever(animate)
        
        run(forever)
    }
}
