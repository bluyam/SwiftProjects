// CSCE 420: Programming Assignment 2
// Kyle Wilson

class Node {

  // data members
  var matches: Int
  var level: Int
  var value: Int = 0
  var children: [Node] = []

  // constructor
  init(matches: Int, level: Int) {
    self.matches = matches
    self.level = level
  }

  // adds child to node
  func addChild(node: Node) {
    children.append(node)
  }

  // recursively expands game tree
  func expand() -> Int {
    if (matches == 1) {
      value = level % 2 == 1 ? 1 : -1
      return 0
    }
    for i in 2...4 {
      if (matches >= i) {
        var node = Node(matches: matches-(i-1), level: level+1)
        node.expand()
        addChild(node)
      }
    }
    return 0
  }

}

class Tree {
  
  // head of the tree
  var head : Node
  var matrixRepresentation : [[Int]] = [[]]

  // constructor
  init(head: Node) {
    self.head = head
    self.head.expand()
    for x in 0...(head.matches-2) {
      matrixRepresentation.append([])
    }
    traverse(self.head)
  }

  // traverse tree to store data in a matrix
  // so that it can be displayed in a top down approach
  func traverse(node: Node) {
    var level = node.level
    var value = node.value
    var children = node.children

    if (level == 0) {
      matrixRepresentation[level].append(value)
    }
    for n in children {
      traverse(n)
      matrixRepresentation[level+1].append(n.value)
    }
  }

  // prints matrix representation of tree
  func printTree() {
    for x in matrixRepresentation {
      println(x)
    }
  }
}

var head = Node(matches: 4, level: 0)
var tree = Tree(head: head)
tree.printTree()
