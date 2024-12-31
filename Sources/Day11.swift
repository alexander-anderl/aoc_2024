import Algorithms
import Foundation

struct Day11: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var stones: [Int] {
    return data.replacingOccurrences(of: "\n", with: "").split(separator: " ").map({ Int($0)!})
  }

  struct ValueContainer {
    let value: Int
    let count: Int
  }


  func part1() -> Any {
    var localStones = stones
    var newStones = [Int]()
    for i in 0..<25 {
      localStones.forEach({ stoneNumber in
        if stoneNumber == 0 {
          newStones.append(1)
        } else if String(stoneNumber).count % 2 == 0 {
          let string = String(stoneNumber)
          let index = string.index(string.startIndex, offsetBy: string.count / 2)
          let firstHalf = String(string[..<index])
          let secondHalf = String(string[index...])
          newStones.append(Int(firstHalf)!)
          newStones.append(Int(secondHalf)!)
        } else {
          newStones.append(stoneNumber * 2024)
        }
      })
      localStones = newStones
      newStones.removeAll()
    }
    return localStones.count
  }


  func part2() -> Any {
    var localStones = stones.map({ ValueContainer(value: $0, count: 1)})
    var newStones = [ValueContainer]()
    for i in 0..<75 {
      print(i)
      localStones.forEach({ stoneNumber in
        if stoneNumber.value == 0 {
          newStones.append(ValueContainer(value: 1, count: stoneNumber.count))
        } else if String(stoneNumber.value).count % 2 == 0 {
          let string = String(stoneNumber.value)
          let index = string.index(string.startIndex, offsetBy: string.count / 2)
          let firstHalf = String(string[..<index])
          let secondHalf = String(string[index...])
          newStones.append(ValueContainer(value: Int(firstHalf)!, count: stoneNumber.count))
          newStones.append(ValueContainer(value: Int(secondHalf)!, count: stoneNumber.count))
        } else {
          newStones.append(ValueContainer(value: stoneNumber.value * 2024, count: stoneNumber.count))
        }
      })
      let dict = Dictionary(grouping: newStones, by: { $0.value })
      localStones = dict.map({ key, value in
        return ValueContainer(value: key, count: value.map({ $0.count }).reduce(0, +))
      })
      newStones.removeAll()
    }
    return localStones.map({ $0.count }).reduce(0, +)
  }
}
