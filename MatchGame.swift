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
    for i in [2, 3, 4] {
      if (matches >= i) {
        var node = Node(matches: matches-(i-1), level: level+1)
        node.expand()
        addChild(node)
      }
    }
    return 0
  }

  // TODO: Recursive print
  func print() {
    for n in children {
      println(n.value)
    }
  }
}

var head = Node(matches: 2, level: 0)
head.expand()
head.print()
