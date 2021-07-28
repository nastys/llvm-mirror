; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2   | FileCheck %s --check-prefixes=CHECK,AVX

; fold (add x, 0) -> x
define <4 x i32> @combine_vec_add_to_zero(<4 x i32> %a) {
; CHECK-LABEL: combine_vec_add_to_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = add <4 x i32> %a, zeroinitializer
  ret <4 x i32> %1
}

; fold ((c1-A)+c2) -> (c1+c2)-A
define <4 x i32> @combine_vec_add_constant_sub(<4 x i32> %a) {
; SSE-LABEL: combine_vec_add_constant_sub:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm1 = [0,2,4,6]
; SSE-NEXT:    psubd %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_constant_sub:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovdqa {{.*#+}} xmm1 = [0,2,4,6]
; AVX-NEXT:    vpsubd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> <i32 0, i32 1, i32 2, i32 3>, %a
  %2 = add <4 x i32> <i32 0, i32 1, i32 2, i32 3>, %1
  ret <4 x i32> %2
}

; fold ((0-A) + B) -> B-A
define <4 x i32> @combine_vec_add_neg0(<4 x i32> %a, <4 x i32> %b) {
; SSE-LABEL: combine_vec_add_neg0:
; SSE:       # %bb.0:
; SSE-NEXT:    psubd %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_neg0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> zeroinitializer, %a
  %2 = add <4 x i32> %1, %b
  ret <4 x i32> %2
}

; fold (A + (0-B)) -> A-B
define <4 x i32> @combine_vec_add_neg1(<4 x i32> %a, <4 x i32> %b) {
; SSE-LABEL: combine_vec_add_neg1:
; SSE:       # %bb.0:
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_neg1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> zeroinitializer, %b
  %2 = add <4 x i32> %a, %1
  ret <4 x i32> %2
}

; fold (A+(B-A)) -> B
define <4 x i32> @combine_vec_add_sub0(<4 x i32> %a, <4 x i32> %b) {
; SSE-LABEL: combine_vec_add_sub0:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub0:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %b, %a
  %2 = add <4 x i32> %a, %1
  ret <4 x i32> %2
}

; fold ((B-A)+A) -> B
define <4 x i32> @combine_vec_add_sub1(<4 x i32> %a, <4 x i32> %b) {
; SSE-LABEL: combine_vec_add_sub1:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub1:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %b, %a
  %2 = add <4 x i32> %1, %a
  ret <4 x i32> %2
}

; fold ((A-B)+(C-A)) -> (C-B)
define <4 x i32> @combine_vec_add_sub_sub0(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; SSE-LABEL: combine_vec_add_sub_sub0:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm2, %xmm0
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_sub0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm1, %xmm2, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %a, %b
  %2 = sub <4 x i32> %c, %a
  %3 = add <4 x i32> %1, %2
  ret <4 x i32> %3
}

; fold ((A-B)+(B-C)) -> (A-C)
define <4 x i32> @combine_vec_add_sub_sub1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; SSE-LABEL: combine_vec_add_sub_sub1:
; SSE:       # %bb.0:
; SSE-NEXT:    psubd %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_sub1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %a, %b
  %2 = sub <4 x i32> %b, %c
  %3 = add <4 x i32> %1, %2
  ret <4 x i32> %3
}

; fold (A+(B-(A+C))) to (B-C)
define <4 x i32> @combine_vec_add_sub_add0(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; SSE-LABEL: combine_vec_add_sub_add0:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    psubd %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_add0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm2, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = add <4 x i32> %a, %c
  %2 = sub <4 x i32> %b, %1
  %3 = add <4 x i32> %a, %2
  ret <4 x i32> %3
}

; fold (A+(B-(C+A))) to (B-C)
define <4 x i32> @combine_vec_add_sub_add1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; SSE-LABEL: combine_vec_add_sub_add1:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    psubd %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_add1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm2, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = add <4 x i32> %c, %a
  %2 = sub <4 x i32> %b, %1
  %3 = add <4 x i32> %a, %2
  ret <4 x i32> %3
}

