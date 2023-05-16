//
//  GameScene.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import Combine
import SpriteKit

public final class GameScene: SKScene, SKPhysicsContactDelegate {
    public var gameEnvironment: GameEnvironment?

    private let score = CurrentValueSubject<Int, Never>(0)
    
    private let playerPosition = CurrentValueSubject<RollerPosition, Never>(.left)
    
    private var player: SKSpriteNode?
    
    private var scoreNode: SKLabelNode?
    
    private let rollerTexture = SKTexture(image: #imageLiteral(resourceName: "roadroller_0.png"))
    
    private let bgTexture = SKTexture(image: #imageLiteral(resourceName: "background.png"))
    
    private let holeTexture: SKTexture = SKTexture(imageNamed: PotHole.green.imageName)
    
    private let holes: [PotHole] = PotHole.holes
    
    private lazy var holePositions: [CGPoint] = PotHole.holePositions(frame, holeHeight: holeTexture.size().height)
    
    public var backgroundMusic: SKAudioNode?
    
    public var cancellables = Set<AnyCancellable>()
    
    public override func didMove(to view: SKView) {
        setupPhysicsWorld()
        setupScoreNode()
        setupBackground()
        setupPlayer()
        startPotHoles()
        setupMusic()
        bindData()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { touch in
            let location = touch.location(in: self)
            
            if location.x < frame.width / 2 {
                playerPosition.send(.left)
            } else {
                playerPosition.send(.right)
            }
        }
    }
    
    private func setupPhysicsWorld() {
        physicsWorld.contactDelegate = self
    }
    
    private func setupScoreNode() {
        scoreNode = SKLabelNode(fontNamed: "AppleSDGothicNeo-Bold")
        scoreNode?.text = "Score: \(score.value)"
        scoreNode?.horizontalAlignmentMode = .right
        scoreNode?.fontSize = 30
        scoreNode?.position = CGPoint(x: frame.width - 30, y: frame.height - 50)
        guard let scoreNode else { return }
        addChild(scoreNode)
    }
    
    private func setupBackground() {
        for index in 0...1 {
            let bgNode = BackgroundNode(bgTexture)
            bgNode.zPosition = -20.0
            bgNode.anchorPoint = .zero
            bgNode.position = CGPoint(
                x: 0.0,
                y: bgTexture.size().height * CGFloat(index) - CGFloat(index)
            )
            addChild(bgNode)
        }
    }
    
    private func setupPlayer() {
        player = RoadRollerNode(rollerTexture)
        player?.zPosition = 10.0
        player?.anchorPoint = .zero
        player?.name = "road_roller"
        player?.position = playerPosition.value.position(frame)
        guard let player else { return }
        addChild(player)
    }
    
    private func setupPotHoles() {
        holePositions.forEach { [unowned self] pos in
            guard let hole = self.holes.randomElement() else { return }
            let holeNode = PotHoleNode(hole, bgTexture: bgTexture)
            holeNode.zPosition = -10.0
            holeNode.anchorPoint = .zero
            holeNode.position = pos
            holeNode.name = hole.name
            addChild(holeNode)
        }
    }
    
    private func startPotHoles() {
        let create: SKAction = .run { [unowned self] in
            self.setupPotHoles()
        }
        
        let wait = SKAction.wait(forDuration: 7)
        let sequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(sequence)

        run(repeatForever)
    }
    
    private func setupMusic() {
        if let musicURL = Bundle.main.url(forResource: "game_music", withExtension: "wav") {
            backgroundMusic = SKAudioNode(url: musicURL)
            backgroundMusic?.autoplayLooped = true
            guard let backgroundMusic else { return }
            addChild(backgroundMusic)
            backgroundMusic.run(.stop())
        }
    }
    
    private func bindData() {
        score
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] score in
                guard let self else { return }
                if score >= 10 {
                    self.gameEnvironment?.gameState = .win
                } else if score < 0 {
                    self.gameEnvironment?.gameState = .lose
                }
                self.scoreNode?.text = "Score: \(score)"
            }
            .store(in: &cancellables)
        
        playerPosition
            .receive(on: DispatchQueue.main)
            .sink { [frame, player] pos in
                let position: CGPoint = pos.position(frame)
                let moveAction: SKAction = .move(to: position, duration: 0.5)
                player?.run(moveAction)
            }
            .store(in: &cancellables)
        
        gameEnvironment?.$gameState
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .play:
                    self.backgroundMusic?.run(.play())
                case .story, .start, .rule, .win, .lose:
                    self.backgroundMusic?.run(.stop())
                }
            }
            .store(in: &cancellables)
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        guard contact.bodyA.node?.name == ObjectName.roadRoller.rawValue || contact.bodyB.node?.name == ObjectName.roadRoller.rawValue else { return }
        
        let isTouchGreenHole: Bool = contact.bodyA.node?.name == ObjectName.greenHole.rawValue || contact.bodyB.node?.name == ObjectName.greenHole.rawValue
        let isTouchYellowHole: Bool = contact.bodyA.node?.name == ObjectName.yellowHole.rawValue || contact.bodyB.node?.name == ObjectName.yellowHole.rawValue
        let isTouchRedHole: Bool = contact.bodyA.node?.name == ObjectName.redHole.rawValue || contact.bodyB.node?.name == ObjectName.redHole.rawValue
        
        if isTouchGreenHole {
            let point: Int = score.value + 2
            score.send(point)
            let sound: SKAction = .playSoundFileNamed("coin.wav", waitForCompletion: false)
            run(sound)
            
        } else if isTouchYellowHole {
            let point: Int = Bool.random() ? -1 : 1
            let total: Int = score.value + point
            score.send(total)
            
            let sound: SKAction
            if point > 0 {
                sound = .playSoundFileNamed("coin.wav", waitForCompletion: false)
            } else {
                sound = .playSoundFileNamed("explosion.wav", waitForCompletion: false)
            }
            run(sound)
            
        } else if isTouchRedHole {
            let sound: SKAction = .playSoundFileNamed("explosion.wav", waitForCompletion: false)
            run(sound)
            gameEnvironment?.gameState = .lose
        }
    }
}

