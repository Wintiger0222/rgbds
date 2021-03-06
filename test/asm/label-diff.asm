
PUSHS

SECTION "floating", ROM0

Known: ; This symbol is known to be a label, but its value is not known yet
	ds 4
Known2: ; This symbol isn't known either, but the difference is known (4)

SECTION "fixed", ROM0[42]

Constant: ; This label's value is known to be 42

SECTION "fixed 2", ROM0[69]

Constant2: ; Same as above


print_diff: MACRO
	PRINTV (\1) - (\2)
	PRINTT "\n"
	PRINTV (\2) - (\1)
	PRINTT "\n"
ENDM

POPS ; Ensure we are in neither section

; TODO: uncomment all that can be, there is seriously room for improvement here
	; Diffing two constants should work
	print_diff Constant, Constant2
	; Diffing two labels in the same SECTION as well
	print_diff Known2, Known
	; Diffing a constant and a "floating" label cannot work
; ...And that causes a fatal error	print_diff Constant, Known
	; Diffing a constant and a ref cannot work
; ...And that causes a fatal error	print_diff Constant, Unknown
	; Diffing a floating label and a ref cannot work
; ...And that causes a fatal error	print_diff Known, Unknown

	; Now let's fiddle with PC
SECTION "fixed PC", ROM0[420]
	; Diffing a constant and PC should work
	print_diff Constant, @
	; Diffing a floating label and PC cannot work
; ...And that causes a fatal error	print_diff Known, @
	; Diffinf a ref and PC cannot work
; ...And that causes a fatal error	print_diff Unknown, @
	; Diffing PC and PC should work
	print_diff @, @
	; Diffing PC and a label from here should work
LocalFixed:
	print_diff LocalFixed, @

SECTION "Floating PC", ROM0
	; Diffing a constant and PC cannot work
; ...And that causes a fatal error	print_diff Constant, @
	; Diffing a floating label and PC cannot work
; ...And that causes a fatal error	print_diff Known, @
	; Diffinf a ref and PC cannot work
; ...And that causes a fatal error	print_diff Unknown, @
	; Diffing PC and PC should work
	print_diff @, @
	; Diffing PC and a label from here should work
LocalFloating:
	print_diff LocalFloating, @
