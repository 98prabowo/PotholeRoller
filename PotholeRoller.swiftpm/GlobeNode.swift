//
//  GlobeNode.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import SpriteKit

public final class GlobeNode: SKSpriteNode {
    private let globeTexture: SKTexture
        
    public init() {
        globeTexture = SKTexture(image: #imageLiteral(resourceName: "globe.png"))
        super.init(texture: globeTexture, color: .clear, size: globeTexture.size())
        setupAnimation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimation() {
        let scale: CGFloat = 1.2
        let resizeSmaller: SKAction = .scale(by: scale, duration: 2)
        let resizeReset: SKAction = .scale(by: 1/scale, duration: 2)
        let moveLoop: SKAction = .sequence([resizeSmaller, resizeReset])
        let moveForever: SKAction = .repeatForever(moveLoop)
        run(moveForever)
    }
}
