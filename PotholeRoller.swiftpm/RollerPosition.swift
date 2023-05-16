//
//  RollerPosition.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import CoreGraphics

public enum RollerPosition: Equatable {
    case left
    case right
    
    internal func position(_ frame: CGRect) -> CGPoint {
        let x: CGFloat
        switch self {
        case .left:
            x = (frame.width / 3) + 30
        case .right:
            x = (frame.width / 3) + (frame.width / 6) + 30
        }
        return CGPoint(x: x, y: 0.0)
    }
    
    internal func x(_ frame: CGRect) -> CGFloat {
        switch self {
        case .left:
            return (frame.width / 3) + 30
        case .right:
            return (frame.width / 3) + (frame.width / 6) + 30
        }
    }
}
