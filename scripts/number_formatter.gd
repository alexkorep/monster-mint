extends Node

func format_large_number(value):
	# Define suffixes for large numbers, up to 1e100
	var suffixes = [
		"", "K", "M", "B", "T", "P", "E", "Z", "Y", # Official SI suffixes
		"AA", "BB", "CC", "DD", "EE", "FF", "GG", # Made-up suffixes
		"HH", "II", "JJ", "KK", "LL", "MM", "NN",
		"OO", "PP", "QQ", "RR", "SS", "TT", "UU",
		"VV", "WW", "XX", "YY", "ZZ"
	]
	var suffix_index = 0
	var formatted_number = float(value)

	# Reduce the number by powers of 1000 and increase the suffix index
	while formatted_number >= 1000.0 and suffix_index < suffixes.size():
		formatted_number /= 1000.0
		suffix_index += 1

	# Format the number to have up to two decimal places and add the appropriate suffix
	var number_string = "%.1f" % formatted_number
	# Trim trailing zeros and the decimal point if not needed
	return number_string + (suffixes[suffix_index] if suffix_index else "")
