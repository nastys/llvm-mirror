; RUN: if as < %s | opt -raise | dis | grep '= cast' | grep \*
; RUN: then exit 1
; RUN: else exit 0
; RUN: fi

	%Hash = type { { uint, sbyte *, \2 } * *, int (uint) *, int } *
	%HashEntry = type { uint, sbyte *, \2 } *
	%hash = type { { uint, sbyte *, \2 } * *, int (uint) *, int }
	%hash_entry = type { uint, sbyte *, \2 * }
implementation

%Hash "MakeHash"(int %size, int (uint) * %map)
begin
bb0:					;[#uses=1]
	%reg112 = malloc sbyte * *, uint 3		; <sbyte * * *> [#uses=5]
	%reg107-uint = cast int %size to uint		; <uint> [#uses=1]
	%reg115 = malloc sbyte *, uint %reg107-uint		; <sbyte * *> [#uses=1]
	store sbyte * * %reg115, sbyte * * * %reg112

	%cast246 = cast sbyte * * * %reg112 to %Hash		; <%Hash> [#uses=1]
	ret %Hash %cast246
end

