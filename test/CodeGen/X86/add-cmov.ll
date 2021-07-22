; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mtriple=x86_64-- | FileCheck %s

define i64 @select_consts_i64(i64 %offset, i32 %x) {
; CHECK-LABEL: select_consts_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    movl $42, %eax
; CHECK-NEXT:    cmovneq %rcx, %rax
; CHECK-NEXT:    addq %rdi, %rax
; CHECK-NEXT:    retq
  %b = icmp eq i32 %x, 0
  %s = select i1 %b, i64 42, i64 0
  %r = add i64 %s, %offset
  ret i64 %r
}

define i32 @select_consts_i32(i32 %offset, i64 %x) {
; CHECK-LABEL: select_consts_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    cmpq $42, %rsi
; CHECK-NEXT:    movl $43, %eax
; CHECK-NEXT:    cmovgel %ecx, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    retq
  %b = icmp sgt i64 %x, 41
  %s = select i1 %b, i32 0, i32 43
  %r = add i32 %offset, %s
  ret i32 %r
}

define i16 @select_consts_i16(i16 %offset, i1 %b) {
; CHECK-LABEL: select_consts_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    testb $1, %sil
; CHECK-NEXT:    movl $44, %eax
; CHECK-NEXT:    cmovel %ecx, %eax
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq
  %s = select i1 %b, i16 44, i16 0
  %r = add i16 %s, %offset
  ret i16 %r
}

define i8 @select_consts_i8(i8 %offset, i1 %b) {
; CHECK-LABEL: select_consts_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    testb $1, %sil
; CHECK-NEXT:    movl $45, %eax
; CHECK-NEXT:    cmovnel %ecx, %eax
; CHECK-NEXT:    addb %dil, %al
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
  %s = select i1 %b, i8 0, i8 45
  %r = add i8 %offset, %s
  ret i8 %r
}

define i32 @select_consts_use_i32(i32 %offset, i64 %x, i32* %p) {
; CHECK-LABEL: select_consts_use_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    cmpq $42, %rsi
; CHECK-NEXT:    movl $43, %eax
; CHECK-NEXT:    cmovgel %ecx, %eax
; CHECK-NEXT:    movl %eax, (%rdx)
; CHECK-NEXT:    addl %edi, %eax
; CHECK-NEXT:    retq
  %b = icmp sgt i64 %x, 41
  %s = select i1 %b, i32 0, i32 43
  store i32 %s, i32* %p
  %r = add i32 %offset, %s
  ret i32 %r
}

define i32 @select_40_43_i32(i32 %offset, i64 %x) {
; CHECK-LABEL: select_40_43_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    cmpq $42, %rsi
; CHECK-NEXT:    setl %al
; CHECK-NEXT:    leal (%rax,%rax,2), %eax
; CHECK-NEXT:    leal 40(%rdi,%rax), %eax
; CHECK-NEXT:    retq
  %b = icmp sgt i64 %x, 41
  %s = select i1 %b, i32 40, i32 43
  %r = add i32 %offset, %s
  ret i32 %r
}

define i32 @select_0_1_i32(i32 %offset, i64 %x) {
; CHECK-LABEL: select_0_1_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cmpq $42, %rsi
; CHECK-NEXT:    adcl $0, %eax
; CHECK-NEXT:    retq
  %b = icmp ugt i64 %x, 41
  %s = select i1 %b, i32 0, i32 1
  %r = add i32 %offset, %s
  ret i32 %r
}

define i32 @select_1_0_i32(i32 %offset, i64 %x) {
; CHECK-LABEL: select_1_0_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cmpq $42, %rsi
; CHECK-NEXT:    sbbl $-1, %eax
; CHECK-NEXT:    retq
  %b = icmp ugt i64 %x, 41
  %s = select i1 %b, i32 1, i32 0
  %r = add i32 %offset, %s
  ret i32 %r
}
