import Algorithms
import Foundation

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").map({ Int($0)! })
    }
  }


  func part1() -> Any {
    entities.filter({ level in
      var asc = true
      var desc = true

      for (index, value) in level.enumerated() {
        if index == level.count - 1 { break }
        asc = asc && (1...3).contains(level[index + 1] - value)
        desc = desc && (1...3).contains(value - level[index + 1])
      }
      return asc || desc
    }).count
  }


  func part2() -> Any {
    entities.enumerated().filter({ index, level in
      guard let alternative = checkLevel(level: level) else {
        return true
      }
      let firstDropped = Array(level.dropFirst())
      let result = checkLevel(level: alternative.0) == nil || checkLevel(level: alternative.1) == nil || checkLevel(level: firstDropped) == nil || checkLevel(level: alternative.2) == nil || checkLevel(level: alternative.3) == nil
      print(index + 1, alternative, firstDropped, result)
      return result
    }).count
  }

  private func checkLevel(level: [Int]) -> ([Int], [Int], [Int], [Int])? {
    var asc: [Int]? = nil
    var desc: [Int]? = nil
    var asc2: [Int]? = nil
    var desc2: [Int]? = nil

    for (index, value) in level.enumerated() {
      if index == level.count - 1 { break }
      if !(1...3).contains(level[index + 1] - value) {
        if asc == nil {
          var alternative = level
          alternative.remove(at: index + 1)
          asc = alternative
          var alternative2 = level
          alternative2.remove(at: index)
          asc2 = alternative2
        }
      }
      if !(1...3).contains(value - level[index + 1]) {
        if desc == nil {
          var alternative = level
          alternative.remove(at: index + 1)
          desc = alternative
          var alternative2 = level
          alternative2.remove(at: index)
          desc2 = alternative2
        }
      }
    }
    guard let asc, let desc else {
      return nil
    }
//    print(result == nil, asc, desc, level)
    return (asc, desc, asc2!, desc2!)
  }
}
