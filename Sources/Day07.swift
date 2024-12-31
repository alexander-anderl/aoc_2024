import Algorithms
import Foundation

struct Day07: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  struct Row {
    let result: Int
    let factors: [Int]

    init(data: String) {
      let res = data.split(separator: ":")
      self.result = Int(res[0])!
      self.factors = res[1].split(separator: " ").map({Int($0)!})
    }

    var isValid: Bool {
      for i in 0...Int(pow(Double(2), Double(factors.count - 1))) {
        var current = factors.first!
        for j in 1..<factors.count {
          let factor = Double(pow(Double(2), Double(j - 1)))
          if Int(floor(Double(i) / factor)) % 2 == 0 {
            current += factors[j]
          } else {
            current *= factors[j]
          }
        }
        if result == current {
          return true
        }
      }
      return false
    }

    var isValid2: Bool {
      for i in 0...Int(pow(Double(3), Double(factors.count - 1))) {
        var current = factors.first!
        for j in 1..<factors.count {
          let factor = Double(pow(Double(3), Double(j - 1)))
          if Int(floor(Double(i) / factor)) % 3 == 0 {
            current += factors[j]
          } else if Int(floor(Double(i) / factor)) % 3 == 1 {
            current *= factors[j]
          } else {
            current = Int("\(current)\(factors[j])")!
          }
        }
        if result == current {
          return true
        }
      }
      return false
    }
  }

  var rows: [Row] {
    data.split(separator: "\n").map({Row(data: String($0))})
  }

  func part1() -> Any {
    let result = rows.filter({ $0.isValid }).map({ $0.result }).reduce(0, +)
    return result
  }


  func part2() -> Any {
    let result = rows.filter({ $0.isValid2 }).map({ $0.result }).reduce(0, +)
    return result
  }
}
