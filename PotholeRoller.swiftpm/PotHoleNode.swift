//
//  PotHoleNode.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import SpriteKit

public final class PotHoleNode: SKSpriteNode {
    private let holeTexture: SKTexture
    
    private let bgTexture: SKTexture
    
    public init(_ type: PotHole, bgTexture: SKTexture) {
        self.holeTexture = SKTexture(imageNamed: type.imageName)
        self.bgTexture = bgTexture
        super.init(texture: holeTexture, color: .clear, size: holeTexture.size())
        setupPhysicsBody()
        setupAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody() {
        physicsBody = SKPhysicsBody(
            rectangleOf: holeTexture.size(),
            center: CGPoint(x: holeTexture.size().width / 2, y: holeTexture.size().height / 2)
        )
        physicsBody?.isDynamic = false
    }
    
    private func setupAnimation() {
        let endPosition: CGFloat = bgTexture.size().height + 4 * holeTexture.size().height
        let moveDown: SKAction = .moveBy(x: 0.0, y: -endPosition, duration: 10)
        let moveLoop: SKAction = .sequence([moveDown, SKAction.removeFromParent()])
        let moveForever: SKAction = .repeatForever(moveLoop)
        run(moveForever)
    }
}

