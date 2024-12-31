import Algorithms
import Foundation

struct Day09: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func part1() -> Any {
    var result = mapSpace()

    for i in (0..<result.count).reversed() {
      print("\(i)")
      if result[i] == -1 {
        continue
      }
      for j in 0..<result.count {
        if result[j] != -1 {
          continue
        }
        if j >= i {
          break
        }
        let save = result[i]
        result[i] = -1
        result[j] = save
        break
      }
    }
    var sum = 0
    for value in result.enumerated() where value.1 != -1 {
      sum += (value.1 * value.0)
    }
    return sum
  }


  func part2() -> Any {
    var result = mapSpace()

    var count = 1
    var current = -1
    for i in (0..<result.count).reversed() {
      print(Double(i)/Double(result.count))
      if result[i] == current {
        count += 1
      } else if current != -1 {
        var spaceCount = 0

        for j in 0..<result.count {
          if j == i+1 { break }
          if result[j] == -1 {
            spaceCount += 1
            if spaceCount == count {
              for offset in 0..<spaceCount {
                result[j - offset] = current
              }
              for offset in 0..<spaceCount {
                result[i + offset + 1] = -1
              }
              break
            }
          } else {
            spaceCount = 0
          }
        }

        count = 1
        current = result[i]
      } else {
        count = 1
        current = result[i]
      }
    }
    var sum = 0
    for value in result.enumerated() where value.1 != -1 {
      sum += (value.1 * value.0)
    }
    return sum
  }

  func mapSpace() -> [Int] {
    var index = 0
    var valueIdCounter = 0
    var result: [Int] = []
    for char in data where char != "\n" {
      guard let intValue = Int(String(char)) else {
        fatalError()
      }
      if index % 2 == 0 {
        result.append(contentsOf: [Int](repeating: valueIdCounter, count: intValue))
        valueIdCounter += 1
      } else {
        result.append(contentsOf: [Int](repeating: -1, count: intValue))
      }
      index += 1
    }
    return result
  }
}
