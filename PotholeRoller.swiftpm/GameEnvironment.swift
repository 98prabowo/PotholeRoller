//
//  GameEnvironment.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import Combine
import SpriteKit
import SwiftUI

public final class GameEnvironment: ObservableObject {
    @Published public var gameState: GameState = .story(.hook)
    @Published public var presentGamePage: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        bindData()
    }
    
    private func bindData() {
        $gameState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .story,
                     .start,
                     .rule,
                     .win,
                     .lose:
                    self.presentGamePage = false
                case .play:
                    self.presentGamePage = true
                }
            }
            .store(in: &cancellables)
    }
}
