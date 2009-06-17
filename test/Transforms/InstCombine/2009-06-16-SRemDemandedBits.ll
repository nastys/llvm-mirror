; RUN: llvm-as < %s | opt -instcombine | llvm-dis | grep srem
; PR3439

define i32 @a(i32 %x) nounwind {
entry:
	%rem = srem i32 %x, 2
	%and = and i32 %rem, 2
	ret i32 %and
}
; RUN: llvm-as < %s | opt -instcombine | llvm-dis | grep srem
; PR3439

define i32 @a(i32 %x) nounwind {
entry:
	%rem = srem i32 %x, 2
	%and = and i32 %rem, 2
	ret i32 %and
}
