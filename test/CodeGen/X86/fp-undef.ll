; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown                        | FileCheck %s --check-prefixes=ANY,STRICT
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -enable-unsafe-fp-math | FileCheck %s --check-prefixes=ANY,UNSAFE

; This is duplicated from tests for InstSimplify. If you're
; adding something here, you should probably add it there too.

define float @fadd_undef_op0(float %x) {
; ANY-LABEL: fadd_undef_op0:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fadd float undef, %x
  ret float %r
}

define float @fadd_undef_op1(float %x) {
; ANY-LABEL: fadd_undef_op1:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fadd float %x, undef
  ret float %r
}

define float @fsub_undef_op0(float %x) {
; ANY-LABEL: fsub_undef_op0:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fsub float undef, %x
  ret float %r
}

define float @fsub_undef_op1(float %x) {
; ANY-LABEL: fsub_undef_op1:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fsub float %x, undef
  ret float %r
}

define float @fmul_undef_op0(float %x) {
; ANY-LABEL: fmul_undef_op0:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fmul float undef, %x
  ret float %r
}

define float @fmul_undef_op1(float %x) {
; ANY-LABEL: fmul_undef_op1:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fmul float %x, undef
  ret float %r
}

define float @fdiv_undef_op0(float %x) {
; ANY-LABEL: fdiv_undef_op0:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fdiv float undef, %x
  ret float %r
}

define float @fdiv_undef_op1(float %x) {
; ANY-LABEL: fdiv_undef_op1:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fdiv float %x, undef
  ret float %r
}

define float @frem_undef_op0(float %x) {
; ANY-LABEL: frem_undef_op0:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = frem float undef, %x
  ret float %r
}

define float @frem_undef_op1(float %x) {
; ANY-LABEL: frem_undef_op1:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = frem float %x, undef
  ret float %r
}

; Repeat all tests with fast-math-flags. Alternate 'nnan' and 'fast' for more coverage.

define float @fadd_undef_op0_nnan(float %x) {
; ANY-LABEL: fadd_undef_op0_nnan:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fadd nnan float undef, %x
  ret float %r
}

define float @fadd_undef_op1_fast(float %x) {
; ANY-LABEL: fadd_undef_op1_fast:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fadd fast float %x, undef
  ret float %r
}

define float @fsub_undef_op0_fast(float %x) {
; ANY-LABEL: fsub_undef_op0_fast:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fsub fast float undef, %x
  ret float %r
}

define float @fsub_undef_op1_nnan(float %x) {
; ANY-LABEL: fsub_undef_op1_nnan:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fsub nnan float %x, undef
  ret float %r
}

define float @fmul_undef_op0_nnan(float %x) {
; ANY-LABEL: fmul_undef_op0_nnan:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fmul nnan float undef, %x
  ret float %r
}

define float @fmul_undef_op1_fast(float %x) {
; ANY-LABEL: fmul_undef_op1_fast:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fmul fast float %x, undef
  ret float %r
}

define float @fdiv_undef_op0_fast(float %x) {
; ANY-LABEL: fdiv_undef_op0_fast:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fdiv fast float undef, %x
  ret float %r
}

define float @fdiv_undef_op1_nnan(float %x) {
; ANY-LABEL: fdiv_undef_op1_nnan:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fdiv nnan float %x, undef
  ret float %r
}

define float @frem_undef_op0_nnan(float %x) {
; ANY-LABEL: frem_undef_op0_nnan:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = frem nnan float undef, %x
  ret float %r
}

define float @frem_undef_op1_fast(float %x) {
; ANY-LABEL: frem_undef_op1_fast:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = frem fast float %x, undef
  ret float %r
}

; Constant folding - undef undef.

define double @fadd_undef_undef(double %x) {
; ANY-LABEL: fadd_undef_undef:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fadd double undef, undef
  ret double %r
}

define double @fsub_undef_undef(double %x) {
; ANY-LABEL: fsub_undef_undef:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fsub double undef, undef
  ret double %r
}

define double @fmul_undef_undef(double %x) {
; ANY-LABEL: fmul_undef_undef:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fmul double undef, undef
  ret double %r
}

define double @fdiv_undef_undef(double %x) {
; ANY-LABEL: fdiv_undef_undef:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = fdiv double undef, undef
  ret double %r
}

define double @frem_undef_undef(double %x) {
; ANY-LABEL: frem_undef_undef:
; ANY:       # %bb.0:
; ANY-NEXT:    retq
  %r = frem double undef, undef
  ret double %r
}

; Constant folding.

define float @fadd_undef_op0_nnan_constant(float %x) {
; ANY-LABEL: fadd_undef_op0_nnan_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fadd nnan float undef, 1.0
  ret float %r
}

define float @fadd_undef_op1_constant(float %x) {
; ANY-LABEL: fadd_undef_op1_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fadd float 2.0, undef
  ret float %r
}

define float @fsub_undef_op0_fast_constant(float %x) {
; ANY-LABEL: fsub_undef_op0_fast_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fsub fast float undef, 3.0
  ret float %r
}

define float @fsub_undef_op1_constant(float %x) {
; ANY-LABEL: fsub_undef_op1_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fsub float 4.0, undef
  ret float %r
}

