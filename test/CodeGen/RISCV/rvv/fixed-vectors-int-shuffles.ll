; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <4 x i16> @shuffle_v4i16(<4 x i16> %x, <4 x i16> %y) {
; CHECK-LABEL: shuffle_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 11
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> %y, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  ret <4 x i16> %s
}

define <8 x i32> @shuffle_v8i32(<8 x i32> %x, <8 x i32> %y) {
; CHECK-LABEL: shuffle_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 203
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> %y, <8 x i32> <i32 0, i32 1, i32 10, i32 3, i32 12, i32 13, i32 6, i32 7>
  ret <8 x i32> %s
}

define <4 x i16> @shuffle_xv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shuffle_xv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 9
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vmerge.vim v8, v8, 5, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i16> %x, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x i16> %s
}

define <4 x i16> @shuffle_vx_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shuffle_vx_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 6
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vmerge.vim v8, v8, 5, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_permute_shuffle_vu_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_permute_shuffle_vu_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI4_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI4_0)
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a0)
; CHECK-NEXT:    vrgather.vv v25, v8, v26
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 1>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_permute_shuffle_uv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_permute_shuffle_uv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI5_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI5_0)
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a0)
; CHECK-NEXT:    vrgather.vv v25, v8, v26
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> undef, <4 x i16> %x, <4 x i32> <i32 5, i32 6, i32 4, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_vv_v4i16(<4 x i16> %x, <4 x i16> %y) {
; CHECK-LABEL: vrgather_shuffle_vv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 1
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vmv.s.x v25, a0
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,tu,mu
; CHECK-NEXT:    vslideup.vi v26, v25, 3
; CHECK-NEXT:    lui a0, %hi(.LCPI6_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI6_0)
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vle16.v v27, (a0)
; CHECK-NEXT:    vrgather.vv v25, v8, v27
; CHECK-NEXT:    addi a0, zero, 8
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,tu,mu
; CHECK-NEXT:    vrgather.vv v25, v9, v26, v0.t
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> %y, <4 x i32> <i32 1, i32 2, i32 0, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_xv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_shuffle_xv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 12
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    lui a0, %hi(.LCPI7_0)
; CHECK-NEXT:    addi a0, a0, %lo(.LCPI7_0)
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a0)
; CHECK-NEXT:    vmv.v.i v25, 5
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,tu,mu
; CHECK-NEXT:    vrgather.vv v25, v8, v26, v0.t
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i16> %x, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_vx_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_shuffle_vx_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 3
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vmv.s.x v25, a0
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vsetivli zero, 2, e16,mf2,tu,mu
; CHECK-NEXT:    vslideup.vi v26, v25, 1
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli zero, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 5
; CHECK-NEXT:    vsetvli zero, zero, e16,mf2,tu,mu
; CHECK-NEXT:    vrgather.vv v25, v8, v26, v0.t
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x i16> %s
}

