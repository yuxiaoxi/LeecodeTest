//
//  File.swift
//  LLSRouterControllerDemo
//
//  Created by zhuo yu on 2020/4/23.
//  Copyright © 2020 LAIIX. All rights reserved.
//

import Foundation

// 二叉搜索树
class BSTree: NSObject {
  
  var tmpNode: TreeNode?
  
  func searchNode(root: TreeNode?, key: Int) -> TreeNode? {
    guard let root = root else {
      return nil
    }
    
    if searchNodeExist(root: root, key: key) {
      return tmpNode
    }
    
    return nil
  }
  
  func searchNodeExist(root: TreeNode?,  key: Int) -> Bool {
    guard let root = root else {
      return false
    }
    
    if root.val == key {
      tmpNode = root
      return true
    } else if root.val < key {
      return searchNodeExist(root: root.right, key: key)
    } else {
      return searchNodeExist(root: root.left, key: key)
    }
  }
  
  func insertNode(root: TreeNode?, key: Int) -> TreeNode? {
    guard let root = root else {
      return TreeNode(key)
    }
    if root.val < key {
      root.right = insertNode(root: root.right, key: key)
    }
    if root.val > key {
      root.left =  insertNode(root: root.left, key: key)
    }
    
    return root
  }
  
  func deleteNode(root: TreeNode?, key: Int) -> TreeNode? {
    
    // 做一些判空处理，和边界条界处理
    guard let root = root else {
      return nil
    }
    
    // 找到目标值时进行删除
    if root.val == key {
      // 处理左或右子节点为空，包括两都都为空情况
      if root.left == nil {
        return root.right
      }
      if root.right == nil {
        return root.left
      }
      // 查找右子树最小的节点，即最左边的叶子节点
      let minVal = getMin(root: root.right)
      root.val = minVal
      root.right = deleteNode(root: root.right, key: minVal)
    }
    
    // 框架右边
    if root.val < key {
      root.right = deleteNode(root: root.right, key: key)
    }
    // 框架左边
    if root.val > key {
      root.left = deleteNode(root: root.left, key: key)
    }
    
    return root
  }
  
  func getMin(root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    if root.left != nil {
      return getMin(root: root.left)
    }
    
    return root.val
  }
  
  // 二叉搜索树遍历框架
  func BST(root: TreeNode?, key: Int) -> Void {
    guard let root = root else {
      return
    }
    if root.val == key {
      // 找到了，做些啥
    }
    if root.val < key {
      BST(root: root.right, key: key)
    }
    if root.val > key {
      BST(root: root.left, key: key)
    }
  }
}

class TreeNode {
  var right: TreeNode?
  var left: TreeNode?
  var val: Int
  
  init(left: TreeNode? = nil, right: TreeNode? = nil, _ val: Int) {
    self.right = right
    self.left = left
    self.val = val
  }
}

class BTree {
  func firstTravesal(root: TreeNode?) {
    guard let root = root else {
      return
    }
    /// 先序
    print(root.val)
    firstTravesal(root: root.left)
    firstTravesal(root: root.right)
  }
  
  func midTravesal(root: TreeNode?) {
    guard let root = root else {
      return
    }
    
    /// 中序
    firstTravesal(root: root.left)
    print(root.val)
    firstTravesal(root: root.right)
  }
  
  func lastTravesal(root: TreeNode?) {
    guard let root = root else {
      return
    }
    
    firstTravesal(root: root.left)
    firstTravesal(root: root.right)
    /// 后序
    print(root.val)
  }
  
  func getLevel(root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    if root.left == nil && root.right == nil {
      // 叶子节点高度
      return 1
    }
    
    let left = getLevel(root: root.left)
    let right = getLevel(root: root.right)
    let h = left > right ? left + 1 : right + 1
    return h
  }
  
  // 求普通二叉权的叶子节点数
  func getLeafNodeCount(root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    if root.left == nil && root.right == nil {
      // 叶子节点
      return 1
    }
    
    let left = getLeafNodeCount(root: root.left)
    let right = getLeafNodeCount(root: root.right)
    let c = left + right
    return c
  }
  
  func getNodeCount(root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    let left = getNodeCount(root: root.left)
    let right = getNodeCount(root: root.right)
    let c = left + right + 1
    return c
  }
  
  func countFullTreeNodes(root: inout TreeNode?) -> Int {
    
    if root == nil {
      return 0
    }
    
    var h = 0
    while root != nil {
      h += 1
      root = root!.left
    }
    let to = ("\(pow(2, h))" as NSString).integerValue
    return to - 1
  }
  
  func countTreeNodes(root: TreeNode?) -> Int {
    if root == nil {
      return 0
    }
    
    var lefth = 0
    var righth = 0
    var right = root
    var left = root
    
    while left != nil {
      lefth += 1
      left = left?.left
    }
    
    while right != nil {
      righth += 1
      right = right?.right
    }
    
    if lefth == righth {
      return ("\(pow(2, lefth))" as NSString).integerValue - 1
    }
    
    return 1 + countTreeNodes(root: root?.left) + countTreeNodes(root: root?.right)
  }
  
  /// 判断BT 是否平衡
  /// - Parameter root: 根结点
  func isBalanced(_ root: TreeNode?) -> Bool {
    return getBalancedNode(root).isBalance
  }
  
