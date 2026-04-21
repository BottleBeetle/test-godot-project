extends Node

var cache: Dictionary = {}


# --- Pobieranie zasobu ---
func get_resource(path: String) -> Resource:
	if cache.has(path):
		return cache[path]

	var res = load(path)
	if res:
		cache[path] = res
	return res


# --- Preloading zasobów na starcie ---
func preload_resources(paths: Array) -> void:
	for p in paths:
		var res = load(p)
		if res:
			cache[p] = res


# --- Czyszczenie cache ---
func clear() -> void:
	cache.clear()
