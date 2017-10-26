import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.

        let transitions = self.transitions
        let firstN = MarkingGraph(marking: marking)
        var tosee = [MarkingGraph]()
        var seen = [MarkingGraph]()

        tosee.append(firstN)

        while tosee.count != 0 {
            let point = tosee.removeFirst()
            seen.append(point)
            transitions.forEach { trans in
              if let newN = trans.fire(from: point.marking) {
                        if let seen2 = seen.first(where: { $0.marking == newN }) {
                            point.successors[trans] = seen2
                        } else {
                            let find = MarkingGraph(marking: newN)
                            point.successors[trans] = find
                            if (!tosee.contains(where: { $0.marking == find.marking})) {
                                tosee.append(find)
                            }
                    }
                }
            }
        }
        return firstN  }

    //Count the nodes in the MarkingGraph
    public func count (mark: MarkingGraph) -> Int{
      var seen = [MarkingGraph]()
      var toSee = [MarkingGraph]()

      toSee.append(mark)
      while let point = toSee.popLast() {
        seen.append(point)
        for(_, successor) in point.successors{
          if !seen.contains(where: {$0 === successor}) && !toSee.contains(where: {$0 === successor}){
              toSee.append(successor)
            }
          }
      }
      return seen.count}


    //If >2 smokers are smoking return true
    public func twoManySmokers (mark: MarkingGraph) -> Bool {
      var seen = [MarkingGraph]()
      var toSee = [MarkingGraph]()

      toSee.append(mark)
      while let point = toSee.popLast() {
        seen.append(point)
        var nbSmoke = 0;
        for (key, value) in point.marking {
            if (key.name == "s1" || key.name == "s2" || key.name == "s3"){
               nbSmoke += Int(value)
            }
        }
        if (nbSmoke > 1) {
          return true
        }
        for(_, successor) in point.successors{
          if !seen.contains(where: {$0 === successor}) && !toSee.contains(where: {$0 === successor}){
              toSee.append(successor)
            }
          }
      }
      return false }

    //If >1 items return ture
    public func sameItem (mark: MarkingGraph) -> Bool {
      var seen = [MarkingGraph]()
      var toSee = [MarkingGraph]()

      toSee.append(mark)
      while let point = toSee.popLast() {
        seen.append(point)
        for (key, value) in point.marking {
            if (key.name == "p" || key.name == "t" || key.name == "m"){
               if(value > 1){
               //print(point.marking)
                 return true
               }
            }
        }
        for(_, successor) in point.successors{
          if !seen.contains(where: {$0 === successor}) && !toSee.contains(where: {$0 === successor}){
              toSee.append(successor)
            }
          }
      }
      return false}

}
