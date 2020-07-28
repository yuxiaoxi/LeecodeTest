//
//  BinarySearch.swift
//  LLSRouterControllerDemo
//
//  Created by zhuo yu on 2020/4/26.
//  Copyright © 2020 LAIIX. All rights reserved.
//

import Foundation

class BinarySearch {
  
  func binarySearch(nums: [Int], target: Int) -> Int {
    
    var left = 0
    var right = nums.count - 1
    while left <= right {
      let mid = left + (right - left)/2
      if nums[mid] == target {
        return mid
      } else if nums[mid] < target {
        left = mid + 1
      } else if nums[mid] > target {
        right = mid - 1
      }
    }
    return -1
  }
  
  func binaryLeftBound(nums: [Int], target: Int) -> Int {
    guard nums.count > 0 else {
      return -1
    }
    
    var left = 0
    var right = nums.count
    while left < right {
      let mid = left + (right - left)/2
      if nums[mid] == target {
        right = mid
      } else if nums[mid] < target {
        left = mid + 1
      } else if nums[mid] > target {
        right = mid
      }
    }
    return left
  }
  
  func binaryRigthBound(nums: [Int], target: Int) -> Int {
    guard nums.count > 0 else {
      return -1
    }
    
    var left = 0
    var right = nums.count
    while left < right {
      let mid = left + (right - left)/2
      if nums[mid] == target {
        left = mid + 1
      } else if nums[mid] < target {
        left = mid + 1
      } else if nums[mid] > target {
        right = mid
      }
    }
    return right - 1
  }
}
