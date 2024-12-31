import Algorithms
import Foundation

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String



  func part1() -> Any {
    let result = data.groups(for: "mul\\((\\d{1,3}),(\\d{1,3})\\)").map({ Int($0[1])! * Int($0[2])!}).reduce(0, +)
    return result
  }


  func part2() -> Any {
    let noNewLines = data.replacingOccurrences(of: "\n", with: "")
    let doBlocks = noNewLines.groups(for: "(?<=^|(do\\(\\)))(.*?)(?=(don't\\(\\))|$)")
    return doBlocks.map({$0[0]}).flatMap({ $0.groups(for: "mul\\((\\d{1,3}),(\\d{1,3})\\)").map({ Int($0[1])! * Int($0[2])!}) }).reduce(0, +)
  }
}

extension String {
  func groups(for regexPattern: String) -> [[String]] {
    do {
      let text = self
      let regex = try NSRegularExpression(pattern: regexPattern)
      let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
      return matches.map { match in
        return (0..<match.numberOfRanges).map {
          let rangeBounds = match.range(at: $0)
          guard let range = Range(rangeBounds, in: text) else {
            return ""
          }
          return String(text[range])
        }
      }
    } catch let error {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }
}
