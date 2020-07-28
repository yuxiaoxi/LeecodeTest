//
//  LeecodeTest.swift
//  LLSRouterControllerDemo
//
//  Created by zhuo yu on 2020/7/28.
//  Copyright © 2020 LAIIX. All rights reserved.
//

import Foundation

class LeecodeTest {
  
  /// 先序遍历构造二叉搜索树
  /// 给定一个先序遍历数组，然后排完序就是中序数组，这样根据中序和先序来还原一棵二叉树
  class Test1008 {
    var dic: [Int: Int] = [:]
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
      if preorder.count == 0 {
        return nil
      }
      var inorder: [Int] = preorder
      quickSort(&inorder, 0, inorder.count-1)
      for i in 0..<inorder.count {
        dic[inorder[i]] = i
      }
      return buildTree(preorder, 0, preorder.count-1, inorder, 0, inorder.count-1)
    }
    
    func buildTree(_ preorder: [Int], _ preStart: Int, _ preEnd: Int, _ inorder: [Int], _ inStart: Int, _ inEnd: Int) -> TreeNode? {
      if preStart > preEnd || inStart > inEnd {
        return nil
      }
      let rootIndex = dic[preorder[preStart]]!
      let leftNums = rootIndex - inStart
      let root = TreeNode(preorder[preStart])
      root.left = buildTree(preorder, preStart+1, preStart + leftNums, inorder, inStart, rootIndex-1)
      root.right = buildTree(preorder, preStart + leftNums + 1, preEnd, inorder, rootIndex+1, inEnd)
      return root
    }
    
    func quickSort(_ nums: inout [Int], _ start: Int, _ end: Int) {
      if start < end {
        var i = start
        var j = end
        let key = nums[i]
        while i<j {
          while i<j && nums[j] >= key {
            j -= 1
          }
          nums[i] = nums[j]
          while i<j && nums[i] <= key {
            i += 1
          }
          nums[j] = nums[i]
        }
        nums[i] = key
        quickSort(&nums, start, i-1)
        quickSort(&nums, i+1, end)
      }
    }
  }
  
  /// 左叶子之和
  class Test404 {
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
      guard let root = root else {
        return res
      }
      sumOfLeftLeavesTmp(root, false)
      return res
    }
    var res: Int = 0
    func sumOfLeftLeavesTmp(_ root: TreeNode?, _ isLeft: Bool) {
      guard let root = root else {
        return
      }
      if root.left == nil && root.right == nil && isLeft {
        res += root.val
      }
      
      sumOfLeftLeavesTmp(root.left, true)
      sumOfLeftLeavesTmp(root.right, false)
    }
  }
  
  /// 祖父节点值为偶数的节点和
  class Test1315 {
    func sumEvenGrandparent(_ root: TreeNode?) -> Int {
      guard let root = root else {
        return res
      }
      tmp(root)
      return res
    }
    var res: Int = 0
    func tmp(_ root: TreeNode?) {
      guard let root = root else {
        return
      }
      if root.val%2 == 0 {
        if root.left?.left != nil {
          res += root.left!.left!.val
        }
        if root.left?.right != nil {
          res += root.left!.right!.val
        }
        if root.right?.left != nil {
          res += root.right!.left!.val
        }
        if root.right?.right != nil {
          res += root.right!.right!.val
        }
      }
      tmp(root.left)
      tmp(root.right)
    }
  }
  
  /// 翻转等价二叉树
  class Test951 {
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
      if root1 == nil && root2 == nil {
        return true
      }
      guard let root1 = root1 else {
        return false
      }
      guard let root2 = root2 else {
        return false
      }
      
      if root1.val != root2.val {
        return false
      }
      
      if !flipEquiv(root1.left, root2.left) {
        return flipEquiv(root1.left, root2.right) && flipEquiv(root1.right, root2.left)
      } else {
        return flipEquiv(root1.right, root2.right)
      }
    }
  }
  
  /// 二叉树中的列表
  class Test141 {
    func isSubPath(_ head: ListNode?, _ root: TreeNode?) -> Bool {
      guard let head = head  else {
        return true
      }
      guard let root = root else {
        return false
      }
      
      return isSubPathTmp(head, root) || isSubPath(head, root.left) || isSubPath(head, root.right)
    }
    
    func isSubPathTmp(_ head: ListNode?, _ root: TreeNode?) -> Bool {
      guard let head = head  else {
        return true
      }
      guard let root = root else {
        return false
      }
      
      if head.val == root.val {
        return isSubPathTmp(head.next, root.left) || isSubPathTmp(head.next, root.right)
      }
      return false
    }
  }
  
  /// 寻找目标路径和的条数
  class Test437 {
    func pathSum(_ root: TreeNode?, _ sum: Int) -> Int {
      guard let root = root else {
        return res
      }
      findPath(root, sum)
      _ = pathSum(root.left, sum)
      _ = pathSum(root.right, sum)
      return res
    }
    var res: Int = 0
    func findPath(_ root: TreeNode?, _ sum: Int) {
      guard let root = root else {
        return
      }
      
      if sum == root.val {
        res += 1
      }
      let extra = sum - root.val
      findPath(root.left, extra)
      findPath(root.right, extra)
    }
  }
  
  /// 寻找最大路径和
  class Test124 {
    var ans:Int?
    func maxPathSum(_ root: TreeNode?) -> Int {
      _ = oneSideMax(root)
      return ans ?? 0
    }
    
    func oneSideMax(_ root: TreeNode?) -> Int {
      guard let root = root else {
        return 0
      }
      
      let left = max(0, oneSideMax(root.left))
      let right = max(0, oneSideMax(root.right))
      if ans == nil {
        ans = left + right + root.val
      }
      ans = max(ans!, left + right + root.val)
      return max(left, right) + root.val
    }
  }
  
  /// 在每个树行中找最大值
  class Test515 {
    func largestValues(_ root: TreeNode?) -> [Int] {
      guard let root = root else {
        return []
      }
      var res: [Int] = []
      var queue: [TreeNode] = [root]
      while queue.count > 0 {
        var tmp: Int?
        let n = queue.count
        for _ in 0..<n {
          let node = queue.removeFirst()
          if tmp == nil {
            tmp = node.val
          } else {
            if tmp! < node.val {
              tmp = node.val
            }
          }
          if let left = node.left {
            queue.append(left)
          }
          if let right = node.right {
            queue.append(right)
          }
        }
        res.append(tmp!)
      }
      return res
    }
  }
  
  /// 平衡二叉树
  class Test110 {
    func isBalanced(_ root: TreeNode?) -> Bool {
      guard let root = root else {
        return true
      }
      
      let left = getHeight(root.left)
      let right = getHeight(root.right)
      if abs(left - right) > 1 {
        return false
      }
      return isBalanced(root.left) && isBalanced(root.right)
    }
    func getHeight(_ root: TreeNode?) -> Int {
      guard let root = root else {
        return 0
      }
      if root.left == nil && root.right == nil {
        return 1
      }
      return max(getHeight(root.left), getHeight(root.right)) + 1
    }
  }
}
