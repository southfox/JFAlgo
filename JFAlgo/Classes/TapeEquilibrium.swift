//
//  TapeEquilibrium.swift
//  Pods
//
//  Created by Javier Fuchs on 9/8/16.
//
//

import Foundation

// A non-empty zero-indexed array A consisting of N integers is given. Array A represents numbers on a tape.
//
// Any integer P, such that 0 < P < N, splits this tape into two non-empty parts: A[0], A[1], ..., A[P − 1] and A[P], A[P + 1], ..., A[N − 1].
//
// The difference between the two parts is the value of: |(A[0] + A[1] + ... + A[P − 1]) − (A[P] + A[P + 1] + ... + A[N − 1])|
//
// In other words, it is the absolute difference between the sum of the first part and the sum of the second part.
//
// For example, consider array A such that:
//
// A[0] = 3
// A[1] = 1
// A[2] = 2
// A[3] = 4
// A[4] = 3
// We can split this tape in four places:
//
// P = 1, difference = |3 − 10| = 7
// P = 2, difference = |4 − 9| = 5
// P = 3, difference = |6 − 7| = 1
// P = 4, difference = |10 − 3| = 7
// Write a function:
//
// public func solution(inout A : [Int]) -> Int
// that, given a non-empty zero-indexed array A of N integers, returns the minimal difference that can be achieved.
//
// For example, given:
//
// A[0] = 3
// A[1] = 1
// A[2] = 2
// A[3] = 4
// A[4] = 3
// the function should return 1, as explained above.
//
// Assume that:
//
// N is an integer within the range [2..100,000];
// each element of array A is an integer within the range [−1,000..1,000].
// Complexity:
//
// expected worst-case time complexity is O(N);
// expected worst-case space complexity is O(N), beyond input storage (not counting the storage required for input arguments).
// Elements of input arrays can be modified.


public class TapeEquilibrium : Algorithm {
    
    override public init() {
        super.init()
        input = Limit(min: 2, max: 100000)
        domain = Limit(min: -1000, max: 1000)
    }
   
    public override func generateDomain(number : Int) -> [Int]? {
        return super.generateRandom(input.min, max: number)
    }
    
    public override func solution(inout A : [Int]) -> Int {
        
        var min = self.domain.max*A.count
        let n = A.count
        for var i in 0..<n {
            var p1 = 0
            for k in 0...i {
                p1 += A[k]
            }
            var p2 = 0
            i = i + 1
            if i < n {
                for k in i..<n {
                    p2 += A[k]
                }
            }
            var diff = p1 - p2
            if diff < 0 {
                diff = diff * (-1)
            }
            if diff < min {
                min = diff
            }
        }
        return min
    }
}