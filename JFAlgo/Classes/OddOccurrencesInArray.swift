//
//  OddOccurrencesInArray.swift
//  Pods
//
//  Created by Javier Fuchs on 9/6/16.
//
//

import Foundation

//  A non-empty zero-indexed array A consisting of N integers is given. The array contains an odd number of elements, and each element of the array can be paired with another element that has the same value, except for one element that is left unpaired.
//
//  For example, in array A such that:
//
//  A[0] = 9  A[1] = 3  A[2] = 9
//  A[3] = 3  A[4] = 9  A[5] = 7
//  A[6] = 9
//  the elements at indexes 0 and 2 have value 9,
//  the elements at indexes 1 and 3 have value 3,
//  the elements at indexes 4 and 6 have value 9,
//  the element at index 5 has value 7 and is unpaired.
//  Write a function:
//
//  public func solution(inout A : [Int]) -> Int
//  that, given an array A consisting of N integers fulfilling the above conditions, returns the value of the unpaired element.
//
//  For example, given array A such that:
//
//  A[0] = 9  A[1] = 3  A[2] = 9
//  A[3] = 3  A[4] = 9  A[5] = 7
//  A[6] = 9
//  the function should return 7, as explained in the example above.
//
//  Assume that:
//
//  N is an odd integer within the range [1..1,000,000];
//  each element of array A is an integer within the range [1..1,000,000,000];
//  all but one of the values in A occur an even number of times.
//  Complexity:
//
//  expected worst-case time complexity is O(N);
//  expected worst-case space complexity is O(1), beyond input storage (not counting the storage required for input arguments).
//  Elements of input arrays can be modified.

public class OddOccurrencesInArray  : Algorithm{
    
    override public init() {
        super.init()
        input = Limit(min: 1, max: 1000000)
        domain = Limit(min: 1, max: 1000000000)
    }
    
    public override func checkDomainGenerator(number : Int) -> Bool {
        return super.checkDomainGenerator(number) && (number % 2) == 0
    }
    
    public override func domainErrorMessage() -> String {
        return "Number should be an odd integer within the range [\(self.input.min)..\(self.input.max)]"
    }
    
    public override func generateDomain(number : Int) -> [Int]? {
        var A = [Int]()
        let limit = number / 2
        for _ in self.domain.min...limit {
            let rnd = arc4random() % UInt32(self.domain.max)
            A.append(Int(rnd))
            A.append(Int(rnd))
        }
        let oddPosition = arc4random() % UInt32(limit)
        let rnd = arc4random() % UInt32(self.domain.max)
        A[Int(oddPosition)] = Int(rnd)
        
        return A
    }
    
    public override func solution(inout A : [Int]) -> Int {
        var count = [Int: Int]()
        
        // calculate the histogram of key frequencies
        for x in A {
            if let c = count[x] {
                count[x] = c + 1
            } else {
                count[x] = 1
            }
        }
        
        for (k,v) in count {
            if v % 2 != 0 {
                return k
            }
        }
        
        return 0
    }
}