; fold (A+((B-A)+C)) to (B+C)
define <4 x i32> @combine_vec_add_sub_add2(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; SSE-LABEL: combine_vec_add_sub_add2:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    paddd %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_add2:
; AVX:       # %bb.0:
; AVX-NEXT:    vpaddd %xmm2, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %b, %a
  %2 = add <4 x i32> %1, %c
  %3 = add <4 x i32> %a, %2
  ret <4 x i32> %3
}

; fold (A+((B-A)-C)) to (B-C)
define <4 x i32> @combine_vec_add_sub_add3(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; SSE-LABEL: combine_vec_add_sub_add3:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    psubd %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_add3:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm2, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %b, %a
  %2 = sub <4 x i32> %1, %c
  %3 = add <4 x i32> %a, %2
  ret <4 x i32> %3
}

; fold (A-B)+(C-D) to (A+C)-(B+D) when A or C is constant
define <4 x i32> @combine_vec_add_sub_sub(<4 x i32> %a, <4 x i32> %b, <4 x i32> %d) {
; SSE-LABEL: combine_vec_add_sub_sub:
; SSE:       # %bb.0:
; SSE-NEXT:    paddd %xmm2, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sub_sub:
; AVX:       # %bb.0:
; AVX-NEXT:    vpaddd %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> %a, %b
  %2 = sub <4 x i32> <i32 0, i32 1, i32 2, i32 3>, %d
  %3 = add <4 x i32> %1, %2
  ret <4 x i32> %3
}

