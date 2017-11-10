import PetriKit


public extension PTNet {

	//Graphe de couverture to PTMarking
    public func CtoPTM(with marking : CoverabilityMarking, and p : [PTPlace]) -> PTMarking {

      var m : PTMarking = [:]

      for temp in p {
        let a = omeg(to : marking[temp]!)!
        m[temp] = a
      }
      return m
    }

		//PTMarking to graphe de couverture
    public func PTMtoC(with marking: PTMarking, and p : [PTPlace]) ->CoverabilityMarking {

      var temp : CoverabilityMarking = [:]

      for nbr in p {
        temp[nbr] = .some(marking[nbr]!)
        if(500 < temp[nbr]!) {
          temp[nbr] = .omega
        }
      }
      return temp
    }

		//Omega errors
    public func omeg(to t: Token) -> UInt? {
      if case .some(let val) = t {
        return val
      }
      else {
        return 1000
      }
    }

		//Contained?
    public func verify(at marking : [CoverabilityMarking], to markingToAdd : CoverabilityMarking) -> Int {

      var val = 0

      for i in 0...marking.count-1 {
        if (marking[i] == markingToAdd) {
          val = 1
        }
        if (markingToAdd > marking[i]) {
          val = i+2}
      }
      return val
    }

		//Add omega
    public func Omega(from comp : CoverabilityMarking, with marking : CoverabilityMarking, and p : [PTPlace])  -> CoverabilityMarking? {

      var temp = marking

      for t in p {
        if (comp[t]! < temp[t]!) {
          temp[t] = .omega
        }
      }
      return temp
    }

    public func coverabilityGraph(from marking0: CoverabilityMarking) -> CoverabilityGraph? {

			let pl = Array(places)
			let graph = CoverabilityGraph(marking: marking0, successors: [:])
			var tran = Array (transitions)
      var mList : [CoverabilityMarking] = [marking0]
      var gList : [CoverabilityGraph] = []
      var a: CoverabilityMarking
      var count = 0
			tran.sort{$0.name < $1.name}

        while(count < mList.count) {
          for tran in tran{
            let ptMarking = CtoPTM(with: mList[count], and: pl)
            if let firedTran = tran.fire(from: ptMarking){
              let convMarking = PTMtoC(with: firedTran, and: pl)
              let nouvCouv = CoverabilityGraph(marking: convMarking, successors: [:])
              graph.successors[tran] = nouvCouv
            }
            if(graph.successors[tran] != nil) {
              a = graph.successors[tran]!.marking
              let cur = verify(at: mList, to: a)
              if (cur != 1) {
                if (cur > 1) {
                  a = Omega(from : mList[cur-2], with : a, and : pl)!
                }
                gList.append(graph)
                mList.append(a)
              }
            }
          }
          count = count + 1
        }
        return graph
      }
}
