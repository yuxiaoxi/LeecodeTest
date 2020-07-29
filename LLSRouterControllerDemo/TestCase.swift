//
//  TestCase.swift
//  StarLordSample
//
//  Created by zhuo yu on 2020/7/8.
//  Copyright © 2020 LLS iOS Team. All rights reserved.
//

import Foundation

class BinarySearchTree {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?
  
  init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
    self.val = val
    self.left = left
    self.right = right
  }
  
  static func insertNode(root: TreeNode?, key: Int) -> TreeNode {
    guard let root = root else {
      return TreeNode(key)
    }
    
    if root.val < key {
      root.right = insertNode(root: root.right, key: key)
    }
    
    if root.val > key {
      root.left = insertNode(root: root.left, key: key)
    }
    
    return root
  }
  
  static func getMinVal(root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    if root.left != nil {
      return getMinVal(root: root.left)
    }
    
    return root.val
  }
  
  func BSTFrame(root: TreeNode?, key: Int) -> Void {
    guard let root = root else {
      return
    }
    
    if root.val == key {
      
    }
    if root.val < key {
      BSTFrame(root: root.right, key: key)
    }
    if root.val > key {
      BSTFrame(root: root.left, key: key)
    }
  }
  
  static func search(root: TreeNode?, target: Int) -> Bool {
    guard let root = root else {
      return false
    }
    
    if root.val == target {
      return true
    }
    if root.val < target {
      return search(root: root.right, target: target)
    }
    if root.val > target {
      return search(root: root.left, target: target)
    }
    
    return false
  }
  
  static func deleteNode(root: TreeNode?, key: Int) -> TreeNode? {
    guard let root = root else {
      return nil
    }
    
    if root.val == key {
      if root.left == nil {
        return root.right
      }
      if root.right == nil {
        return root.left
      }
      
      let min = getMinVal(root: root.right)
      root.val = min
      root.right = deleteNode(root: root.right, key: min)
    }
    if root.val < key {
      root.right = deleteNode(root: root.right, key: key)
    }
    if root.val > key {
      root.left = deleteNode(root: root.left, key: key)
    }
    
    return root
  }
  
  static func rootFirst(root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    print("val: ", root.val)
    rootFirst(root: root.left)
    rootFirst(root: root.right)
  }
  
  static func rootMidum(root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    rootMidum(root: root.left)
    print("val: ", root.val)
    rootMidum(root: root.right)
  }
  
  static func rootLast(root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    rootLast(root: root.left)
    rootLast(root: root.right)
    print("val: ", root.val)
  }
  
  static func BFS(root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    var nodes: [TreeNode] = [root]
    while nodes.count > 0 {
      let node = nodes.removeFirst()
      print(node.val)
      if node.left != nil {
        nodes.append(node.left!)
      }
      if node.right != nil {
        nodes.append(node.right!)
      }
    }
  }
  
  static func DFS(root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    var nodes: [TreeNode] = [root]
    while nodes.count > 0 {
      let node = nodes.removeLast()
      if node.right != nil {
        nodes.append(node.right!)
      }
      if node.left != nil {
        nodes.append(node.left!)
      }
      print("--->", node.val)
    }
  }
  
  static func getLevel(root: TreeNode?) -> Int {
    guard let root = root else {
      return 0
    }
    
    if root.left == nil && root.right == nil {
      return 1
    }
    
    let lHeight = getLevel(root: root.left)
    let rHeight = getLevel(root: root.right)
    
    return max(lHeight, rHeight) + 1
  }
  
  static func test() -> Void {
    let arr = [36,18,15,20,30,28,19,35,45,40,50]
    var root: TreeNode? = nil
    for val in arr {
      root = insertNode(root: root, key: val)
    }
    
    root = insertNode(root: root, key: 33)
    rootFirst(root: root)
    print("---------", getLevel(root: root))
    DFS(root: root)
  }
  
  static func binarySearch(arr: [Int], target: Int) -> Bool {
    
    var start = 0
    var end = arr.count - 1
    while start < end {
      let mid = start + (end - start)/2
      if arr[mid] == target {
        return true
      } else if arr[mid] < target {
        start = mid + 1
      } else if arr[mid] > target {
        end = mid - 1
      }
      
    }
    
    return false
  }
}

class Lee {
  func increasingBST(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else {
      return nil
    }
    
    
    midTraversal(root)
    return midRes
  }
  
  var midRes: TreeNode?
  var head: TreeNode?
  func midTraversal(_ root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    midTraversal(root.left)
    if midRes == nil {
      midRes = TreeNode(root.val)
      head = midRes
    } else {
      let node = TreeNode(root.val)
      head?.right = node
      head = node
    }
    midTraversal(root.right)
  }
  
  func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    if p == nil && q == nil {
      return true
    }
    
