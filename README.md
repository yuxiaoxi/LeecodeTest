# LeecodeTest
刷力扣记录和心得
如果之前从没有对算法进行训练过，建议从二叉树开始刷，这样可以培养算法思维方式

## 二叉树篇
### 题1008 先序遍历构造二叉搜索树

条件: 给定一个先序遍历数组，然后排完序就是中序数组，这样根据中序和先序来还原一棵二叉树
思路: 一般要构造造二叉树需要两个遍历序列（先序、中序、后序选其二），由于是要构造二叉搜索树，所以有序数组即为中序遍历序列，这样我们就把将先序遍历的数组进行排序得到中序序列，然后根把先序和中序构建二叉搜索树
```swift
class Test1008 {
		var dic: [Int: Int] = [:]
		func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
			if preorder.count == 0 {
				return nil
			}
			var inorder: [Int] = preorder.sorted()
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
	}
```
