import TaskManagerLib

print("Exercice 3:")

let taskManager = createTaskManager()

// Transitions list
let create = taskManager.transitions.first{$0.name == "create"}!
let spawn = taskManager.transitions.first{$0.name == "spawn"}!
let exec = taskManager.transitions.first{$0.name == "exec"}!
let success = taskManager.transitions.first{$0.name == "success"}!
let fail = taskManager.transitions.first{$0.name == "fail"}!
// Places list
let taskPool = taskManager.places.first{$0.name == "taskPool"}!
let processPool = taskManager.places.first{$0.name == "processPool"}!
let inProgress = taskManager.places.first{$0.name == "inProgress"}!

// Transitions that lead to a problem
let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])

let m2 = spawn.fire(from: m1!)
print("Spawn",m2!)
let m3 = spawn.fire(from: m2!)
print("Spawn",m3!)
let m4 = exec.fire(from: m3!)
print("Exec",m4!)
let m5 = exec.fire(from: m4!)
print("Exec",m5!)
let m6 = success.fire(from: m5!)
print("Success",m6!)
// There is one token in inProgress that can't go to success because there is no token in taskPool


print("Exercice 4:")

let correctTaskManager = createCorrectTaskManager()

// Transitions list
let create1 = correctTaskManager.transitions.first{$0.name == "create"}!
let spawn1 = correctTaskManager.transitions.first{$0.name == "spawn"}!
let exec1 = correctTaskManager.transitions.first{$0.name == "exec"}!
let success1 = correctTaskManager.transitions.first{$0.name == "success"}!
let fail1 = correctTaskManager.transitions.first{$0.name == "fail"}!
// Places list
let taskPool1 = correctTaskManager.places.first{$0.name == "taskPool"}!
let processPool1 = correctTaskManager.places.first{$0.name == "processPool"}!
let inProgress1 = correctTaskManager.places.first{$0.name == "inProgress"}!
let pass = correctTaskManager.places.first{$0.name == "pass"}!

// Transitions that no longer leads to the problem
let m7 = create1.fire(from: [taskPool1: 0, processPool1: 0, inProgress1: 0, pass: 0])
print("Create",m7!)
let m8 = spawn1.fire(from: m7!)
print("Spawn",m8!)
let m9 = spawn1.fire(from: m8!)
print("Spawn",m9!)
let m10 = exec1.fire(from: m9!)
print("Exec",m10!)
let m11 = success1.fire(from: m10!)
print("Success",m11!)
let m12 = fail1.fire(from: m10!)
print("Fail",m12!)
// The problem was that you could execute 2 times for the same task, so there was a token stuck inProgress, this is no longer possible
