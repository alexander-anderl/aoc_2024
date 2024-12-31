import Algorithms
import Foundation

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: ([Int], [Int]) {
    var left: [Int] = []
    var right: [Int] = []
    data.split(separator: "\n").forEach {
      let lineSplit = $0.split(separator: "   ")
      let leftValue = Int(String(lineSplit[0]))!
      let rightValue = Int(String(lineSplit[1]))!
      left.append(leftValue)
      right.append(rightValue)
    }
    return (left, right)
  }


  func part1() -> Any {
    let result = zip(entities.0.sorted(), entities.1.sorted()).map({ abs($0 - $1) }).reduce(0, +)
    return result
  }


  func part2() -> Any {
    var result = 0
    entities.0.forEach({ leftValue in
      var occurs = 0
      entities.1.forEach({ rightValue in
        occurs += leftValue == rightValue ? 1 : 0
      })
      result += occurs * leftValue
    })
    return result
  }
}
