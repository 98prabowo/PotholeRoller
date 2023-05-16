//
//  CloudGlobeNode.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import SpriteKit

public final class CloudGlobeNode: SKSpriteNode {
    private let bgTexture: SKTexture
        
    public init(_ bgTexture: SKTexture) {
        self.bgTexture = bgTexture
        super.init(texture: bgTexture, color: .clear, size: bgTexture.size())
        setupAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimation() {
        let moveLeft: SKAction = .moveBy(x: -bgTexture.size().width, y: 0.0, duration: 20)
        let moveReset: SKAction = .moveBy(x: bgTexture.size().width, y: 0.0, duration: 0)
        let moveLoop: SKAction = .sequence([moveLeft, moveReset])
        let moveForever: SKAction = .repeatForever(moveLoop)
        run(moveForever)
    }
}
