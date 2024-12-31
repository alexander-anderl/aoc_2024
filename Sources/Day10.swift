import Algorithms
import Foundation

struct Day10: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var map: [[Int]] {
    data.split(separator: "\n").map({ string in
      Array(string).map({Int(String($0))!})
    })
  }

  class PathPointer: CustomStringConvertible {
    var i: Int
    var j: Int
    var value: Int
    var path: [(Int,Int)] = []
    let id = UUID()

    init(i: Int, j: Int, value: Int) {
      self.i = i
      self.j = j
      self.value = value
      self.path.append((i,j))
    }

    init(i: Int, j: Int, value: Int, path: [(Int,Int)]) {
      self.i = i
      self.j = j
      self.value = value
      self.path = path
      self.path.append((i,j))
    }

    var description: String {
      "i: \(i), j: \(j), value: \(value), id: \(id), path: \(path)\n"
    }

    func setValue(i: Int, j: Int) {
      self.i = i
      self.j = j
      path.append((i,j))
    }
  }

  struct Container: Hashable {
   let i: Int
    let j: Int
  }

  func part1() -> Any {
    let map = self.map
    var totalScore = 0
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        if map[i][j] == 0 {
          var paths = [PathPointer(i: i, j: j, value: 0)]

          while paths.filter({ $0.value < 9 }).count > 0  {
            for path in paths where path.value < 9 {
              var results = [PathPointer]()
              if let left = map[safe: path.i-1]?[safe: path.j], left == path.value+1 {
                results.append(PathPointer(i: path.i-1, j: path.j, value: path.value+1, path: path.path))
              }
              if let right = map[safe: path.i+1]?[safe: path.j], right == path.value+1 {
                results.append(PathPointer(i: path.i+1, j: path.j, value: path.value+1, path: path.path))
              }
              if let top = map[safe: path.i]?[safe: path.j-1], top == path.value+1 {
                results.append(PathPointer(i: path.i, j: path.j-1, value: path.value+1, path: path.path))
              }
              if let bottom = map[safe: path.i]?[safe: path.j+1], bottom == path.value+1 {
                results.append(PathPointer(i: path.i, j: path.j+1, value: path.value+1, path: path.path))
              }
              if let first = results.first {
                path.setValue(i: first.i, j: first.j)
                path.value = first.value
              } else {
                paths.removeAll(where: { path.id == $0.id })
              }
              for path in results.dropFirst() {
                paths.append(path)
              }
            }
          }
          let uniquePathCount = Array(Set(paths.map({ Container(i: $0.path.last!.0, j: $0.path.last!.1) }))).count
          print(paths.count)
          totalScore += uniquePathCount
        }
      }
    }
    return totalScore
  }


  func part2() -> Any {
    let map = self.map
    var totalScore = 0
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        if map[i][j] == 0 {
          var paths = [PathPointer(i: i, j: j, value: 0)]

          while paths.filter({ $0.value < 9 }).count > 0  {
            for path in paths where path.value < 9 {
              var results = [PathPointer]()
              if let left = map[safe: path.i-1]?[safe: path.j], left == path.value+1 {
                results.append(PathPointer(i: path.i-1, j: path.j, value: path.value+1, path: path.path))
              }
              if let right = map[safe: path.i+1]?[safe: path.j], right == path.value+1 {
                results.append(PathPointer(i: path.i+1, j: path.j, value: path.value+1, path: path.path))
              }
              if let top = map[safe: path.i]?[safe: path.j-1], top == path.value+1 {
                results.append(PathPointer(i: path.i, j: path.j-1, value: path.value+1, path: path.path))
              }
              if let bottom = map[safe: path.i]?[safe: path.j+1], bottom == path.value+1 {
                results.append(PathPointer(i: path.i, j: path.j+1, value: path.value+1, path: path.path))
              }
              //              print(results)
              if let first = results.first {
                path.setValue(i: first.i, j: first.j)
                path.value = first.value
              } else {
                paths.removeAll(where: { path.id == $0.id })
              }
              for path in results.dropFirst() {
                paths.append(path)
              }
            }
          }
          totalScore += paths.count
        }
      }
    }
    return totalScore
  }
}

extension Collection {
  // Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}
