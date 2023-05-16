//
//  PotHole.swift
//  PotholeRoller
//
//  Created by Dimas Prabowo on 20/04/23.
//

import CoreGraphics

public enum PotHole: Equatable {
    case green
    case yellow
    case red
    
    public var name: String {
        switch self {
        case .green:
            return ObjectName.greenHole.rawValue
        case .yellow:
            return ObjectName.yellowHole.rawValue
        case .red:
            return ObjectName.redHole.rawValue
        }
    }
    
    public var imageName: String {
        let index: UInt8 = .random(in: 0...1)
        switch self {
        case .green:
            return "pothole_green_\(index)"
        case .yellow:
            return "pothole_yellow_\(index)"
        case .red:
            return "pothole_red_\(index)"
        }
    }
    
    // Handle showing hole possibility
    public static var holes: [PotHole] {
        [
            .green,
            .green,
            .green,
            .green,
            .green,
            .green,
            .yellow,
            .yellow,
            .yellow,
            .yellow,
            .red,
            .red
        ]
    }
    
    public static func holePositions(_ frame: CGRect, holeHeight: CGFloat) -> [CGPoint] {
        let leftPosition = CGPoint(
            x: RollerPosition.left.x(frame),
            y: frame.size.height
        )
        
        let rightPosition = CGPoint(
            x: RollerPosition.right.x(frame),
            y: frame.size.height + 3 * holeHeight
        )
        
        return [
            leftPosition,
            rightPosition
        ]
    }
}
