extends Node2D
class_name BarrelComponent

@export var projectile_count := 1

# Calculates accuracy based on standard deviation (sigma) and target angle range (theta)
func calculate_accuracy(spread: float) -> float:
	# z-score for the target range
	var z = 5 / spread
	# Approximate cumulative probability for the range
	return erf(z / sqrt(2.0)) * 100
			
func erf(x: float) -> float:#Yes it's from ChatGPT, i hate statistics
	# Approximation of the error function
	var a1 = 0.254829592
	var a2 = -0.284496736
	var a3 = 1.421413741
	var a4 = -1.453152027
	var a5 = 1.061405429
	var p = 0.3275911
	var s = 1 if x >= 0 else -1
	x = abs(x)
	var t = 1.0 / (1.0 + p * x)
	var y = (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t
	return s * (1.0 - y * exp(-x * x))
