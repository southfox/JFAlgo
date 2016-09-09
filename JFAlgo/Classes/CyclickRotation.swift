//
//  CyclickRotation.swift
//  Pods
//
//  Created by Javier Fuchs on 9/7/16.
//
//

import Foundation

// A zero-indexed array A consisting of N integers is given. Rotation of the array means that each element is shifted right by one index, and the last element of the array is also moved to the first place.
//
// For example, the rotation of array A = [3, 8, 9, 7, 6] is [6, 3, 8, 9, 7]. The goal is to rotate array A K times; that is, each element of A will be shifted to the right by K indexes.
//
// Write a function:
//
// public func solution(inout A : [Int], _ K : Int) -> [Int]
// that, given a zero-indexed array A consisting of N integers and an integer K, returns the array A rotated K times.
//
// For example, given array A = [3, 8, 9, 7, 6] and K = 3, the function should return [9, 7, 6, 3, 8].
//
// Assume that:
//
// N and K are integers within the range [0..100];
// each element of array A is an integer within the range [−1,000..1,000].
// In your solution, focus on correctness. The performance of your solution will not be the focus of the assessment.


public class CyclickRotation : Algorithm {
    
    override public init() {
        super.init()
        input = Limit(min: 0, max: 100)
        domain = Limit(min: -1000, max: 1000)
    }
    
    public func generateDomain(number : Int) -> [Int]? {
        return super.generateRandom(number)
    }
    
    public func solution(inout A : [Int], _ K: Int) {
        for _ in 0..<K {
            for i in 1..<A.count {
                Sort.swap(&A, i: i, j: i - 1)
            }
        }
    }
}