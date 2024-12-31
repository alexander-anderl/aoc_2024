import Algorithms
import Foundation

struct Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var map: [[String]] {
    data.split(separator: "\n").map({ string in
      Array(string).map({String($0)})
    })
  }

  struct Container: CustomStringConvertible {
    var i: Int
    var j: Int

    init(i: Int, j: Int) {
      self.i = i
      self.j = j
    }

    var description: String {
      "(\(i),\(j))"
    }

    func inField(width: Int, height: Int) -> Bool {
      return (0..<width).contains(j) && (0..<height).contains(i)
    }
  }

  enum Direction {
    case left, up, down,right

    var rotateRight: Direction {
      switch self {
      case .left: return .up
      case .up: return .right
      case .right: return .down
      case .down: return .left
      }
    }
  }

  struct Pair {
    let first: Container
    let second: Container
  }

  func part1() -> Any {
    var map = self.map
    var pointer = Container(i: 0, j: 0)
    let width = map[0].count
    let height = map.count
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        if map[i][j] == "^" {
          pointer = Container(i: i, j: j)
        }
      }
    }
    var direction = Direction.up
    while pointer.inField(width: width, height: height) {
      print(pointer)
      var newPointer = pointer
      switch direction {
      case .down:
        newPointer.i += 1
      case .left:
        newPointer.j -= 1
      case .right:
        newPointer.j += 1
      case .up:
        newPointer.i -= 1
      }
      if newPointer.inField(width: width, height: height) && map[ newPointer.i][newPointer.j] == "#" {
        direction = direction.rotateRight
      } else {
        map[pointer.i][pointer.j] = "X"
        pointer = newPointer
      }
    }

    var counter = 0
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        if map[i][j] == "X" {
          counter += 1
        }
      }
    }
    print(map)
    return counter
  }


  func part2() -> Any {
    
    var counter = 0
    let maxRouteLength = self.map.count * self.map[0].count
    for i in 0..<self.map.count {
      for j in 0..<self.map[i].count {
        if map[i][j] == "#" || map[i][j] == "^" || map[safe: i+1]?[safe: j] == "^" { continue }
        var map = self.map

        let obstacle = Container(i: i, j: j)
        map[i][j] = "#"
        print(obstacle)
        var routeLength = 0

        var pointer = Container(i: 0, j: 0)
        let width = map[0].count
        let height = map.count
        for i in 0..<map.count {
          for j in 0..<map[i].count {
            if map[i][j] == "^" {
              pointer = Container(i: i, j: j)
            }
          }
        }
        var direction = Direction.up
        while pointer.inField(width: width, height: height) && routeLength < maxRouteLength {
          var newPointer = pointer
          switch direction {
          case .down:
            newPointer.i += 1
          case .left:
            newPointer.j -= 1
          case .right:
            newPointer.j += 1
          case .up:
            newPointer.i -= 1
          }
          if newPointer.inField(width: width, height: height) && map[ newPointer.i][newPointer.j] == "#" {
            direction = direction.rotateRight
          } else {
            routeLength += 1
            map[pointer.i][pointer.j] = "X"
            pointer = newPointer
          }
        }

        if routeLength >= maxRouteLength {
          counter += 1
        }
      }
    }

    return counter
  }
}