define <8 x i64> @vrgather_permute_shuffle_vu_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_permute_shuffle_vu_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI9_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV32-NEXT:    vrgatherei16.vv v28, v8, v25
; RV32-NEXT:    vmv4r.v v8, v28
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_vu_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI9_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v12, (a0)
; RV64-NEXT:    vrgather.vv v28, v8, v12
; RV64-NEXT:    vmv4r.v v8, v28
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> undef, <8 x i32> <i32 1, i32 2, i32 0, i32 1, i32 7, i32 6, i32 0, i32 1>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_permute_shuffle_uv_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_permute_shuffle_uv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI10_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI10_0)
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV32-NEXT:    vrgatherei16.vv v28, v8, v25
; RV32-NEXT:    vmv4r.v v8, v28
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_uv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI10_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI10_0)
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v12, (a0)
; RV64-NEXT:    vrgather.vv v28, v8, v12
; RV64-NEXT:    vmv4r.v v8, v28
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> undef, <8 x i64> %x, <8 x i32> <i32 9, i32 10, i32 8, i32 9, i32 15, i32 8, i32 8, i32 11>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_vv_v8i64(<8 x i64> %x, <8 x i64> %y) {
; RV32-LABEL: vrgather_shuffle_vv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a0, zero, 5
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vmv.s.x v25, a0
; RV32-NEXT:    addi a0, zero, 36
; RV32-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vmv.v.i v26, 0
; RV32-NEXT:    vmerge.vim v26, v26, 2, v0
; RV32-NEXT:    vsetvli zero, zero, e16,m1,tu,mu
; RV32-NEXT:    vslideup.vi v26, v25, 7
; RV32-NEXT:    lui a0, %hi(.LCPI11_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI11_0)
; RV32-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV32-NEXT:    vrgatherei16.vv v28, v8, v25
; RV32-NEXT:    addi a0, zero, 164
; RV32-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetivli zero, 8, e64,m4,tu,mu
; RV32-NEXT:    vrgatherei16.vv v28, v12, v26, v0.t
; RV32-NEXT:    vmv4r.v v8, v28
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a0, zero, 5
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vmv.s.x v28, a0
; RV64-NEXT:    addi a0, zero, 36
; RV64-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vmv.v.i v16, 0
; RV64-NEXT:    vmerge.vim v16, v16, 2, v0
; RV64-NEXT:    vsetvli zero, zero, e64,m4,tu,mu
; RV64-NEXT:    vslideup.vi v16, v28, 7
; RV64-NEXT:    lui a0, %hi(.LCPI11_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI11_0)
; RV64-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v20, (a0)
; RV64-NEXT:    vrgather.vv v28, v8, v20
; RV64-NEXT:    addi a0, zero, 164
; RV64-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetivli zero, 8, e64,m4,tu,mu
; RV64-NEXT:    vrgather.vv v28, v12, v16, v0.t
; RV64-NEXT:    vmv4r.v v8, v28
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> %y, <8 x i32> <i32 1, i32 2, i32 10, i32 5, i32 1, i32 10, i32 3, i32 13>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_xv_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_shuffle_xv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a0, zero, 6
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vmv.s.x v25, a0
; RV32-NEXT:    addi a0, zero, 4
; RV32-NEXT:    vmv.s.x v26, a0
; RV32-NEXT:    vmv.v.i v27, 0
; RV32-NEXT:    vsetivli zero, 6, e16,m1,tu,mu
; RV32-NEXT:    vslideup.vi v27, v26, 5
; RV32-NEXT:    vsetivli zero, 7, e16,m1,tu,mu
; RV32-NEXT:    vslideup.vi v27, v25, 6
; RV32-NEXT:    lui a0, %hi(.LCPI12_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI12_0)
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV32-NEXT:    vmv.v.i v12, -1
; RV32-NEXT:    vrgatherei16.vv v28, v12, v25
; RV32-NEXT:    addi a0, zero, 113
; RV32-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetivli zero, 8, e64,m4,tu,mu
; RV32-NEXT:    vrgatherei16.vv v28, v8, v27, v0.t
; RV32-NEXT:    vmv4r.v v8, v28
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_xv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a0, zero, 6
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vmv.s.x v28, a0
; RV64-NEXT:    addi a0, zero, 4
; RV64-NEXT:    vmv.s.x v12, a0
; RV64-NEXT:    vmv.v.i v16, 0
; RV64-NEXT:    vsetivli zero, 6, e64,m4,tu,mu
; RV64-NEXT:    vslideup.vi v16, v12, 5
; RV64-NEXT:    vsetivli zero, 7, e64,m4,tu,mu
; RV64-NEXT:    vslideup.vi v16, v28, 6
; RV64-NEXT:    addi a0, zero, 113
; RV64-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vmv.v.i v28, -1
; RV64-NEXT:    vsetvli zero, zero, e64,m4,tu,mu
; RV64-NEXT:    vrgather.vv v28, v8, v16, v0.t
; RV64-NEXT:    vmv4r.v v8, v28
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, <8 x i64> %x, <8 x i32> <i32 8, i32 3, i32 6, i32 5, i32 8, i32 12, i32 14, i32 3>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_vx_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_shuffle_vx_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI13_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI13_0)
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vmv4r.v v28, v8
; RV32-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV32-NEXT:    vrgatherei16.vv v8, v28, v25
; RV32-NEXT:    addi a0, zero, 140
; RV32-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    lui a0, %hi(.LCPI13_1)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI13_1)
; RV32-NEXT:    vsetivli zero, 8, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV32-NEXT:    vmv.v.i v28, 5
; RV32-NEXT:    vsetvli zero, zero, e64,m4,tu,mu
; RV32-NEXT:    vrgatherei16.vv v8, v28, v25, v0.t
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vx_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a0, zero, 115
; RV64-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    lui a0, %hi(.LCPI13_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI13_0)
; RV64-NEXT:    vsetivli zero, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v12, (a0)
; RV64-NEXT:    vmv.v.i v28, 5
; RV64-NEXT:    vsetvli zero, zero, e64,m4,tu,mu
; RV64-NEXT:    vrgather.vv v28, v8, v12, v0.t
; RV64-NEXT:    vmv4r.v v8, v28
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> <i64 5, i64 5, i64 5, i64 5, i64 5, i64 5, i64 5, i64 5>, <8 x i32> <i32 0, i32 3, i32 10, i32 9, i32 4, i32 1, i32 7, i32 14>
  ret <8 x i64> %s
}

define <4 x i8> @interleave_shuffles(<4 x i8> %x) {
; CHECK-LABEL: interleave_shuffles:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    vsetivli zero, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vrgather.vi v25, v8, 1
; CHECK-NEXT:    addi a1, zero, 1
; CHECK-NEXT:    vmv.s.x v26, a1
; CHECK-NEXT:    vmv.v.i v27, 0
; CHECK-NEXT:    vsetvli zero, zero, e8,mf4,tu,mu
; CHECK-NEXT:    vslideup.vi v27, v26, 3
; CHECK-NEXT:    addi a1, zero, 10
; CHECK-NEXT:    vsetivli zero, 1, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a1
; CHECK-NEXT:    vsetivli zero, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vmv.v.x v8, a0
; CHECK-NEXT:    vsetvli zero, zero, e8,mf4,tu,mu
; CHECK-NEXT:    vrgather.vv v8, v25, v27, v0.t
; CHECK-NEXT:    ret
  %y = shufflevector <4 x i8> %x, <4 x i8> undef, <4 x i32> <i32 0, i32 0, i32 0, i32 0>
  %z = shufflevector <4 x i8> %x, <4 x i8> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
  %w = shufflevector <4 x i8> %y, <4 x i8> %z, <4 x i32> <i32 0, i32 4, i32 1, i32 5>
  ret <4 x i8> %w
}
