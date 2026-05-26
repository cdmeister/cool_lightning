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

; Function pointer typedef names
(type_definition
  declarator: (function_declarator
    declarator: (parenthesized_declarator
      (pointer_declarator
        declarator: (type_identifier) @type.function_ptr))))
