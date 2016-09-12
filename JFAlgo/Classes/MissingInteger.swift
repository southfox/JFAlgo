//
//  MissingInteger.swift
//  Pods
//
//  Created by Javier Fuchs on 9/8/16.
//
//

import Foundation

/// Find the minimal positive integer not occurring in a given sequence.

/// Write a function:
///
/// public func solution(inout A : [Int]) -> Int
/// that, given a non-empty zero-indexed array A of N integers, returns the minimal positive integer (greater than 0) that does not occur in A.
///
/// For example, given:
///
/// A[0] = 1
/// A[1] = 3
/// A[2] = 6
/// A[3] = 4
/// A[4] = 1
/// A[5] = 2
/// the function should return 5.
///
/// Assume that:
///
/// N is an integer within the range [1..100,000];
/// each element of array A is an integer within the range [−2,147,483,648..2,147,483,647].
/// Complexity:
///
/// expected worst-case time complexity is O(N);
/// expected worst-case space complexity is O(N), beyond input storage (not counting the storage required for input arguments).
/// Elements of input arrays can be modified.

public class MissingInteger  : Algorithm{
    
    override public init() {
        super.init()
        input = Limit(min: 1, max: 100000)
        domain = Limit(min: -2147483648, max: 2147483647)
    }
    
    public override func generateDomain(number : Int) -> [Int]? {
        return super.generate(number)
    }
    
    public func solution(inout A : [Int], N : Int) -> Int {
        var count = [Int: Int]()
        
        // calculate the histogram of key frequencies
        for x in A {
            count[x] = 1
        }
        
        for n in self.input.min...(N) {
            guard let _ = count[n] else {
                return n
            }
        }
        return 0
    }
}
