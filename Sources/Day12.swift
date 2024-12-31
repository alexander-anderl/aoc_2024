import Algorithms
import Foundation

struct Day12: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var map: [[String]] {
    self.data.split(separator: "\n").map({ Array($0).map({ String($0) }) })
  }

  struct Postion: CustomStringConvertible, Hashable {
    let i: Int
    let j: Int

    var description: String {
      "\(i),\(j)"
    }
  }

  class Region: CustomStringConvertible {

    enum Direction: CaseIterable {
      case up
      case down
      case left
      case right
    }

    let plant: String
    var fieldDict: [(Postion): Bool] = [:]

    init(plant: String, i: Int, j: Int) {
      self.plant = plant
      self.fieldDict[Postion(i: i, j: j)] = true
    }

    func addToFieldIfApplicable(plant: String, i: Int, j: Int) -> Bool {
      if fieldIsNextToField(i: i, j: j) {
        self.fieldDict[Postion(i: i, j: j)] = true
        return true
      }
      return false
    }

    func fieldIsNextToField(i: Int, j: Int) -> Bool {
      if plant == "J" && i == 88 && j == 69 {
        print("test")
      }
      if fieldDict[Postion(i: i, j: j-1)] == true {
        return true
      }
      if fieldDict[Postion(i: i, j: j+1)] == true {
        return true
      }
      if fieldDict[Postion(i: i-1, j: j)] == true {
        return true
      }
      if fieldDict[Postion(i: i+1, j: j)] == true {
        return true
      }
      return false
    }

    func mergeRegionIfApplicable(region: Region) -> Bool {
      guard region.plant == self.plant else { return false }
      for field in region.fieldDict.keys {
        if fieldIsNextToField(i: field.i, j: field.j) {
//          self.fields.append(contentsOf: region.fields)
          self.fieldDict.merge(region.fieldDict, uniquingKeysWith: { (current, _) in current })
          return true
        }
      }
      print(self)
      print(region)
      return false
    }

    func calculatePrice() -> Int {
      return calculateOutterBorders() * fieldDict.keys.count
    }

    func calculateOutterBorders() -> Int {
      var sum = 0
      for field in fieldDict.keys {
        for direction in Direction.allCases {
          sum = sum + (isFieldNextTo(fieldToCheck: field, direction: direction) ? 0 : 1)
        }
      }
      return sum
    }

    func isFieldNextTo(fieldToCheck: Postion, direction: Direction) -> Bool {
      for field in fieldDict.keys {
        switch direction {
        case .up:
          if fieldToCheck.j == field.j && fieldToCheck.i == field.i + 1 {
            return true
          }
        case .down:
          if fieldToCheck.j == field.j && fieldToCheck.i == field.i - 1 {
            return true
          }
        case .left:
          if fieldToCheck.i == field.i && fieldToCheck.j == field.j + 1 {
            return true
          }
        case .right:
          if fieldToCheck.i == field.i && fieldToCheck.j == field.j - 1 {
            return true
          }
        }
      }
      return false
    }

    var description: String {
      "\(plant) \(fieldDict)"
    }
  }


  func part1() -> Any {
    let test1 = Postion(i: 1, j: 3)
    let test2 = Postion(i: 3, j: 1)
    let test3 = Postion(i: 1, j: 3)
    print(test1.hashValue)
    print(test2.hashValue)
    print(test3.hashValue)


    var regions: [Region] = []
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        print("\(i),\(j)")
        var didAddPointToRegion = false
        let value = map[i][j]
        for region in regions where value == region.plant {
          if region.addToFieldIfApplicable(plant: value, i: i, j: j) {
            didAddPointToRegion = true
            break
          }
        }
        if !didAddPointToRegion {
          regions.append(Region(plant: map[i][j], i: i, j: j))
        }
      }
    }

    print("Size 1",regions.map({ $0.fieldDict.count }).reduce(0, +))
    print("Count 1",regions.count)

    for i in 0..<regions.count {
      var j = i+1
      while j < regions.count {
        if regions[i].mergeRegionIfApplicable(region: regions[j]) {
          regions.remove(at: j)
        }
        j += 1
      }
    }

    print("Size 2",regions.map({ $0.fieldDict.count }).reduce(0, +))
    print("Count 2",regions.count)
    print("Size 3",map.count * map[0].count)

    var sum = 0
    for region in regions {
      if region.plant == "J" {
        print(region)
      }
      let result = region.calculatePrice()
//      print(region)
//      print(region.plant)
//      print(result)
      sum += result
    }
//    print(regions)
    return sum
  }


  func part2() -> Any {
    0
  }
}
