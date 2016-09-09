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
    
    public func generate(number : Int) -> [Int]? {
        var A = [Int]()
        let limit = number
        let missing = arc4random() % 2 == 0 ? Int(arc4random() % UInt32(limit)) : 0
        for n in self.domain.min...limit {
            if n == missing { continue }
            A.append(n)
        }
        return A
    }
    
    public func generateRandom(number : Int) -> [Int]? {
        var A = [Int]()
        let limit = number
        for _ in self.domain.min...limit {
            let rnd = Int(arc4random() % UInt32(self.domain.max*2))
            let n = Int(self.domain.max - rnd)
            A.append(n)
        }
        return A
    }
    
}