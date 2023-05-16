//
//  HomeView.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import Combine
import SpriteKit
import SwiftUI

public struct HomeView: View {
    @StateObject internal var gameEnv = GameEnvironment()
    
    public var homeScene: SKScene {
        let scene = HomeScene()
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
                    
                    SpriteView(scene: homeScene)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    Spacer()
                }
                
                VStack(spacing: 25.0) {
                    switch gameEnv.gameState {
                    case .start, .play:
                        Group {
                            Image(uiImage: #imageLiteral(resourceName: "title.png"))
                                .resizable()
                                .frame(
                                    width: geometry.size.width / 2,
                                    height: (79 / 205) * (geometry.size.width / 2)
                                )
                                .padding(.bottom, 15)
                            
                            Button(action: {
                                self.gameEnv.gameState = .play
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "play_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            .fullScreenCover(isPresented: $gameEnv.presentGamePage) {
                                GameView()
                                    .environmentObject(gameEnv)
                                
                            }
                            
                            Button(action: {
                                self.gameEnv.gameState = .rule
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "rule_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                        }
                        
                    case .rule:
                        Image(uiImage: #imageLiteral(resourceName: "panel_rule.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        Button(action: {
                            self.gameEnv.gameState = .play
                        }) {
                            Image(uiImage: #imageLiteral(resourceName: "play_btn.png"))
                                .resizable()
                                .frame(
                                    width: geometry.size.width / 3,
                                    height: (5 / 17) * (geometry.size.width / 3)
                                )
                        }
                        
                    case .win:
                        Image(uiImage: #imageLiteral(resourceName: "panel_win.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                self.gameEnv.gameState = .start
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "menu_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            
                            Button(action: {
                                self.gameEnv.gameState = .play
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "play_again_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            .fullScreenCover(isPresented: $gameEnv.presentGamePage) {
                                GameView()
                                    .environmentObject(gameEnv)
                                
                            }
                        }
                        
                    case .lose:
                        Image(uiImage: #imageLiteral(resourceName: "panel_lose.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                self.gameEnv.gameState = .start
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "menu_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            
                            Button(action: {
                                self.gameEnv.gameState = .play
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "play_again_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            .fullScreenCover(isPresented: $gameEnv.presentGamePage) {
                                GameView()
                                    .environmentObject(gameEnv)
                                
                            }
                        }
                        
                    case .story(.hook):
                        Image(uiImage: #imageLiteral(resourceName: "panel_story_0.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                self.gameEnv.gameState = .story(.insight)
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "next_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                        }
                        
                    case .story(.insight):
                        Image(uiImage: #imageLiteral(resourceName: "panel_story_1.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                self.gameEnv.gameState = .story(.hook)
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "back_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            
                            Button(action: {
                                self.gameEnv.gameState = .story(.ahaMoment)
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "next_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                        }
                        
                    case .story(.ahaMoment):
                        Image(uiImage: #imageLiteral(resourceName: "panel_story_2.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                self.gameEnv.gameState = .story(.insight)
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "back_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            
                            Button(action: {
                                self.gameEnv.gameState = .story(.cta)
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "next_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                        }
                        
                    case .story(.cta):
                        Image(uiImage: #imageLiteral(resourceName: "panel_story_3.png"))
                            .resizable()
                            .frame(
                                width: (2 / 3) * geometry.size.width,
                                height: (2 / 3) * geometry.size.height
                            )
                            .padding(.bottom, 15)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                self.gameEnv.gameState = .story(.ahaMoment)
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "back_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                            
                            Button(action: {
                                self.gameEnv.gameState = .start
                            }) {
                                Image(uiImage: #imageLiteral(resourceName: "next_btn.png"))
                                    .resizable()
                                    .frame(
                                        width: geometry.size.width / 3,
                                        height: (5 / 17) * (geometry.size.width / 3)
                                    )
                            }
                        }
                    }
                }
            }
        }
    }
    
    public init() {}
}
