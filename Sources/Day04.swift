import Algorithms
import Foundation

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var matrix: [[Character]] {
    data.split(separator: "\n").map({
      Array($0)
    })
  }



  func part1() -> Any {
    var count = 0
    for i in 0..<self.matrix.count {
      for j in 0..<self.matrix[i].count {
        if matrix[i][j] == "X" {
          print(i,j)
          if let char = matrix[safe: i+1]?[safe: j], char == "M" {
            if let char = matrix[safe: i+2]?[safe: j], char == "A" {
              if let char = matrix[safe: i+3]?[safe: j], char == "S" {
                print("down")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i-1]?[safe: j], char == "M" {
            if let char = matrix[safe: i-2]?[safe: j], char == "A" {
              if let char = matrix[safe: i-3]?[safe: j], char == "S" {
                print("up")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i]?[safe: j+1], char == "M" {
            if let char = matrix[safe: i]?[safe: j+2], char == "A" {
              if let char = matrix[safe: i]?[safe: j+3], char == "S" {
                print("right")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i]?[safe: j-1], char == "M" {
            if let char = matrix[safe: i]?[safe: j-2], char == "A" {
              if let char = matrix[safe: i]?[safe: j-3], char == "S" {
                print("left")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i+1]?[safe: j+1], char == "M" {
            if let char = matrix[safe: i+2]?[safe: j+2], char == "A" {
              if let char = matrix[safe: i+3]?[safe: j+3], char == "S" {
                print("right down")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i-1]?[safe: j-1], char == "M" {
            if let char = matrix[safe: i-2]?[safe: j-2], char == "A" {
              if let char = matrix[safe: i-3]?[safe: j-3], char == "S" {
                print("left up")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i+1]?[safe: j-1], char == "M" {
            if let char = matrix[safe: i+2]?[safe: j-2], char == "A" {
              if let char = matrix[safe: i+3]?[safe: j-3], char == "S" {
                print("left down")
                count += 1
              }
            }
          }

          if let char = matrix[safe: i-1]?[safe: j+1], char == "M" {
            if let char = matrix[safe: i-2]?[safe: j+2], char == "A" {
              if let char = matrix[safe: i-3]?[safe: j+3], char == "S" {
                print("right up")
                count += 1
              }
            }
          }

        }
      }
    }
    return count
  }


  func part2() -> Any {
    var count = 0
    for i in 0..<self.matrix.count {
      for j in 0..<self.matrix[i].count {
        if matrix[i][j] == "M" {
          print(i,j)
          if let char = matrix[safe: i+1]?[safe: j+1], char == "A" {
            if let char = matrix[safe: i+2]?[safe: j+2], char == "S" {

              if let char = matrix[safe: i]?[safe: j+2], char == "S" {
                if let char = matrix[safe: i+2]?[safe: j], char == "M" {
                  count += 1
                }
              } else if let char = matrix[safe: i]?[safe: j+2], char == "M" {
                if let char = matrix[safe: i+2]?[safe: j], char == "S" {
                  count += 1
                }
              }

            }
          }
        } else if matrix[i][j] == "S" {
          print(i,j)
          if let char = matrix[safe: i+1]?[safe: j+1], char == "A" {
            if let char = matrix[safe: i+2]?[safe: j+2], char == "M" {

              if let char = matrix[safe: i]?[safe: j+2], char == "S" {
                if let char = matrix[safe: i+2]?[safe: j], char == "M" {
                  count += 1
                }
              } else if let char = matrix[safe: i]?[safe: j+2], char == "M" {
                if let char = matrix[safe: i+2]?[safe: j], char == "S" {
                  count += 1
                }
              }

            }
          }
        }
      }
    }
    return count
  }
}

extension Array {
  subscript(safe range: Range<Index>) -> ArraySlice<Element>? {
    if range.endIndex > endIndex {
      return nil
    }
    else {
      return self[range]
    }
  }
}
