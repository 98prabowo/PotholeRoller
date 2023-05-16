//
//  GameState.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import Foundation

public enum GameState: Equatable {
    case story(StoryPart)
    case rule
    case start
    case play
    case win
    case lose
    
    public enum StoryPart: Equatable {
        case hook
        case insight
        case ahaMoment
        case cta
    }
}
