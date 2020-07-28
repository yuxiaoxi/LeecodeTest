//
//  BHeap.swift
//  LLSRouterControllerDemo
//
//  Created by zhuo yu on 2020/4/24.
//  Copyright © 2020 LAIIX. All rights reserved.
//

import Foundation

// 二叉堆
class BHeap {
  
  private var pq: [Int]
  
  private var n: Int = 0
  
  init() {
    self.pq = []
  }
  
  func parent(root: Int) -> Int {
    return root/2
  }
  
  func left(root: Int) -> Int {
    return root * 2
  }
  
  func right(root: Int) -> Int {
    return root * 2 + 1
  }
  
  func deleteMax() -> Int {
    let max = pq[1]
    exch(i: 1, j: n)
    pq.remove(at: n)
    n -= 1
    var head = 1
    sink(k: &head)
    return max
  }
  
  func insert(key: Int) {
    n += 1
    // 放到尾部
    pq[n] = key
    // 开始上浮到合适位置
    swim(k: &n)
  }
  
  // 上浮第 k 个元素
  func swim(k: inout Int) {
    while k > 1 && less(i: parent(root: k), j: k) {
      if pq[k] > pq[parent(root: k)] {
        exch(i: k, j: parent(root: k))
        k = parent(root: k)
      }
    }
  }
  
  func sink(k: inout Int) {
    while left(root: k) <= n {
      var index = left(root: k) // 默认用左节点
      if right(root: k) >= n && less(i: pq[index], j: pq[right(root: k)]) {
        // 右节点的大一些
        index = right(root: right(root: k))
      }
      if less(i: pq[index], j: pq[k]) {
        break
      }
      exch(i: index, j: k)
      k = index
    }
  }
  
  func max() -> Int {
    return pq[1]
  }
  
  func exch(i: Int, j: Int) -> Void {
    let tmp = pq[i]
    pq[i] = pq[j]
    pq[j] = tmp
  }
  
  func less(i: Int, j: Int) -> Bool {
    return i < j
  }
}
