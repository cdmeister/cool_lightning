; extends
; Cool Lightning — custom C highlights
; Splits @keyword.type into semantic subcategories

; typedef → gypsum (neutral, "I'm naming what follows")
"typedef" @keyword.typedef

; struct/union → teal (complex types with members)
"struct" @keyword.struct
"union"  @keyword.struct

; enum → mint (value type, named constants)
"enum" @keyword.enum