define float @fmul_undef_op0_nnan_constant(float %x) {
; ANY-LABEL: fmul_undef_op0_nnan_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fmul nnan float undef, 5.0
  ret float %r
}

define float @fmul_undef_op1_constant(float %x) {
; ANY-LABEL: fmul_undef_op1_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fmul float 6.0, undef
  ret float %r
}

define float @fdiv_undef_op0_fast_constant(float %x) {
; ANY-LABEL: fdiv_undef_op0_fast_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fdiv fast float undef, 7.0
  ret float %r
}

define float @fdiv_undef_op1_constant(float %x) {
; ANY-LABEL: fdiv_undef_op1_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = fdiv float 8.0, undef
  ret float %r
}

define float @frem_undef_op0_nnan_constant(float %x) {
; ANY-LABEL: frem_undef_op0_nnan_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = frem nnan float undef, 9.0
  ret float %r
}

define float @frem_undef_op1_constant(float %x) {
; ANY-LABEL: frem_undef_op1_constant:
; ANY:       # %bb.0:
; ANY-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; ANY-NEXT:    retq
  %r = frem float 10.0, undef
  ret float %r
}

; Constant folding - special constants: NaN.

define double @fadd_undef_op0_constant_nan(double %x) {
; ANY-LABEL: fadd_undef_op0_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fadd double undef, 0x7FF8000000000000
  ret double %r
}

define double @fadd_undef_op1_fast_constant_nan(double %x) {
; ANY-LABEL: fadd_undef_op1_fast_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fadd fast double 0xFFF0000000000001, undef
  ret double %r
}

define double @fsub_undef_op0_constant_nan(double %x) {
; ANY-LABEL: fsub_undef_op0_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fsub double undef, 0xFFF8000000000010
  ret double %r
}

define double @fsub_undef_op1_nnan_constant_nan(double %x) {
; ANY-LABEL: fsub_undef_op1_nnan_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fsub nnan double 0x7FF0000000000011, undef
  ret double %r
}

define double @fmul_undef_op0_constant_nan(double %x) {
; ANY-LABEL: fmul_undef_op0_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fmul double undef, 0x7FF8000000000100
  ret double %r
}

define double @fmul_undef_op1_fast_constant_nan(double %x) {
; ANY-LABEL: fmul_undef_op1_fast_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fmul fast double 0xFFF0000000000101, undef
  ret double %r
}

define double @fdiv_undef_op0_constant_nan(double %x) {
; ANY-LABEL: fdiv_undef_op0_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fdiv double undef, 0xFFF8000000000110
  ret double %r
}

define double @fdiv_undef_op1_nnan_constant_nan(double %x) {
; ANY-LABEL: fdiv_undef_op1_nnan_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fdiv nnan double 0x7FF0000000000111, undef
  ret double %r
}

define double @frem_undef_op0_constant_nan(double %x) {
; ANY-LABEL: frem_undef_op0_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = frem double undef, 0x7FF8000000001000
  ret double %r
}

define double @frem_undef_op1_fast_constant_nan(double %x) {
; ANY-LABEL: frem_undef_op1_fast_constant_nan:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = frem fast double 0xFFF0000000001001, undef
  ret double %r
}

; Constant folding - special constants: Inf.

define double @fadd_undef_op0_constant_inf(double %x) {
; ANY-LABEL: fadd_undef_op0_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fadd double undef, 0x7FF0000000000000
  ret double %r
}

define double @fadd_undef_op1_fast_constant_inf(double %x) {
; ANY-LABEL: fadd_undef_op1_fast_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fadd fast double 0xFFF0000000000000, undef
  ret double %r
}

define double @fsub_undef_op0_constant_inf(double %x) {
; ANY-LABEL: fsub_undef_op0_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fsub double undef, 0xFFF0000000000000
  ret double %r
}

define double @fsub_undef_op1_ninf_constant_inf(double %x) {
; ANY-LABEL: fsub_undef_op1_ninf_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fsub ninf double 0x7FF0000000000000, undef
  ret double %r
}

define double @fmul_undef_op0_constant_inf(double %x) {
; ANY-LABEL: fmul_undef_op0_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fmul double undef, 0x7FF0000000000000
  ret double %r
}

define double @fmul_undef_op1_fast_constant_inf(double %x) {
; ANY-LABEL: fmul_undef_op1_fast_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fmul fast double 0xFFF0000000000000, undef
  ret double %r
}

define double @fdiv_undef_op0_constant_inf(double %x) {
; ANY-LABEL: fdiv_undef_op0_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fdiv double undef, 0xFFF0000000000000
  ret double %r
}

define double @fdiv_undef_op1_ninf_constant_inf(double %x) {
; ANY-LABEL: fdiv_undef_op1_ninf_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = fdiv ninf double 0x7FF0000000000000, undef
  ret double %r
}

define double @frem_undef_op0_constant_inf(double %x) {
; ANY-LABEL: frem_undef_op0_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = frem double undef, 0x7FF0000000000000
  ret double %r
}

define double @frem_undef_op1_fast_constant_inf(double %x) {
; ANY-LABEL: frem_undef_op1_fast_constant_inf:
; ANY:       # %bb.0:
; ANY-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; ANY-NEXT:    retq
  %r = frem fast double 0xFFF0000000000000, undef
  ret double %r
}