  private func getBalancedNode(_ root: TreeNode?) -> BalanceNode {
    guard let root = root else {
      return BalanceNode(0, true)
    }
    let left = getBalancedNode(root.left)
    let right = getBalancedNode(root.right)
    if abs(left.depth - right.depth) > 1 {
      return BalanceNode(0, false)
    }
    if !left.isBalance || !right.isBalance {
      return BalanceNode(0, false)
    }
    
    return BalanceNode(max(left.depth, right.depth) + 1, true)
  }
  
  private class BalanceNode {
    var isBalance: Bool
    var depth: Int
    init(_ depth: Int, _ isBalance: Bool) {
      self.depth = depth
      self.isBalance = isBalance
    }
  }
  
  func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
    
    guard let t1 = t1 else {
      return t2
    }
    
    guard let t2 = t2 else {
      return t1
    }
    
    let t = TreeNode(t1.val + t2.val)
    t.left = mergeTrees(t1.left, t2.left)
    t.right = mergeTrees(t1.right, t2.right)
    
    return t
  }
  
  /// 二叉树满足条件：
  /// 1、所有节点（根节点除w外）的入度都为1
  /// 2、根节点入度为0，但只有一个根节点
  /// 3、所有节点的出度小于等于2
  /// 4、当节点数大于1时，如果只有一根节，那这个根节点的出度要大于1
  func validateBinaryTreeNodes(_ n: Int, _ leftChild: [Int], _ rightChild: [Int]) -> Bool {
    
    // 只有一个节点情况
    if n == 1 {
      if leftChild[0] == -1 && rightChild[0] == -1 {
        return true
      }
      else {
        return false
      }
    }
    var show = [Int: Int]()
    var out = [Int: Int]()
    for index in 0..<n {
      show[index] = 0
      out[index] = 0
      // 统计出度
      if leftChild[index] != -1 {
        out[index] = out[index]! + 1
      }
      if rightChild[index] != -1 {
        out[index] = out[index]! + 1
      }
    }
    // 统计入度
    for i in 0..<n {
      let l = leftChild[i]
      if l != -1 {
        if show[l] == 1 {
          return false
        }
        show[l] = show[l]! + 1
      }
      let r = rightChild[i]
      if r != -1 {
        if show[r] == 1 {
          return false
        }
        show[r] = show[r]! + 1
      }
    }
    
    var rootCount = 0
    var rootIndex = 0
    for index in 0..<n {
      if show[index]! > 1 {
        return false
      }
      if show[index]! == 0 {
        rootCount += 1
        rootIndex = index
      }
    }
    // 根节点只有一个，并且根节点
    return rootCount == 1 && out[rootIndex]! > 0
  }
  
  
  func getLevel(_ root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    if root.left == nil && root.right == nil {
      return 1
    }
    
    return max(getLevel(root.left), getLevel(root.right)) + 1
  }
  
  /// 二叉树的广度优先遍历
  /// - Parameter root: 树根
  func BFS_Tree(_ root: TreeNode?) -> [Int] {
    guard let root = root else {
      return []
    }
    
    var res = [Int]()
    var queue = [TreeNode]()
    queue.append(root)
    
    while !queue.isEmpty {
      let node = queue.removeFirst()
      if let left = node.left {
        queue.append(left)
      }
      if let right = node.right {
        queue.append(right)
      }
      res.append(node.val)
    }
    
    return res
  }
  
  func DFS_Tree(_ root: TreeNode?) -> [String] {
    guard let root = root else {
      return []
    }
    
    var res = [String]()
    var queue = [TreeNode]()
    queue.append(root)
    
    while !queue.isEmpty {
      let node = queue.removeLast()
      res.append("\(node.val)")
      if let right = node.right {
        queue.append(right)
      }
      if let left = node.left {
        queue.append(left)
      }
    }
    return res
  }
  
  func BFS_Tree(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
      return []
    }
    
    var res = [[Int]]()
    var queue = [TreeNode]()
    queue.append(root)
    
    while !queue.isEmpty {
      
      let size = queue.count
      var re = [Int]()
      for _ in 0..<size {
        let node = queue.removeFirst()
        if let left = node.left {
          queue.append(left)
        }
        if let right = node.right {
          queue.append(right)
        }
        re.append(node.val)
      }
      res.append(re)
    }
    
    return res
  }
  
  func printTree(_ root: TreeNode?) -> [[String]] {
    guard let root = root else {
      return []
    }
    
    var res = [[String]]()
    var queue = [TreeNode]()
    queue.append(root)
    while !queue.isEmpty {
      let len = queue.count
      var re = [String]()
      for _ in 0..<len {
        let node = queue.removeFirst()
        re.append("\(node.val)")
        if let left = node.left {
          queue.append(left)
        } else {
          re.append("")
        }
        if let right = node.right {
          queue.append(right)
        } else {
          re.append("")
        }
        
      }
      res.append(re)
    }
    
    return res
  }
  
  func isSymmetric(_ root: TreeNode?) -> Bool {
    
    guard let root = root else {
      return true
    }
    
    return isSymmetric(root)
  }
  
  func isSymmetric(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
    
    if left == nil && right == nil {
      return true
    }
    
    guard let left = left else {
      return false
    }
    
    guard let right = right else {
      return false
    }
    
    if left.left?.val == right.right?.val {
      return true
    }
    
    return isSymmetric(left.left, right.right) && isSymmetric(left.right,right.left)
    
  }
  
  private class TreeNodeType {
    var right: TreeNode?
    var left: TreeNode?
    var val: Int
    var isLeft: Bool
    
    init(left: TreeNode? = nil, right: TreeNode? = nil, _ val: Int, _ isLeft: Bool) {
      self.right = right
      self.left = left
      self.val = val
      self.isLeft = isLeft
    }
  }
  
}
