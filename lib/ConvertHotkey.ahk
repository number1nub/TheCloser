ConvertHotkey(key) {
	for a, b in [{Shift:"+"}, {Ctrl:"^"}, {Alt:"!"}]
		for c, d in b
			key := RegExReplace(Format("{1:U}", key), "\" d, c "+")
	return StrReplace(Trim(key, "~$*"), "&", "+")
}