    if p?.val != q?.val {
      return false
    }
    return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
  }
  
  func minimumTotal(_ triangle: [[Int]]) -> Int {
    
    let n = triangle.count
    let arr: [Int] = [Int](repeating: 0, count: n)
    var f: [[Int]] = [[Int]](repeating: arr, count: n)
    f[0][0] = triangle[0][0]
    for i in 1..<n {
      f[i][0] = f[i-1][0] + triangle[i][0]
      for j in 1..<i {
        f[i][j] = min(f[i-1][j-1], f[i-1][j]) + triangle[i][j]
      }
      f[i][i] = f[i-1][i-1] + triangle[i][i]
    }
    var minTotal = f[n-1][0]
    
    for i in 1..<n {
      minTotal = min(minTotal, f[n-1][i])
    }
    return minTotal
  }
  
  func isSymmetric(_ root: TreeNode?) -> Bool {
    
    guard let root = root else {
      return true
    }
    
    return isSymmetric(root.left,root.right)
  }
  
  func isSymmetric(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
    
    if left == nil && right == nil {
      return true
    }
    
    guard let left = left, let right = right else {
      return false
    }
    
    if left.val != right.val {
      return false
    }
    
    return isSymmetric(left.left, right.right) && isSymmetric(left.right,right.left)
    
  }
  
  func isSymmetricRecu(_ root: TreeNode?) -> Bool {
    
    guard let root = root else {
      return true
    }
    
    var nodes: [NodeRes] = [NodeRes(root, true, true)]
    var res: Bool = true
    var co: Int = 0
    while nodes.count > 0 && res {
      let size = nodes.count
      co += 1
      var re = [NodeRes]()
      for _ in 0..<size {
        let node = nodes.removeFirst()
        let nodeRes = node.node
        if let left = nodeRes?.left {
          nodes.append(NodeRes(left, true, false, node))
        }
        if let right = nodeRes?.right {
          nodes.append(NodeRes(right, false, false, node))
        }
        re.append(node)
      }
      if re.count == 1 && !re[0].isRoot {
        res = false
        break
      }
      if re.count > 1 && re.count%2 != 0 {
        res = false
        break
      }
      if re.count > 1 {
        let n = re.count/2
        let l = re.count - 1
        for i in 0..<n {
          res = re[i].isLeft != re[l-i].isLeft && re[i].node?.val == re[l-i].node?.val
          if co > 2 {
            res = res && re[i].parent?.isLeft != re[l-i].parent?.isLeft
          }
          if !res {
            break
          }
        }
      }
    }
    
    return res
  }
  
  func isValidBST(_ root: TreeNode?) -> Bool {
    guard let root = root else {
      return true
    }
    
    if let left = root.left, root.val < left.val {
      return false
    }
    if let right = root.right, root.val > right.val {
      return false
    }
    
    if root.val < root.left!.val || root.val > root.right!.val {
      return false
    }
    
    return isValidBST(root.left) && isValidBST(root.right)
  }
  
  class NodeRes {
    let node: TreeNode?
    let isLeft: Bool
    let isRoot: Bool
    let parent: NodeRes?
    init(_ node: TreeNode?, _ isLeft: Bool, _ isRoot: Bool = false, _ parent: NodeRes? = nil){
      self.node = node
      self.isLeft = isLeft
      self.isRoot = isRoot
      self.parent = parent
    }
  }
  
  func levelTravesal(_ root: TreeNode?) -> Void {
    guard let root = root else {
      return
    }
    
    var res: [TreeNode] = [root]
    while res.count > 0 {
      let node = res.removeFirst()
      print(node.val)
      if node.left != nil {
        res.append(node.left!)
      }
      if node.right != nil {
        res.append(node.right!)
      }
    }
  }
  
  func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    if n <= 0 {
      return
    }
    var i: Int = 0
    var j: Int = 0
    var tmp: [Int] = []
    while i < m && j < n {
      if nums1[i] <= nums2[j] {
        tmp.append(nums1[i])
        i += 1
      } else {
        tmp.append(nums2[j])
        j += 1
      }
    }
    if i == m {
      for k in j..<n {
        tmp.append(nums2[k])
      }
    }
    if j == n {
      for k in i..<m {
        tmp.append(nums1[k])
      }
    }
    nums1 = tmp
  }
  
  func sortedNums(_ nums: inout [Int], _ start: Int, _ end: Int) -> Void {
    if start < end {
      var i = start
      var j = end
      let key = nums[i]
      while i < j {
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
      sortedNums(&nums, start, i-1)
      sortedNums(&nums, i+1, end)
    }
  }
  
  func mergeSort(_ nums: inout [Int]) {
    let n = nums.count
    if n < 1 {
      return
    }
    
  }
  
  func merge(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var res: [Int] = []
    var i = 0
    var j = 0
    while i < nums1.count && j < nums2.count {
      if nums1[i] <= nums2[j] {
        res.append(nums1[i])
        i += 1
      } else {
        res.append(nums2[j])
        j += 1
      }
    }
    if i == 0 {
      for k in j..<nums2.count {
        res.append(nums2[k])
      }
    }
    if j == 0 {
      for k in i..<nums1.count {
        res.append(nums1[k])
      }
    }
    
    return res
  }
  
  func missingNumber(_ nums: [Int]) -> Int {
    if nums.count < 1 {
      return 0
    }
    var res: Int = 0
    for i in 0..<nums.count {
      res += nums[i]
    }
    let tmp = (1 + nums.count) * (nums.count)/2
    return tmp - res
  }
  
  func isValid(_ s: String) -> Bool {
    if s.count == 0 {
      return true
    }
    
    let chars: [String] = s.map { String($0) }
    var queue: [String] = []
    for i in 0..<chars.count {
      if queue.count == 0 {
        queue.append(chars[i])
        continue
      }
      if isRight(queue.last!, chars[i]) {
        queue.removeLast()
      } else {
        queue.append(chars[i])
      }
    }
    return queue.count == 0
  }
  
  func isRight(_ s1: String, _ s2: String) -> Bool {
    switch s1 {
    case "(":
      return s2 == ")"
    case "[":
      return s2 == "]"
    case  "{":
      return s2 == "}"
    default:
      return false
    }
  }
  
  func generate(_ numRows: Int) -> [[Int]] {
    if numRows == 0 {
      return []
    }
    if numRows == 1 {
      return [[1]]
    }
    if numRows == 2 {
      return [[1],[1,1]]
    }
    var res: [[Int]] = [[1], [1,1]]
    for i in 2..<numRows {
      var tmp: [Int] = [1]
      for j in 1..<i {
        tmp.append(res[i-1][j-1] + res[i-1][j])
      }
      tmp.append(1)
      res.append(tmp)
    }
    return res
  }
  
  func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
      if nums1.count == 0 || nums2.count == 0 {
          return []
      }
      var res: Set<Int> = []
      var dic: [Int: Int] = [:]
      for num in nums1 {
          dic[num] = 1
      }
      for num in nums2 {
          if dic[num] == 1 {
              res.insert(num)
          }
      }
      return Array(res)
  }
  
  func numTrees(_ n: Int) -> Int {
      if n == 1 || n == 0 {
          return 1
      }
      if n == 2 {
          return  2
      }
      var res: Int = 0
      for i in 0..<n/2 {
          res = res + 2 * numTrees(i) * numTrees(n-i-1)
      }
      if n%2 == 1 {
          res = res + numTrees(n/2) * numTrees(n/2)
      }
      return res
  }
  
  func numTreesDp(_ n: Int) -> Int {
      var dp: [Int] = [1,1,2]
      if n < 3 {
          return dp[n]
      }
      for i in 3..<n+1 {
          tmpCall(&dp, i)
      }
      return dp[n]
  }

  func tmpCall(_ dp: inout [Int], _ n: Int) -> Void {
      var res: Int = 0
      for i in 0..<n/2 {
          res = res + 2 * dp[i] * dp[n-i-1]
      }
      if n%2 == 1 {
          res = res + dp[n/2] * dp[n/2]
      }
      dp.append(res)
  }
  
  static func createTreeNode(_ nums: [Int]) -> TreeNode? {
    let root = TreeNode(nums[0])
    var tmp: TreeNode? = root
    for i in 1..<nums.count {
      let node = TreeNode(nums[i])
      if nums[i] < tmp!.val {
        tmp?.left = node
      } else {
        tmp?.right = node
      }
      tmp = node
    }
    return root
  }
  
  static func serializeTreeNode(_ root: TreeNode?) -> [Int?] {
    guard let root = root else {
      return []
    }
    var queue: [TreeNode?] = [root]
    var res: [Int?] = []
    while queue.count > 0 {
      let node = queue.removeFirst()
      if let left = node?.left {
        queue.append(left)
      } else if node != nil {
        queue.append(nil)
      }
      if let right = node?.right {
        queue.append(right)
      } else if node != nil {
        queue.append(nil)
      }
      if node != nil {
        res.append(node!.val)
      } else {
        res.append(nil)
      }
    }
    let str = "\(res)"
    return res
  }
	
	func setZeroes(_ matrix: inout [[Int]]) {
			var rowSet: Set<Int> = []
			var columSet: Set<Int> = []
			let m = matrix.count
			let n = matrix[0].count
			for i in 0..<m {
					for j in 0..<n {
							if matrix[i][j] == 0 {
									rowSet.insert(i)
									columSet.insert(j)
							}
					}
			}
		for row in rowSet {
			for j in 0..<n {
				matrix[row][j] = 0
			}
		}
		
		for colum in columSet {
			for i in 0..<m {
				matrix[i][colum] = 0
			}
		}
	}
  
}
