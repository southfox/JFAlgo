//
//  FrogJmp.swift
//  Pods
//
//  Created by Javier Fuchs on 9/8/16.
//
//

import Foundation

/// A small frog wants to get to the other side of the road. The frog is currently located at position X and wants to get to a position greater than or equal to Y. The small frog always jumps a fixed distance, D.

/// Count the minimal number of jumps that the small frog must perform to reach its target.
///
/// Write a function:
///
/// public func solution(X : Int, _ Y : Int, _ D : Int) -> Int
/// that, given three integers X, Y and D, returns the minimal number of jumps from position X to a position equal to or greater than Y.
///
/// For example, given:
///
/// X = 10
/// Y = 85
/// D = 30
/// the function should return 3, because the frog will be positioned as follows:
///
/// after the first jump, at position 10 + 30 = 40
/// after the second jump, at position 10 + 30 + 30 = 70
/// after the third jump, at position 10 + 30 + 30 + 30 = 100
/// Assume that:
///
/// X, Y and D are integers within the range [1..1,000,000,000];
/// X ≤ Y.
/// Complexity:
///
/// expected worst-case time complexity is O(1);
/// expected worst-case space complexity is O(1).

public class FrogJmp : Algorithm {
    
    override public init() {
        super.init()
        input = Limit(min: 1, max: 1000000000)
    }
    
    public func checkXY(X: Int, _ Y: Int) -> Bool {
        return X >= Y
    }
    
    public func solution(X : Int, _ Y : Int, _ D : Int) -> Int {
        var jumps = 0
        var result = X
        while result <= Y {
            result = result + D
            jumps = jumps + 1
        }
        return jumps
    }
}