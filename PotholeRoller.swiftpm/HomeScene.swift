//
//  HomeScene.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import Combine
import SpriteKit

public class HomeScene: SKScene {
    public var gameEnvironment: GameEnvironment?
    
    private let cloudTexture = SKTexture(image: #imageLiteral(resourceName: "background_sky.png"))
    
    private let globe: SKSpriteNode = GlobeNode()
    
    public var backgroundMusic: SKAudioNode?
    
    private var cancellables = Set<AnyCancellable>()
    
    public override func didMove(to view: SKView) {
        setupCloud()
        setupGlobe()
        setupMusic()
        bindData()
    }
    
    private func setupCloud() {
        for index in 0...1 {
            let cloudNode = CloudGlobeNode(cloudTexture)
            cloudNode.zPosition = -10.0
            cloudNode.anchorPoint = .zero
            cloudNode.position = CGPoint(
                x: cloudTexture.size().width * CGFloat(index) - CGFloat(index),
                y: 0.0
            )
            addChild(cloudNode)
        }
    }
    
    private func setupGlobe() {
        globe.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        globe.position = CGPoint(
            x: cloudTexture.size().width / 2,
            y: 0
        )
        addChild(globe)
    }
    
    private func setupMusic() {
        if let musicURL = Bundle.main.url(forResource: "home_music", withExtension: "wav") {
            backgroundMusic = SKAudioNode(url: musicURL)
            backgroundMusic?.autoplayLooped = true
            guard let backgroundMusic else { return }
            addChild(backgroundMusic)
            backgroundMusic.run(.stop())
        }
    }
    
    private func bindData() {
        gameEnvironment?.$gameState
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .play:
                    self.backgroundMusic?.run(.stop())
                case .story, .start, .rule, .win, .lose:
                    self.backgroundMusic?.run(.play())
                }
            }
            .store(in: &cancellables)
    }
}
