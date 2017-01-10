extends Node

# o = origen
# f = final
func intersection(o1, f1, o2, f2):
	# recta 1 y = mx + b
	var m1 = (f1.y - o1.y) / (f1.x - o1.x)
	var b1 = m1 * o1.x - o1.y
	
	# recta 2 y = mx + b
	var m2 = (f2.y - o2.y) / (f2.x - o2.x)
	var b2 = m2 * o2.x - o2.y

	# obtener x
	var xx = (b1 - b2) / (m2 - m1)

	# obtener y
	var yy = m1 * xx + b1
	
	if ((-xx < min(o1.x, f1.x)) or (-xx > max(o1.x, f1.x)) or (-yy >= max(o2.y, f2.y))):
		return null
	else:
		return Vector2 (-xx, -yy)