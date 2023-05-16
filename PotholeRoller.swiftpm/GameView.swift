//
//  GameView.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import SpriteKit
import SwiftUI

public struct GameView: View {
    @EnvironmentObject internal var gameEnv: GameEnvironment
    
    public var gameScene: GameScene {
        let scene = GameScene()
        scene.size = CGSizeMake(900.0, 600.0)
        scene.scaleMode = .aspectFill
        scene.gameEnvironment = gameEnv
        return scene
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                                            
                    SpriteView(scene: gameScene)
                        .frame(width: geometry.size.width, height: (6 / 9) * geometry.size.width)
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    Spacer()
                }
            }
        }
    }
    
    public init() {}
}

