/* CSCE 420: Programming Assignment 2
/ Kyle Wilson
/
/ Consider the following simple game played between two players.
/ A pile of n matches is placed between Alice and Bob.
/ Each player takes turns removing some matches from the pile, in an
/ alternating fashion.
/ Players are permitted remove one, two, or three matches in each turn.
/ The player who is forced to take the last match loses.
/
/ 1. Write a program that generates the game tree for this game for each of
/ n ∈ {3, 7, 15, 19} via the minimax algorithm.
/
/ 2. Extend your code to use alpha-beta pruning.
/
/ 3. Using the results from above synthesize a Moore machine for each of the
/ games (i.e., for the three values of n and whether you go first or second). */

// node representing a particular state in the game
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
    setValue()
  }

  // set value of node based on level (odd is min, even is max)
  func setValue() {
    value = level % 2 == 1 ? 1 : -1
  }

  // adds child to node
  func addChild(child: Node) {
    children.append(child)
    // set value of parent based on rightmost child which will be the max or min value
    value = child.value
  }

  // recursively expands game tree
  func expand() -> Int {
    if matches == 1 {
      return 0
    }
    for i in 2...4 {
      if matches >= i {
        var node = Node(matches: matches-(i-1), level: level+1)
        node.expand()
        // add conditionals to only add children which survive pruning
        addChild(node)
      }
    }
    return 0
  }

}

// game tree
class Tree {

  // head of the tree
  var head : Node
  var matrixRepresentation : [[[Int]]] = [[[]]]
  var nodeCount : Int = 0

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
    var matches = node.matches
    var children = node.children

    if level == 0 {
      matrixRepresentation[level][0] = [matches, value]
      nodeCount++
    }
    for n in children {
      traverse(n)
      matrixRepresentation[level+1].append([n.matches, n.value])
      nodeCount++
    }
  }

  // prints matrix representation of tree
  func printTree() {
    for x in matrixRepresentation {
      println(x)
    }
    println("Number of nodes: \(nodeCount)")
  }
}

// takes in # of matches, unwrapping optional int returned by toInt()
// catches input errors
if Process.arguments.count > 1 {
  if var argument = Process.arguments[1].toInt() {
    if argument <= 1 {
      println("Error: game must start with at least 2 matches")
    }
    else {
      var head = Node(matches: argument, level: 0)
      var tree = Tree(head: head)
      tree.printTree()
    }
  }
}
else {
  println("Error: please provide the number of matches as an argument")
}
