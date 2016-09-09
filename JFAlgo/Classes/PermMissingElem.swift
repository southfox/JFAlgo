//
//  PermMissingElem.swift
//  Pods
//
//  Created by Javier Fuchs on 9/8/16.
//
//

import Foundation

/// A zero-indexed array A consisting of N different integers is given. The array contains integers in the range [1..(N + 1)], which means that exactly one element is missing.
///
/// Your goal is to find that missing element.
///
/// Write a function:
///
/// int solution(int A[], int N);
/// that, given a zero-indexed array A, returns the value of the missing element.
///
/// For example, given array A such that:
///
/// A[0] = 2
/// A[1] = 3
/// A[2] = 1
/// A[3] = 5
/// the function should return 4, as it is the missing element.
///
/// Assume that:
///
/// N is an integer within the range [0..100,000];
/// the elements of A are all distinct;
/// each element of array A is an integer within the range [1..(N + 1)].
/// Complexity:
///
/// expected worst-case time complexity is O(N);
/// expected worst-case space complexity is O(1), beyond input storage (not counting the storage required for input arguments).
/// Elements of input arrays can be modified.
/// Copyright 2009–2016 by Codility Limited. All Rights Reserved. Unauthorized copying, publication or disclosure prohibited.


public class PermMissingElem  : Algorithm{
    
    struct constants {
        struct input {
            static let min = 0
            static let max = 100000
        }
        struct domain {
            static let min = 1
            static let increment = 1
        }
    }
    
    public class func checkDomainGenerator(number : Int) -> Bool {
        return number >= constants.input.min && number <= constants.input.max
    }
    
    public class func domainErrorMessage() -> String {
        return "Number should be an integer within the range [\(constants.input.min)..\(constants.input.max)]"
    }
    
    public class func generateDomain(number : Int) -> [Int]? {
        var A = [Int]()
        let limit = number
        let missing = Int(arc4random() % UInt32(limit))
        for n in 1...limit {
            if n == missing { continue }
            A.append(n)
        }
        return A
    }
    
    public class func solution(inout A : [Int], N : Int) -> Int {
        var count = [Int: Int]()
        
        // calculate the histogram of key frequencies
        for x in A {
            count[x] = 1
        }
        
        for n in 1...(N) {
            guard let _ = count[n] else {
                return n
            }
        }
        return -1
    }
}