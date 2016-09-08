//
//  Sort.swift
//  Pods
//
//  Created by Javier Fuchs on 9/7/16.
//
//

import Foundation

class Sort {
    class func buble(inout A : [Int]) {
        var n = A.count
        var swapped = false
        repeat {
            var newn = 0
            swapped = false
            for i in 1...n - 1 {
                if A[i - 1] > A[i] {
                    swap(&A, i: i, j: i - 1)
                    swapped = true
                    newn = i
                }
            }
            n = newn
            if n == 1 {
                break
            }
        } while swapped == false
    }

    class func bublesort2(inout A : [Int]) {
        var n = A.count
        var swapped = false
        repeat {
            swapped = false
            for i in 1...n - 1 {
                if A[i - 1] > A[i] {
                    swap(&A, i: i, j: i - 1)
                    swapped = true
                }
            }
            n = n - 1
            if n == 1 {
                break
            }
        } while swapped == false
    }

    class func shell(inout A : [Int]) {
        var n = A.count
        for gap in A {
            for var i = gap; i < n; i += 1 {
                let temp = A[i]
                var j = i
                for ; j >= gap && A[j - gap] > temp; j -= gap {
                    A[j] = A[j - gap]
                }
                A[j] = temp
            }
        }
    }

    class func quick(inout A : [Int]) {
        if A.count > 1 {
            quick(&A, lo: 0, hi: A.count-1)
        }
    }
    
    private class func quick(inout A : [Int], lo: Int, hi: Int) {
        if lo < hi {
            let pivot = lo
            var i = lo
            var j = hi
            while i < j {
                while A[i] <= A[pivot] && i < hi {
                    i = i + 1
                }
                while A[j] > A[pivot] {
                    j = j - 1
                }
                if i < j {
                    swap(&A, i: i, j: j)
                }
            }
            swap(&A, i: pivot, j: j)
            quick(&A, lo: lo, hi: j-1)
            quick(&A, lo: j+1, hi: hi)
        }
    }
    
    class func comb(inout A : [Int]) {
        var gap = A.count
        let shrink = 1.3
        var sorted = false
        
        while gap > 1 || sorted == false {
            let d = Double(gap) / shrink
            let f = floor(d)
            gap = Int(f)
            if gap < 1 {
                gap = 1
            }
            var i = 0
            
            if gap == 1 {
                sorted = true
            }
            
            while i + gap < A.count {
                if A[i] > A[i + gap] {
                    swap(&A, i: i, j: i + gap)
                    if gap == 1 {
                        sorted = false
                    }
                }
                i = i + 1
            }
        }
    }
    
    class func counting(inout A: [Int]) {
        var count = [Int: Int]()
        
        // calculate the histogram of key frequencies
        for x in A {
            if let c = count[x] {
                count[x] = c + 1
            } else {
                count[x] = 1
            }
        }
        
        // calculate the starting index for each key
        var total = 0
        for i in 0..<A.count {
            if let oldCount = count[i] {
                count[i] = total
                total = total + oldCount
            }
        }
        
        // copy to output array, preserving order of inputs with equal keys
        for x in A {
            if let c = count[x] {
                A[c] = x
                count[x] = c + 1
            }
        }
    }
    
    
    public class func swap(inout A: [Int], i : Int, j : Int) {
        let tmp = A[i]
        A[i] = A[j]
        A[j] = tmp
    }
}