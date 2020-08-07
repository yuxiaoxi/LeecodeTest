//
//  LeecodeTest.swift
//  LLSRouterControllerDemo
//
//  Created by zhuo yu on 2020/7/28.
//  Copyright © 2020 LAIIX. All rights reserved.
//

import Foundation

public class LeecodeTest {
	
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
	
	/// 两两交换链表中的节点
	class Test24 {
		func swapPairs(_ head: ListNode?) -> ListNode? {
			guard let head = head else {
				return nil
			}
			var h: ListNode? = head
			if let next = head.next {
				let nt = next.next
				next.next = head
				head.next = swapPairs(nt)
				h = next
			}
			return h
		}
	}
	
	class Test23 {
		func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
			if lists.count == 0 {
				return nil
			}
			return mergeK(lists)[0]
		}
		
		func mergeK(_ lists: [ListNode?]) -> [ListNode?] {
			var t: [ListNode?] = []
			for i in 0..<lists.count/2 {
				t.append(mergeList(lists[i], lists[lists.count-1-i]))
			}
			if lists.count%2 == 1 {
				t.append(lists[lists.count/2])
			}
			if t.count > 1 {
				t = mergeK(t)
			}
			return t
		}
		
		func mergeList(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
			guard let l1 = l1 else {
				return l2
			}
			guard let l2 = l2 else {
				return l1
			}
			
			var t: ListNode?
			var t1: ListNode? = l1
			var t2: ListNode? = l2
			if t1!.val < t2!.val {
				t = t1
				t1 = t1?.next
			} else {
				t = t2
				t2 = t2?.next
			}
			var tmp: ListNode? = t
			
			while t1 != nil && t2 != nil {
				if t1!.val < t2!.val {
					tmp?.next = t1
					t1 = t1?.next
				} else {
					tmp?.next = t2
					t2 = t2?.next
				}
				tmp = tmp?.next
			}
			if t1 == nil {
				tmp?.next = t2
			}
			if t2 == nil {
				tmp?.next = t1
			}
			return t
		}
	}
	
	/// K 个一组翻转链表
	class Test25 {
		var count: Int = 0
		func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
			guard let head = head else {
				return nil
			}
			if k == 0 || k == 1 {
				return head
			}
			var t: ListNode? = head
			var h: ListNode? = head
			var last: ListNode?
			var reList: ListNode?
			while t != nil {
				if count == (k-1){
					let tmp = t?.next
					t?.next = nil
					t = tmp
					let arr = reverseList(h)
					let f = arr[0]
					let l = arr[1]
					if reList == nil {
						reList = f
						last = l
					} else {
						last?.next = f
						last = l
					}
					h = tmp
					count = 0
				} else {
					count += 1
					t = t?.next
				}
			}
			if h != nil {
				last?.next = h
			}
			
			return reList
		}
		
		func reverseList(_ head: ListNode?) -> [ListNode?] {
			guard let head = head else {
				return [nil, nil]
			}
			
			if head.next == nil {
				return [head, nil]
			}
			let node = reverseList(head.next)[0]
			head.next?.next = head
			head.next = nil
			return [node, head]
		}
	}
	
	/// 三数之和
	class Test15 {
		func threeSum(_ nums: [Int]) -> [[Int]] {
			if nums.count < 3 {
				return []
			}
			let nums = nums.sorted()
			var res: [[Int]] = []
			if nums[0] > 0 || nums[nums.count-1] < 0 {
				return res
			}
			var tag: Bool = false
			if nums[0]<=0 && nums[nums.count-1]>=0 {
				for i in 0..<nums.count-2 {
					if !tag {
						var first = i+1
						var last = nums.count - 1
						while first < last {
							if nums[i] * nums[last] > 0 {
								break
							}
							let re = nums[i] + nums[first] + nums[last]
							if re == 0 {
								res.append([nums[i], nums[first], nums[last]])
							}
							if re <= 0 {
								repeat {
									first += 1
								} while first < last && nums[first] == nums[first-1]
								
							}
							if re > 0 {
								repeat {
									last -= 1
								} while last > first && nums[last] == nums[last+1]
							}
						}
					}
					if i+1 < nums.count-2 && nums[i+1]>0 {
						break
					}
					
					if i+1 < nums.count-2 && (nums[i+1] == nums[i]){
						tag = true
					} else {
						tag = false
					}
				}
			}
			
			return res
		}
	}
	
	/// 搜索旋转排序数组
	class Test33 {
		func search(_ nums: [Int], _ target: Int) -> Int {
			if nums.count == 0 {
				return -1
			}
			let n = nums.count
			var roIndex: Int = 0
			for i in 0..<nums.count-1 {
				if nums[i+1] < nums[i] {
					roIndex = i+1
					break
				}
			}
			if nums[n-1] >= target {
				var start = roIndex
				var end = n-1
				while start <= end {
					let mid = start + (end - start)/2
					if nums[mid] == target {
						return mid
					}
					if nums[mid] < target {
						start = mid + 1
					}
					if nums[mid] > target {
						end = mid - 1
					}
				}
			} else {
				var start = 0
				var end = roIndex - 1
				while start <= end {
					let mid = start + (end - start)/2
					if nums[mid] == target {
						return mid
					}
					if nums[mid] < target {
						start = mid + 1
					}
					if nums[mid] > target {
						end = mid - 1
					}
				}
			}
			
			return -1
		}
	}
	
	class Test240 {
		func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
			if matrix.count == 0 {
				return false
			}
			let m = matrix.count
			let n = matrix[0].count
			let x = min(m,n)
			var start = 0
			var end = x - 1
			while start <= end {
				let mid = start + (end - start)/2
				if matrix[mid][mid] == target {
					return true
				}
				if matrix[mid][mid] < target {
					start = mid + 1
				}
				if matrix[mid][mid] > target {
					end = mid - 1
				}
			}
			let z = min(start, end)
			if z+1 < m {
				
				for i in (z+1)..<m {
					if binarySeach(matrix[i], target, z) {
						return true
					}
				}
			}
			if z+1 < n {
				var tmp: [Int] = []
				for i in (z+1)..<n {
					tmp = []
					for j in 0..<(z+1) {
						tmp.append(matrix[j][i])
					}
					if binarySeach(tmp, target, tmp.count - 1) {
						return true
					}
				}
			}
			return false
		}
		
		func binarySeach(_ nums: [Int], _ key: Int, _ end: Int) -> Bool {
			var start = 0
			var end = end
			while start <= end {
				let mid = start + (end - start)/2
				if nums[mid] == key {
					return true
				}
				if nums[mid] < key {
					start = mid + 1
				}
				if nums[mid] > key {
					end = mid - 1
				}
			}
			return false
		}
	}
	class Test3 {
		func lengthOfLongestSubstring(_ s: String) -> Int {
			if s.count == 0 {
				return 0
			}
			let chars: [Character] = s.map { $0 }
			var tmp: [Character] = [chars[0]]
			var i: Int = 0
			var j: Int = 1
			var maxLen: Int = 1
			while i < chars.count-1 && j < chars.count {
				if tmp.contains(chars[j]) {
					if tmp[0] == chars[j] {
						tmp.removeFirst()
						tmp.append(chars[j])
						j += 1
						continue
					}
					if tmp.last! == chars[j] {
						i = j
						maxLen = max(maxLen, tmp.count)
						tmp = [chars[j]]
						j += 1
						continue
					}
					
					i += 1
					j = i + 1
					maxLen = max(maxLen, tmp.count)
					tmp = [chars[i]]
				} else {
					tmp.append(chars[j])
					j += 1
				}
			}
			return max(maxLen, tmp.count)
		}
		
		func lengthOfLongestSubstring1(_ s: String) -> Int {
			if s.count == 0 {
				return 0
			}
			var end = 0
			var start = 0
			var lentgh = 0
			var numDict: [Character : Int] = [:]
			for char in s {
				if let old = numDict[char] {
					start = max(start, old)
				}
				lentgh = max(lentgh, end - start + 1)
				end += 1
				numDict[char] = end
			}
			return lentgh
		}
	}
	
	/// 最长回文子串
	class Test5 {
		func longestPalindrome(_ s: String) -> String {
			if s.count == 0 {
				return ""
			}
			if s.count == 1 {
				return s
			}
			let chars = s.map { $0 }
			
			var i = 0
			var j = 1
			var dic: [Int: String] = [:]
			var maxLen: Int = 1
			while i<chars.count-maxLen && j<chars.count {
				if j-i >= 1 && isPalindrome(chars, i, j) && j-i+1 > maxLen {
					maxLen = j-i+1
					if j-i+1 == maxLen {
						dic[maxLen] = String(chars[i...j])
					}
					j += 1
				} else {
					if j == chars.count-1 && i<chars.count-maxLen {
						i += 1
						j = i+1
						continue
					}
					j += 1
				}
			}
			for key in dic.keys {
				if key == maxLen {
					return dic[key]!
				}
			}
			return String(chars[0])
		}
		
		func isPalindrome(_ chars: [Character], _ start: Int, _ end: Int) -> Bool {
			for i in start..<(start+end+1)/2 {
				if chars[i] != chars[end+start-i] {
					return false
				}
			}
			return true
		}
	}
	
	/// 有序链表转换二叉搜索树
	class Test109 {
		func sortedListToBST(_ head: ListNode?) -> TreeNode? {
			guard let head = head else {
				return nil
			}
			var nums: [Int] = []
			var tmp: ListNode? = head
			while tmp != nil {
				nums.append(tmp!.val)
				tmp = tmp?.next
			}
			return buildBinarySearchTree(nums, 0 , nums.count-1)
		}
		
		func buildBinarySearchTree(_ nums: [Int], _ start: Int, _ end: Int) -> TreeNode? {
			if start > end {
				return nil
			}
			if start == end {
				return TreeNode(nums[start])
			}
			
			let mid = start + (end-start)/2
			let root = TreeNode(nums[mid])
			root.left = buildBinarySearchTree(nums, start, mid-1)
			root.right = buildBinarySearchTree(nums, mid+1, end)
			return root
		}
	}
	
	class Test112 {
		func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
			guard let root = root else {
				return false
			}
			
			return findPath(root, sum)
		}
		
		func findPath(_ root: TreeNode?, _ sum: Int) -> Bool {
			guard let root = root else {
				return false
			}
			
			if root.left == nil && root.right == nil && root.val == sum {
				return true
			}
			return findPath(root.left, sum-root.val) || findPath(root.right, sum-root.val)
		}
	}
	
	class Test113 {
		func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
			guard let root = root else {
				return []
			}
			
			findPath(ParentTreeNode(root.val, nil, root), sum)
			return res
		}
		var res: [[Int]] = []
		func findPath(_ root: ParentTreeNode?, _ sum: Int) -> Void {
			guard let root = root else {
				return
			}
			
			if root.node?.left == nil && root.node?.right == nil && root.val == sum {
				var tmp: ParentTreeNode? = root
				var re: [Int] = []
				while tmp != nil {
					re.insert(tmp!.val, at: 0)
					tmp = tmp?.parent
				}
				res.append(re)
				return
			}
			if root.node?.left != nil {
				findPath(ParentTreeNode(root.node!.left!.val, root, root.node?.left), sum-root.val)
			}
			if root.node?.right != nil {
				findPath(ParentTreeNode(root.node!.right!.val, root, root.node?.right), sum-root.val)
			}
		}
		class ParentTreeNode {
			var left: ParentTreeNode?
			var right: ParentTreeNode?
			let parent: ParentTreeNode?
			let node: TreeNode?
			let val: Int
			init(_ val: Int, _ parent: ParentTreeNode?, _ node: TreeNode?) {
				self.val = val
				self.parent = parent
				self.node = node
			}
		}
	}
	
	class Test99 {
		func recoverTree(_ root: TreeNode?) {
			guard let root = root else {
				return
			}
			inorderTraversal(root)
			if num1 != nil && num2 != nil {
				var queue: [TreeNode] = [root]
				
				while queue.count > 0 {
					let node = queue.removeFirst()
					if let left = node.left {
						queue.append(left)
					}
					if let right = node.right {
						queue.append(right)
					}
					if node.val == num2! {
						node.val = num1!
						continue
					}
					if node.val == num1! {
						node.val = num2!
					}
				}
			}
		}
		
		var num1: Int?
		var num2: Int?
		var tmp: Int?
		func inorderTraversal(_ root: TreeNode?) -> Void {
			guard let root = root else {
				return
			}
			
			inorderTraversal(root.left)
			if tmp == nil {
				tmp = root.val
			} else {
				if tmp! > root.val && num1 == nil {
					num1 = tmp
				}
				if root.val < tmp! {
					num2 = root.val
				}
				tmp = root.val
			}
			inorderTraversal(root.right)
		}
	}
	
	/// N 叉树的最大深度
	class Test559 {
		func maxDepth(_ root: Node?) -> Int {
			guard let root = root else {
				return 0
			}
			if root.children.count == 0 {
				return 1
			}
			var maxH: Int = 0
			for child in root.children {
				maxH = max(maxH, maxDepth(child))
			}
			return maxH + 1
		}
	}
	
	/// 二叉树转为链表
	class Test114 {
		func flatten(_ root: TreeNode?) {
			guard let root = root else {
				return
			}
			
			var queue: [TreeNode] = [root]
			var tmp: TreeNode?
			while queue.count > 0 {
				let node = queue.removeLast()
				if let right = node.right {
					queue.append(right)
				}
				if let left = node.left {
					queue.append(left)
				}
				if tmp == nil {
					tmp = node
				} else {
					tmp?.left = nil
					tmp?.right = node
					tmp = tmp?.right
				}
			}
		}
	}
	
	/// 二叉树的序列化与反序列化
	class Test297 {
		func serialize(_ root: TreeNode?) -> String {
			guard let root = root else {
				return ""
			}
			var queue: [TreeNode?] = [root]
			var res: [String] = []
			while queue.count > 0 {
				let node = queue.removeFirst()
				if node != nil {
					queue.append(node?.left)
					queue.append(node?.right)
					res.append(String(node!.val))
				} else {
					res.append("null")
				}
			}
			var last = res.last
			while last != nil && last == "null" {
				res.removeLast()
				last = res.last
			}
			var str = "["
			for re in res {
				str.append(re + ",")
			}
			str.removeLast()
			str.append("]")
			return str
		}
		
		func deserialize(_ data: String) -> TreeNode? {
			var data = data
			if data.count == 0 {
				return nil
			}
			data.removeFirst()
			data.removeLast()
			let chars: [String] = data.split(separator: ",").map { String($0) }
			if chars.count == 0 {
				return nil
			}
			
			let root: TreeNode = TreeNode((chars[0] as NSString).integerValue)
			var queue: [TreeNode] = [root]
			var count: Int = 0
			while queue.count > 0 {
				let node = queue.removeFirst()
				let lIndex: Int = count*2 + 1
				let rIndex: Int = count*2 + 2
				if lIndex < chars.count && chars[lIndex] != "null" {
					let left = TreeNode((chars[lIndex] as NSString).integerValue)
					node.left = left
					queue.append(left)
				}
				if rIndex < chars.count && chars[rIndex] != "null" {
					let right = TreeNode((chars[rIndex] as NSString).integerValue)
					node.right = right
					queue.append(right)
				}
				count += 1
			}
			
			return root
		}
	}
	
	/// 删除排序链表中的重复元素 II
	class Test82 {
		func deleteDuplicates(_ head: ListNode?) -> ListNode? {
			guard let head = head else {
				return nil
			}
			
			var target: ListNode? = nil
			var first: ListNode? = head
			var tmp: ListNode? = first?.next
			var tag: Int = 0
			
			var t: ListNode? = nil
			while tmp != nil {
				if tmp!.val != first!.val {
					if tag == 0 {
						if target == nil {
							target = ListNode(first!.val)
							t = target
						} else {
							t?.next = ListNode(first!.val)
							t = t?.next
						}
					} else {
						tag = 0
					}
					first = tmp
				} else {
					tag += 1
				}
				tmp = tmp?.next
			}
			if target == nil && tag == 0 {
				return first
			}
			if t != nil && first!.val != t!.val && tag == 0 {
				t?.next = ListNode(first!.val)
			}
			
			return target
		}
	}
	
	class Test92 {
		func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
			guard let head = head else {
				return nil
			}
			if m == n {
				return head
			}
			var t: ListNode? = head
			var c: Int = 1
			var first: ListNode?
			var last: ListNode?
			var tmp: ListNode?
			while t != nil {
				if c == m-1 {
					tmp = t
				}
				if c == m {
					first = t
				}
				
				if c == n {
					last = t?.next
					t?.next = nil
					break
				}
				c += 1
				t = t?.next
			}
			let arr = reverseListNode(first)
			let f = arr[0]
			let l = arr[1]
			l?.next = last
			if tmp != nil {
				tmp?.next = f
			} else {
				return f
			}
			
			return head
		}
		
		func reverseListNode(_ head: ListNode?) -> [ListNode?] {
			guard let head = head else {
				return [nil, nil]
			}
			if head.next == nil {
				return [head, nil]
			}
			let node = reverseListNode(head.next)[0]
			head.next?.next = head
			head.next = nil
			return [node, head]
		}
	}
	
	class LRUCache {
		
		var sortArr: [Int] = []
		var dic: [Int: Int] = [:]
		var capacity: Int = 0
		
		init(_ capacity: Int) {
			self.capacity = capacity
		}
		
		func get(_ key: Int) -> Int {
			if dic[key] != nil {
				let index = sortArr.firstIndex(of: key)!
				sortArr.remove(at: index)
				sortArr.append(key)
				return dic[key]!
			}
			return -1
		}
		
		func put(_ key: Int, _ value: Int) {
			
			if dic[key] != nil {
				let index = sortArr.firstIndex(of: key)!
				sortArr.remove(at: index)
				sortArr.append(key)
			} else {
				if sortArr.count < capacity {
					sortArr.append(key)
				} else {
					let first = sortArr.removeFirst()
					dic.removeValue(forKey: first)
					sortArr.append(key)
				}
			}
			dic[key] = value
		}
	}
	
	/// 合并区间
	class Test56 {
		func merge(_ intervals: [[Int]]) -> [[Int]] {
			var res: [[Int]] = []
			var tmp: [Int] = []
			var needMerge: Bool = false
			var intervals = intervals
			quickSort(&intervals, 0 , intervals.count-1)
			for intval in intervals {
				if tmp.count == 0 {
					tmp = intval
					continue
				}
				var re: [Int] = []
				let l1 = tmp[0]
				let l2 = tmp[1]
				let l3 = intval[0]
				let l4 = intval[1]
				if l1 < l3 {
					if l2 >= l3 {
						if l4 > l2 {
							re = [l1,l4]
						} else {
							re = [l1,l2]
						}
						needMerge = true
						tmp = re
					} else {
						re = [l1,l2]
						tmp = intval
						res.append(re)
					}
				} else {
					if l4 >= l1 {
						if l2 > l4 {
							re = [l3,l2]
						}  else {
							re = [l3,l4]
						}
						needMerge = true
						tmp = re
					} else {
						re = [l1,l2]
						tmp = intval
						res.append(re)
					}
				}
			}
			if tmp.count > 0 {
				res.append(tmp)
			}
			if needMerge {
				needMerge = false
				res = merge(res)
			}
			return res
		}
		
		func quickSort(_ nums: inout [[Int]], _ start: Int, _ end: Int) {
			if start >= end {
				return
			}
			var i = start
			var j = end
			let tmp = nums[i]
			while i < j {
				while i<j && nums[j][0] >= tmp[0] {
					j -= 1
				}
				nums[i] = nums[j]
				while i<j && nums[i][0] <= tmp[0] {
					i += 1
				}
				nums[j] = nums[i]
			}
			nums[i] = tmp
			quickSort(&nums, start, i-1)
			quickSort(&nums, i+1, end)
		}
	}
	
	class Test55 {
		func canJump(_ nums: [Int]) -> Bool {
			if nums.count == 0 {
				return true
			}
			
			return canJumpTmp(nums, nums.count-1)
		}
		
		func canJumpTmp(_ nums: [Int], _ end: Int) -> Bool {
			var res: Bool = false
			if end == 0 {
				return true
			}
			for i in (0..<end).reversed() {
				if nums[i] >= end - i {
					return canJumpTmp(nums, i)
				}
			}
			
			return false
		}
	}
	
	class Test199 {
		
		/// 二叉树的右视图
		/// - Parameter root: <#root description#>
		/// - Returns: <#description#>
		func rightSideView(_ root: TreeNode?) -> [Int] {
			guard let root = root else {
				return []
			}
			var res: [Int] = []
			var queue: [TreeNode] = [root]
			while queue.count > 0 {
				let n = queue.count
				for i in 0..<n {
					let node = queue.removeFirst()
					if i == 0 {
						res.append(node.val)
					}
					if let right = node.right {
						queue.append(right)
					}
					if let left = node.left {
						queue.append(left)
					}
				}
			}
			return res
		}
		
		/// 二叉树的左视图
		/// - Parameter root: <#root description#>
		/// - Returns: <#description#>
		func leftSideView(_ root: TreeNode?) -> [Int] {
			guard let root = root else {
				return []
			}
			var res: [Int] = []
			var queue: [TreeNode] = [root]
			while queue.count > 0 {
				let n = queue.count
				for i in 0..<n {
					let node = queue.removeFirst()
					if i == 0 {
						res.append(node.val)
					}
					if let left = node.left {
						queue.append(left)
					}
					if let right = node.right {
						queue.append(right)
					}
				}
			}
			return res
		}
	}
	
	class Test4 {
		func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
			let nums = merge(nums1,nums2)
			let t = nums.count
			if t%2==0 {
				return Double((nums[t/2-1]+nums[t/2]))/2.0
			} else {
				return Double(nums[t/2])
			}
		}
		
		func merge(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
			var nums: [Int] = []
			var i: Int = 0
			var j: Int = 0
			while i<nums1.count && j<nums2.count {
				if nums1[i] <= nums2[j] {
					nums.append(nums1[i])
					i += 1
				} else {
					nums.append(nums2[j])
					j += 1
				}
			}
			if i == nums1.count {
				for k in j..<nums2.count {
					nums.append(nums2[k])
				}
			}
			if j == nums2.count {
				for k in i..<nums1.count {
					nums.append(nums1[k])
				}
			}
			return nums
		}
	}
	
	class Test561 {
		func arrayPairSum(_ nums: [Int]) -> Int {
			if nums.count == 0 {
				return 0
			}
			
			var nums = nums
			quickSort(&nums, 0, nums.count-1)
			var res: Int = 0
			for i in 0..<(nums.count/2) {
				res = res + nums[2*i]
			}
			return res
		}
		
		func quickSort(_ nums: inout [Int], _ start: Int, _ end: Int) {
			if start < end {
				var i = start
				var j = end
				var tmp = nums[i]
				while i<j {
					while i<j && nums[j] >= tmp {
						j -= 1
					}
					nums[i] = nums[j]
					while i<j && nums[i] <= tmp {
						i += 1
					}
					nums[j] = nums[i]
				}
				nums[i] = tmp
				quickSort(&nums, start, i-1)
				quickSort(&nums, i+1, end)
			}
		}
	}
}

class Node {
	var val: Int
	var children: [Node]
	init (_ val: Int, _ children: [Node]) {
		self.val = val
		self.children = children
	}
}
