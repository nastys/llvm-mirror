; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=RV32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=RV64

; FIXME: This codegen needs to be improved. These tests previously asserted
; type legalizing the i64 type on RV32.

define void @insertelt_v4i64(<4 x i64>* %x, i64 %y) {
; RV32-LABEL: insertelt_v4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli a3, 4, e64,m2,ta,mu
; RV32-NEXT:    vle64.v v26, (a0)
; RV32-NEXT:    vsetvli a3, zero, e64,m2,ta,mu
; RV32-NEXT:    vmv.v.x v28, a2
; RV32-NEXT:    addi a2, zero, 32
; RV32-NEXT:    vsll.vx v28, v28, a2
; RV32-NEXT:    vmv.v.x v30, a1
; RV32-NEXT:    vsll.vx v30, v30, a2
; RV32-NEXT:    vsrl.vx v30, v30, a2
; RV32-NEXT:    vor.vv v28, v30, v28
; RV32-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV32-NEXT:    vid.v v30
; RV32-NEXT:    vmseq.vi v0, v30, 3
; RV32-NEXT:    vmerge.vvm v26, v26, v28, v0
; RV32-NEXT:    vse64.v v26, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: insertelt_v4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli a2, 4, e64,m2,ta,mu
; RV64-NEXT:    vle64.v v26, (a0)
; RV64-NEXT:    vslidedown.vi v28, v26, 3
; RV64-NEXT:    vsetvli a2, zero, e64,m2,ta,mu
; RV64-NEXT:    vmv.s.x v28, a1
; RV64-NEXT:    vsetivli a1, 4, e64,m2,tu,mu
; RV64-NEXT:    vslideup.vi v26, v28, 3
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vse64.v v26, (a0)
; RV64-NEXT:    ret
  %a = load <4 x i64>, <4 x i64>* %x
  %b = insertelement <4 x i64> %a, i64 %y, i32 3
  store <4 x i64> %b, <4 x i64>* %x
  ret void
}

; This uses a non-power of 2 type so that it isn't an MVT.
; The align keeps the type legalizer from using a 256 bit load so we must split
; it. This some operations that weren't support for scalable vectors when
; this test was written.
define void @insertelt_v3i64(<3 x i64>* %x, i64 %y) {
; RV32-LABEL: insertelt_v3i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    addi a3, a0, 16
; RV32-NEXT:    vsetivli a4, 2, e32,m1,ta,mu
; RV32-NEXT:    vle32.v v25, (a3)
; RV32-NEXT:    vse32.v v25, (sp)
; RV32-NEXT:    vsetivli a3, 2, e64,m1,ta,mu
; RV32-NEXT:    vle64.v v26, (a0)
; RV32-NEXT:    vsetivli a3, 8, e32,m2,ta,mu
; RV32-NEXT:    vmv.v.i v28, 0
; RV32-NEXT:    vsetivli a3, 2, e64,m2,tu,mu
; RV32-NEXT:    vslideup.vi v28, v26, 0
; RV32-NEXT:    vsetivli a3, 4, e32,m1,ta,mu
; RV32-NEXT:    vle32.v v26, (sp)
; RV32-NEXT:    vsetivli a3, 4, e64,m2,tu,mu
; RV32-NEXT:    vslideup.vi v28, v26, 2
; RV32-NEXT:    vsetvli a3, zero, e64,m2,ta,mu
; RV32-NEXT:    vmv.v.x v26, a2
; RV32-NEXT:    addi a3, zero, 32
; RV32-NEXT:    vsll.vx v26, v26, a3
; RV32-NEXT:    vmv.v.x v30, a1
; RV32-NEXT:    vsll.vx v30, v30, a3
; RV32-NEXT:    vsrl.vx v30, v30, a3
; RV32-NEXT:    vor.vv v26, v30, v26
; RV32-NEXT:    vsetivli a3, 4, e64,m2,ta,mu
; RV32-NEXT:    vid.v v30
; RV32-NEXT:    vmseq.vi v0, v30, 2
; RV32-NEXT:    vmerge.vvm v26, v28, v26, v0
; RV32-NEXT:    vsetivli a3, 2, e64,m1,ta,mu
; RV32-NEXT:    vse64.v v26, (a0)
; RV32-NEXT:    sw a1, 16(a0)
; RV32-NEXT:    sw a2, 20(a0)
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: insertelt_v3i64:
; RV64:       # %bb.0:
; RV64-NEXT:    sd a1, 16(a0)
; RV64-NEXT:    ret
  %a = load <3 x i64>, <3 x i64>* %x, align 8
  %b = insertelement <3 x i64> %a, i64 %y, i32 2
  store <3 x i64> %b, <3 x i64>* %x
  ret void
}