; fold (a+b) -> (a|b) iff a and b share no bits.
define <4 x i32> @combine_vec_add_uniquebits(<4 x i32> %a, <4 x i32> %b) {
; SSE-LABEL: combine_vec_add_uniquebits:
; SSE:       # %bb.0:
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE-NEXT:    orps %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_uniquebits:
; AVX:       # %bb.0:
; AVX-NEXT:    vbroadcastss {{.*#+}} xmm2 = [61680,61680,61680,61680]
; AVX-NEXT:    vandps %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vbroadcastss {{.*#+}} xmm2 = [3855,3855,3855,3855]
; AVX-NEXT:    vandps %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vorps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = and <4 x i32> %a, <i32 61680, i32 61680, i32 61680, i32 61680>
  %2 = and <4 x i32> %b, <i32 3855, i32 3855, i32 3855, i32 3855>
  %3 = add <4 x i32> %1, %2
  ret <4 x i32> %3
}

; fold (add x, shl(0 - y, n)) -> sub(x, shl(y, n))
define <4 x i32> @combine_vec_add_shl_neg0(<4 x i32> %x, <4 x i32> %y) {
; SSE-LABEL: combine_vec_add_shl_neg0:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $5, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_shl_neg0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $5, %xmm1, %xmm1
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> zeroinitializer, %y
  %2 = shl <4 x i32> %1, <i32 5, i32 5, i32 5, i32 5>
  %3 = add <4 x i32> %x, %2
  ret <4 x i32> %3
}

; fold (add shl(0 - y, n), x) -> sub(x, shl(y, n))
define <4 x i32> @combine_vec_add_shl_neg1(<4 x i32> %x, <4 x i32> %y) {
; SSE-LABEL: combine_vec_add_shl_neg1:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $5, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_shl_neg1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $5, %xmm1, %xmm1
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = sub <4 x i32> zeroinitializer, %y
  %2 = shl <4 x i32> %1, <i32 5, i32 5, i32 5, i32 5>
  %3 = add <4 x i32> %2, %x
  ret <4 x i32> %3
}

; (add z, (and (sbbl x, x), 1)) -> (sub z, (sbbl x, x))
; and similar xforms where the inner op is either ~0 or 0.
define <4 x i32> @combine_vec_add_and_compare(<4 x i32> %a0, <4 x i32> %a1, <4 x i32> %a2) {
; SSE-LABEL: combine_vec_add_and_compare:
; SSE:       # %bb.0:
; SSE-NEXT:    pcmpeqd %xmm2, %xmm1
; SSE-NEXT:    psubd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_and_compare:
; AVX:       # %bb.0:
; AVX-NEXT:    vpcmpeqd %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpsubd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = icmp eq <4 x i32> %a1, %a2
  %2 = sext <4 x i1> %1 to <4 x i32>
  %3 = and <4 x i32> %2, <i32 1, i32 1, i32 1, i32 1>
  %4 = add <4 x i32> %a0, %3
  ret <4 x i32> %4
}

; add (sext i1), X -> sub X, (zext i1)
define <4 x i32> @combine_vec_add_sext(<4 x i1> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_vec_add_sext:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $31, %xmm0
; SSE-NEXT:    psrad $31, %xmm0
; SSE-NEXT:    paddd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sext:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX-NEXT:    vpsrad $31, %xmm0, %xmm0
; AVX-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = sext <4 x i1> %a0 to <4 x i32>
  %2 = add <4 x i32> %1, %a1
  ret <4 x i32> %2
}

; add (sext i1), X -> sub X, (zext i1)
define <4 x i32> @combine_vec_add_sextinreg(<4 x i32> %a0, <4 x i32> %a1) {
; SSE-LABEL: combine_vec_add_sextinreg:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $31, %xmm0
; SSE-NEXT:    psrad $31, %xmm0
; SSE-NEXT:    paddd %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_sextinreg:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX-NEXT:    vpsrad $31, %xmm0, %xmm0
; AVX-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %a0, <i32 31, i32 31, i32 31, i32 31>
  %2 = ashr <4 x i32> %1, <i32 31, i32 31, i32 31, i32 31>
  %3 = add <4 x i32> %2, %a1
  ret <4 x i32> %3
}

; (add (add (xor a, -1), b), 1) -> (sub b, a)
define i32 @combine_add_add_not(i32 %a, i32 %b) {
; CHECK-LABEL: combine_add_add_not:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %esi, %eax
; CHECK-NEXT:    subl %edi, %eax
; CHECK-NEXT:    retq
  %nota = xor i32 %a, -1
  %add = add i32 %nota, %b
  %r = add i32 %add, 1
  ret i32 %r
}

define <4 x i32> @combine_vec_add_add_not(<4 x i32> %a, <4 x i32> %b) {
; SSE-LABEL: combine_vec_add_add_not:
; SSE:       # %bb.0:
; SSE-NEXT:    psubd %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_add_not:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsubd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    retq
  %nota = xor <4 x i32> %a, <i32 -1, i32 -1, i32 -1, i32 -1>
  %add = add <4 x i32> %nota, %b
  %r = add <4 x i32> %add, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %r
}

declare {i32, i1} @llvm.sadd.with.overflow.i32(i32 %a, i32 %b)

define i1 @sadd_add(i32 %a, i32 %b, i32* %p) {
; CHECK-LABEL: sadd_add:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    notl %eax
; CHECK-NEXT:    addl %esi, %eax
; CHECK-NEXT:    seto %al
; CHECK-NEXT:    subl %edi, %esi
; CHECK-NEXT:    movl %esi, (%rdx)
; CHECK-NEXT:    retq
  %nota = xor i32 %a, -1
  %a0 = call {i32, i1} @llvm.sadd.with.overflow.i32(i32 %nota, i32 %b)
  %e0 = extractvalue {i32, i1} %a0, 0
  %e1 = extractvalue {i32, i1} %a0, 1
  %res = add i32 %e0, 1
  store i32 %res, i32* %p
  ret i1 %e1
}

declare {i8, i1} @llvm.uadd.with.overflow.i8(i8 %a, i8 %b)

define i1 @uadd_add(i8 %a, i8 %b, i8* %p) {
; CHECK-LABEL: uadd_add:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    notb %al
; CHECK-NEXT:    addb %sil, %al
; CHECK-NEXT:    setb %al
; CHECK-NEXT:    subb %dil, %sil
; CHECK-NEXT:    movb %sil, (%rdx)
; CHECK-NEXT:    retq
  %nota = xor i8 %a, -1
  %a0 = call {i8, i1} @llvm.uadd.with.overflow.i8(i8 %nota, i8 %b)
  %e0 = extractvalue {i8, i1} %a0, 0
  %e1 = extractvalue {i8, i1} %a0, 1
  %res = add i8 %e0, 1
  store i8 %res, i8* %p
  ret i1 %e1
}
