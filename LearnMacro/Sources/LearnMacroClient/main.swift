import LearnMacro

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

#throwWarning("This is the throw warning message")

#throwWarning()

#throwWarning(1)

#throwWarning("This is the throw warning message" + "!")
