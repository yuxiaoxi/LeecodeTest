//
//  ListNode.swift
//  LLSRouterControllerDemo
//
//  Created by zhuo yu on 2020/5/7.
//  Copyright © 2020 LAIIX. All rights reserved.
//

import Foundation

private class ListNode {
  var val: Int
  var next: ListNode?
  init(val: Int, next: ListNode? = nil) {
    self.val = val
    self.next = next
  }
  
  /// 反转 条件：m <= n
  func revertListNode(head: ListNode?, m: Int, n: Int) -> ListNode? {
    if head == nil {
      return nil
    }
    
    var root = head
    var headCount = 0
    var first = head
    var revertList: [ListNode?] = []
    while root != nil {
      headCount += 1
      if headCount < m {
        first = first?.next
      } else if headCount >= m && headCount <= n {
        revertList.append(root)
      }
      root = root?.next
    }
    // 找到头
    var firstN = first?.next
    for node in revertList {
      firstN = node
      firstN = firstN?.next
    }
    firstN?.next = root
    
    return head
  }
  
  func reversalList(head: ListNode?, n: Int) -> ListNode? {
    if head?.next == nil {
      return head
    }
    
    var h = head
    var a = 0
    
    while h?.next != nil && a <= n {
      h = h?.next
      a += 1
    }
    
    let tail = h?.next
    h?.next = nil
    
    let nodeList = reversalListNode(head: head)
    let first = nodeList[0]
    let last = nodeList[1]
    last?.next = tail
    return first
  }
  
  func reversalListNode(head: ListNode?) -> [ListNode?] {
    if head?.next == nil {
      return [head, nil]
    }
    
    let last = reversalList(head: head?.next)
    head?.next?.next = head
    head?.next = nil
    return [last, head]
  }
  
  func reversalList(head: ListNode?) -> ListNode? {
    if head?.next == nil {
      return head
    }
    
    let last = reversalList(head: head?.next)
    head?.next?.next = head
    head?.next = nil
    return last
  }
  
  func singleNumbers(_ nums: [Int]) -> [Int] {
    let len = nums.count
    if len <= 2 {
      return nums
    }
    
    var tmpNums = [nums[0],nums[1]]
    for i in 2..<len {
      if tmpNums.contains(nums[i]) {
        tmpNums.removeAll { (num) -> Bool in
          return num == nums[i]
        }
      } else {
        tmpNums.append(nums[i])
      }
    }
    return tmpNums
  }
}
