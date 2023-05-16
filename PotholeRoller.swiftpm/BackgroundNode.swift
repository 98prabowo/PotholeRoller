//
//  BackgroundNode.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import SpriteKit

public final class BackgroundNode: SKSpriteNode {
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
        let moveDown: SKAction = .moveBy(x: 0.0, y: -bgTexture.size().height, duration: 10)
        let moveReset: SKAction = .moveBy(x: 0.0, y: bgTexture.size().height, duration: 0)
        let moveLoop: SKAction = .sequence([moveDown, moveReset])
        let moveForever: SKAction = .repeatForever(moveLoop)
        run(moveForever)
    }
}
