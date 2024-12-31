import Algorithms
import Foundation

struct Day08: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var map: [[String]] {
    data.split(separator: "\n").map({ string in
      Array(string).map({String($0)})
    })
  }

  struct Container: Hashable, CustomStringConvertible {
    let i: Int
    let j: Int

    var description: String {
      "(\(i),\(j))"
    }
  }

  struct Pair {
    let first: Container
    let second: Container
  }

  func part1() -> Any {
    var pairs = [Pair]()
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        print(i,j)
        if map[i][j] != "." {

          var starter = j + 1
          for ii in i..<map.count {
            for jj in starter..<map[i].count {
              if map[i][j] == map[ii][jj] {
                pairs.append(.init(first: .init(i: i, j: j), second: .init(i: ii, j: jj)))
              }
            }
            starter = 0
          }

        }
      }
    }
    var antinodes = [Container]()
    let maxWidth = map[0].count - 1
    let maxHeight = map.count - 1
    for pair in pairs {
      let diff1 = pair.first.i - pair.second.i
      let diff2 = pair.first.j - pair.second.j
      let antinode1Result1 = pair.first.i + diff1
      let antinode1Result2 = pair.first.j + diff2
      let antinode2Result1 = pair.second.i - diff1
      let antinode2Result2 = pair.second.j - diff2
      if (0...maxHeight).contains(antinode1Result1) && (0...maxWidth).contains(antinode1Result2) {
        antinodes.append(.init(i: antinode1Result1, j: antinode1Result2))
      }
      if (0...maxHeight).contains(antinode2Result1) && (0...maxWidth).contains(antinode2Result2) {
        antinodes.append(.init(i: antinode2Result1, j: antinode2Result2))
      }
    }

//    let result = antinodes.filter({ map[$0.i][$0.j] == "."})
    return antinodes.count
  }


  func part2() -> Any {
    var pairs = [Pair]()
    var antennas = 0
    for i in 0..<map.count {
      for j in 0..<map[i].count {
        print(i,j)
        if map[i][j] != "." {
          antennas += 1
          var starter = j + 1
          for ii in i..<map.count {
            for jj in starter..<map[i].count {
              if map[i][j] == map[ii][jj] {
                pairs.append(.init(first: .init(i: i, j: j), second: .init(i: ii, j: jj)))
              }
            }
            starter = 0
          }

        }
      }
    }
    var antinodes = [Container]()
    let maxWidth = map[0].count - 1
    let maxHeight = map.count - 1
    for pair in pairs {
      let diff1 = pair.first.i - pair.second.i
      let diff2 = pair.first.j - pair.second.j

      var antinode1Result1 = pair.first.i + diff1
      var antinode1Result2 = pair.first.j + diff2
      while (0...maxHeight).contains(antinode1Result1) && (0...maxWidth).contains(antinode1Result2) {
        antinodes.append(.init(i: antinode1Result1, j: antinode1Result2))
        antinode1Result1 = antinode1Result1 + diff1
        antinode1Result2 = antinode1Result2 + diff2
      }

      var antinode2Result1 = pair.second.i - diff1
      var antinode2Result2 = pair.second.j - diff2
      while (0...maxHeight).contains(antinode2Result1) && (0...maxWidth).contains(antinode2Result2) {
        antinodes.append(.init(i: antinode2Result1, j: antinode2Result2))
        antinode2Result1 = antinode2Result1 - diff1
        antinode2Result2 = antinode2Result2 - diff2
      }
    }

        print(antinodes)
    let result = antinodes.filter({ map[$0.i][$0.j] == "."})
    print(result.count)
    print(Array(Set(result)).count)
    print(antinodes.count)
    return Array(Set(result)).count + antennas
    //    print(antinodes.count)
    //    return 0
  }
}
