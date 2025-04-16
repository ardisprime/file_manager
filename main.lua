
window = require "src/window"

vector = require "src/vector"

print("vector:")
print(vector:get("a") )

window.test_print("hello")

print(window.get_pos("x") )
window.set_pos("x", "10")
print(window.get_pos("x") )

print(window.get_size("h") )
window.set_size("h", "5")
print(window.get_size("h") )