define void @insertelt_v16i8(<16 x i8>* %x, i8 %y) {
; RV32-LABEL: insertelt_v16i8:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; RV32-NEXT:    vle8.v v25, (a0)
; RV32-NEXT:    vslidedown.vi v26, v25, 14
; RV32-NEXT:    vsetvli a2, zero, e8,m1,ta,mu
; RV32-NEXT:    vmv.s.x v26, a1
; RV32-NEXT:    vsetivli a1, 16, e8,m1,tu,mu
; RV32-NEXT:    vslideup.vi v25, v26, 14
; RV32-NEXT:    vsetivli a1, 16, e8,m1,ta,mu
; RV32-NEXT:    vse8.v v25, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: insertelt_v16i8:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; RV64-NEXT:    vle8.v v25, (a0)
; RV64-NEXT:    vslidedown.vi v26, v25, 14
; RV64-NEXT:    vsetvli a2, zero, e8,m1,ta,mu
; RV64-NEXT:    vmv.s.x v26, a1
; RV64-NEXT:    vsetivli a1, 16, e8,m1,tu,mu
; RV64-NEXT:    vslideup.vi v25, v26, 14
; RV64-NEXT:    vsetivli a1, 16, e8,m1,ta,mu
; RV64-NEXT:    vse8.v v25, (a0)
; RV64-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> %a, i8 %y, i32 14
  store <16 x i8> %b, <16 x i8>* %x
  ret void
}

define void @insertelt_v32i16(<32 x i16>* %x, i16 %y, i32 %idx) {
; RV32-LABEL: insertelt_v32i16:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a3, zero, 32
; RV32-NEXT:    vsetvli a4, a3, e16,m4,ta,mu
; RV32-NEXT:    vle16.v v28, (a0)
; RV32-NEXT:    vslidedown.vx v8, v28, a2
; RV32-NEXT:    vsetvli a4, zero, e16,m4,ta,mu
; RV32-NEXT:    vmv.s.x v8, a1
; RV32-NEXT:    vsetvli a1, a3, e16,m4,tu,mu
; RV32-NEXT:    vslideup.vx v28, v8, a2
; RV32-NEXT:    vsetvli a1, a3, e16,m4,ta,mu
; RV32-NEXT:    vse16.v v28, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: insertelt_v32i16:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a3, zero, 32
; RV64-NEXT:    vsetvli a4, a3, e16,m4,ta,mu
; RV64-NEXT:    vle16.v v28, (a0)
; RV64-NEXT:    sext.w a2, a2
; RV64-NEXT:    vslidedown.vx v8, v28, a2
; RV64-NEXT:    vsetvli a4, zero, e16,m4,ta,mu
; RV64-NEXT:    vmv.s.x v8, a1
; RV64-NEXT:    vsetvli a1, a3, e16,m4,tu,mu
; RV64-NEXT:    vslideup.vx v28, v8, a2
; RV64-NEXT:    vsetvli a1, a3, e16,m4,ta,mu
; RV64-NEXT:    vse16.v v28, (a0)
; RV64-NEXT:    ret
  %a = load <32 x i16>, <32 x i16>* %x
  %b = insertelement <32 x i16> %a, i16 %y, i32 %idx
  store <32 x i16> %b, <32 x i16>* %x
  ret void
}

define void @insertelt_v8f32(<8 x float>* %x, float %y, i32 %idx) {
; RV32-LABEL: insertelt_v8f32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; RV32-NEXT:    vle32.v v26, (a0)
; RV32-NEXT:    vslidedown.vx v28, v26, a1
; RV32-NEXT:    vsetvli a2, zero, e32,m2,ta,mu
; RV32-NEXT:    vfmv.s.f v28, fa0
; RV32-NEXT:    vsetivli a2, 8, e32,m2,tu,mu
; RV32-NEXT:    vslideup.vx v26, v28, a1
; RV32-NEXT:    vsetivli a1, 8, e32,m2,ta,mu
; RV32-NEXT:    vse32.v v26, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: insertelt_v8f32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; RV64-NEXT:    vle32.v v26, (a0)
; RV64-NEXT:    sext.w a1, a1
; RV64-NEXT:    vslidedown.vx v28, v26, a1
; RV64-NEXT:    vsetvli a2, zero, e32,m2,ta,mu
; RV64-NEXT:    vfmv.s.f v28, fa0
; RV64-NEXT:    vsetivli a2, 8, e32,m2,tu,mu
; RV64-NEXT:    vslideup.vx v26, v28, a1
; RV64-NEXT:    vsetivli a1, 8, e32,m2,ta,mu
; RV64-NEXT:    vse32.v v26, (a0)
; RV64-NEXT:    ret
  %a = load <8 x float>, <8 x float>* %x
  %b = insertelement <8 x float> %a, float %y, i32 %idx
  store <8 x float> %b, <8 x float>* %x
  ret void
}
