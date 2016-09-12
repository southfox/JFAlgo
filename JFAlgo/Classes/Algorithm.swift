//
//  Algorithm.swift
//  Pods
//
//  Created by Javier Fuchs on 9/6/16.
//
//

import Foundation

public class Algorithm {
    struct Limit {
        var min : Int
        var max : Int
    }
    
    var input : Limit
    var domain : Limit
    
    public init() {
        input = Limit(min: 0, max: Int.max)
        domain = Limit(min: 0, max: Int.max)
    }
    
    public func checkDomainGenerator(number : Int) -> Bool {
        return number >= self.input.min && number <= self.input.max
    }
    
    public func domainErrorMessage() -> String {
        return "Number should be an integer within the range [\(self.input.min)..\(self.input.max)]"
    }
    
    public func generate(max : Int) -> [Int]? {
        var A = [Int]()
        let missing = arc4random() % 2 == 0 ? Int(arc4random() % UInt32(max)) : 0
        for n in self.domain.min...max {
            if n == missing { continue }
            A.append(n)
        }
        return A
    }
    
    public func generateRandom(min : Int, max : Int) -> [Int]? {
        var A = [Int]()
        for _ in min...max {
            let rnd = Int(arc4random() % UInt32(self.domain.max*2))
            let n = Int(self.domain.max - rnd)
            A.append(n)
        }
        return A
    }
    
    public func generateDomain(max : Int) -> [Int]? {
        return self.generate(max)
    }
    
    public func solution(N : Int) -> Int {
        assertionFailure("implement this method in the child class")
        return 0
    }
    
    public func solution(inout A : [Int]) -> Int {
        assertionFailure("implement this method in the child class")
        return 0
    }
    
    public func solution(inout A : [Int], K: Int) -> Int {
        assertionFailure("implement this method in the child class")
        return 0
    }
}