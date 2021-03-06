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

import Foundation

class Node {

  // data members
  var matches: Int
  var level: Int
  var value: Int = 0
  var children: [Node] = []
  var ab: (a: Int, b: Int)

  // constructor
  init(matches: Int, level: Int) {
    self.matches = matches
    self.level = level
    self.ab.a = -1
    self.ab.b = 1
    setValue()
  }

  // set value of node based on level (odd is min, even is max)
  func setValue() {
    if (matches == 1) {
      value = level % 2 == 1 ? 1 : -1
    }
  }

  func isMax() -> Bool {
    return level % 2 == 0
  }

  // adds child to node
  func addChild(child: Node) {
    children.append(child)
    // set value of parent based on rightmost child which will be the max or min value
    // value = child.value
  }

  // recursively expands game tree
  func expand() -> Int {
    if matches == 1 {
      return 0
    }
    for i in 1...3 {
      if matches > (4-i) && ab.b != ab.a {
        // max algorithm
        if isMax() && ab.b != ab.a {
          var node = Node(matches: matches-(4-i), level: level+1)
          node.expand()
          ab.a = node.ab.b
          value = ab.a
          addChild(node)
        }
        // min algorithm
        else {
          var node = Node(matches: matches-(4-i), level: level+1)
          node.expand()
          ab.b = node.ab.a
          value = ab.b
          addChild(node)
        }
        // add conditionals to only add children which survive pruning

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

  // function to determine number of empty arrays which need to be initialized
  func f(x: Int) -> Int {
    var dec = 0.5 * Double(x) - 0.5
    var result : Double = dec
    if (floor(dec) % 2 == 1) {
      result = ceil(dec)
    }
    else if (ceil(dec) % 2 == 1) {
      result = floor(dec)
    }
    //println(Int(result))
    return Int(result)
  }
  // constructor
  init(head: Node) {
    self.head = head
    self.head.expand()
    for x in 2...(head.matches-f(head.matches)) {
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
