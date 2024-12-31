import Algorithms
import Foundation

struct Day05: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  struct Rule {
    let left: Int
    let right: Int

    init(string: String) {
      let split = string.split(separator: "|")
      left = Int(split[0])!
      right = Int(split[1])!
    }

    func contains(_ value: Int) -> Bool {
      left == value || right == value
    }
  }

  var rules: [Rule] {
    let dataSplit = data.split(separator: "\n\n")
    return dataSplit[0].split(separator: "\n").map({ .init(string: String($0))})
  }

  var rows: [[Int]] {
    let dataSplit = data.split(separator: "\n\n")
    return dataSplit[1].split(separator: "\n").map({ $0.split(separator: ",").map({ Int($0)!}) })
  }

  func part1() -> Any {
    let result: [[Int]] = (0..<rows.count).compactMap({ i in
      print(i)
      for j in 0..<rows[i].count {
        let currentValue = rows[i][j]
        let relevantRules = rules.filter({ $0.contains(currentValue) })

        for jj in 0..<rows[i].count {
          if jj == j {
            continue
          }
          let currentCheckValue = rows[i][jj]
          let currentRelevantRules = relevantRules.filter({ $0.contains(currentCheckValue) })
          for rule in currentRelevantRules {
            if (rule.left == currentValue && jj < j) || (rule.right == currentValue && jj > j) {
              return nil
            }
          }
        }
      }
      return rows[i]
    })
    var sum = 0
    for row in result {
      guard let value = row.middle else { fatalError() }
      sum += value
    }
    return sum
  }


  func part2() -> Any {
    let incorrectResult: [[Int]] = (0..<rows.count).compactMap({ i in
      print(1,i,rows.count)
      for j in 0..<rows[i].count {
        let currentValue = rows[i][j]
        let relevantRules = rules.filter({ $0.contains(currentValue) })

        for jj in 0..<rows[i].count {
          if jj == j {
            continue
          }
          let currentCheckValue = rows[i][jj]
          let currentRelevantRules = relevantRules.filter({ $0.contains(currentCheckValue) })
          for rule in currentRelevantRules {
            if (rule.left == currentValue && jj < j) || (rule.right == currentValue && jj > j) {
              return rows[i]
            }
          }
        }
      }
      return nil
    })

    let result: [[Int]] = incorrectResult.enumerated().map({ index, row in
      var mutableRow = row

      var currentIndex = 0
      endless: while true {

        someLoop: for j in 0..<mutableRow.count {
          let currentValue = mutableRow[j]
          let relevantRules = rules.filter({ $0.contains(currentValue) })

          for jj in 0..<mutableRow.count {
            if jj == j {
              continue
            }
            let currentCheckValue = mutableRow[jj]
            assert(currentValue != currentCheckValue)
            let currentRelevantRules = relevantRules.filter({ $0.contains(currentCheckValue) })
            for rule in currentRelevantRules {
              if (rule.left == currentValue && jj < j) || (rule.right == currentValue && jj > j) {
                mutableRow[j] = currentCheckValue
                mutableRow[jj] = currentValue
                break someLoop
              }
            }
          }

          currentIndex += 1
          if mutableRow.count == currentIndex {
            break endless
          }
        }
        currentIndex = 0
      }
      assert(row.reduce(0, +) == mutableRow.reduce(0, +))
      return mutableRow
    })
    var sum = 0
    for row in result {
      guard let value = row.middle else { fatalError() }
      sum += value
    }
    return sum
  }
}

extension Array {

  var middle: Element? {
    guard count != 0 else { return nil }

    let middleIndex = (count > 1 ? count - 1 : count) / 2
    return self[middleIndex]
  }

}
