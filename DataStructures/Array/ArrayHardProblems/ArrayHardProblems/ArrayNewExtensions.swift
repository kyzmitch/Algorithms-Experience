//
//  ArrayNewExtensions.swift
//  ArrayHardProblems
//
//  Created by admin on 16/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

extension Array where Iterator.Element == Int {
    func allPossibleSubsets() -> [[Element]] {
        // https://leetcode.com/problems/subsets/description/
        // https://www.geeksforgeeks.org/finding-all-subsets-of-a-given-set-in-java/
        // this task in other words in mathematical words is:
        // Number of k-combinations for all k
        // https://en.wikipedia.org/wiki/Combination#Number_of_k-combinations_for_all_k
        // The number of k-combinations for all k is the number of subsets of a set of n elements. There are several ways to see that this number is 2^n
        // https://en.wikipedia.org/wiki/Binomial_coefficient#Sum_of_coefficients_row
        if count == 1 {
            return [self]
        }
        let n = 1 << count // 2^n
        var result = [[Element]]()
        for i in (0..<n) {
            var subset = [Element]()
            for j in (0..<n) {
                if i & (1 << j) > 0 {
                    subset.append(self[j])
                }
            }
            result.append(subset)
        }
        
        // O((2^n)*n) very bad
        return result
    }
    
    func lengthsSum() -> Int {
        // sum of lengths of contiguous subarrays having all elements distinct.
        // contiguous - прилегающий
        // distinct - отчетливый?
        
        // https://www.geeksforgeeks.org/subarrays-distinct-elements/
        /*
         Input :  arr[] = {1, 2, 3}
         Output : 10
         {1, 2, 3} is a subarray of length 3 with
         distinct elements. Total length of length
         three = 3.
         {1, 2}, {2, 3} are 2 subarray of length 2
         with distinct elements. Total length of
         lengths two = 2 + 2 = 4
         {1}, {2}, {3} are 3 subarrays of length 1
         with distinct element. Total lengths of
         length one = 1 + 1 + 1 = 3
         Sum of lengths = 3 + 4 + 3 = 10
         
         Input :  arr[] = {1, 2, 1}
         Output : 7
         
         Input :  arr[] = {1, 2, 3, 4}
         Output : 20
         */
        
        return 0
    }
}

