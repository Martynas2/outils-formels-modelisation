import PetriKit
import CoverabilityLib

print("TP-03 \n")
  //Tests:
print("createBoundedModel :")
do{
  let model = createBoundedModel()
  guard let s1 = model.places.first(where: { $0.name == "s1" }),
        let s2 = model.places.first(where: { $0.name == "s2" }),
        let s3 = model.places.first(where: { $0.name == "s3" }),
        let w1  = model.places.first(where: { $0.name == "w1"  }),
        let w2  = model.places.first(where: { $0.name == "w2"  }),
        let w3  = model.places.first(where: { $0.name == "w3"  }),
        let p = model.places.first(where: { $0.name == "p" }),
        let t  = model.places.first(where: { $0.name == "t"  }),
        let m  = model.places.first(where: { $0.name == "m"  }),
        let r = model.places.first(where: { $0.name == "r" })

        else {
          fatalError("Error")
        }

  let initialMarking: CoverabilityMarking =
      [s1: 0, s2: 0, s3: 0, w1: 1, w2: 1, w3: 1, p: 1, t: 0, m: 0, r: 1]

  print("Mo: \(initialMarking)\n")
  if model.coverabilityGraph(from: initialMarking) != nil{
    print("Test successful\n")
  }
  else{
    print("Test unsuccessful")
  }
}


print("createUnboundedModel")
do{
  let model = createUnboundedModel()
  guard let s0 = model.places.first(where: { $0.name == "s0" }),
        let s1 = model.places.first(where: { $0.name == "s1" }),
        let s2 = model.places.first(where: { $0.name == "s2" }),
        let s3 = model.places.first(where: { $0.name == "s3" }),
        let s4 = model.places.first(where: { $0.name == "s4" }),
        let b  = model.places.first(where: { $0.name == "b"  })
        else {
          fatalError("Error")
        }

  let initialMarking: CoverabilityMarking =
      [s0: 1, s1: 0, s2: 1, s3: 0, s4: 1, b: 1]

  print("M0: \(initialMarking)\n")
  if model.coverabilityGraph(from: initialMarking) != nil{
    print("Test successful")
  }
  else{
    print("Test unsuccessful")
  }
}
