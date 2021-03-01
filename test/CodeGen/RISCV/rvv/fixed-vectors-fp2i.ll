; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1

define void @fp2si_v2f32_v2i32(<2 x float>* %x, <2 x i32>* %y) {
; CHECK-LABEL: fp2si_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e32,m1,ta,mu
; CHECK-NEXT:    vle32.v v25, (a0)
; CHECK-NEXT:    vfcvt.rtz.x.f.v v25, v25
; CHECK-NEXT:    vse32.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, <2 x float>* %x
  %d = fptosi <2 x float> %a to <2 x i32>
  store <2 x i32> %d, <2 x i32>* %y
  ret void
}

define void @fp2ui_v2f32_v2i32(<2 x float>* %x, <2 x i32>* %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e32,m1,ta,mu
; CHECK-NEXT:    vle32.v v25, (a0)
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v25, v25
; CHECK-NEXT:    vse32.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, <2 x float>* %x
  %d = fptoui <2 x float> %a to <2 x i32>
  store <2 x i32> %d, <2 x i32>* %y
  ret void
}

define void @fp2si_v8f32_v8i32(<8 x float>* %x, <8 x i32>* %y) {
; LMULMAX8-LABEL: fp2si_v8f32_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vle32.v v26, (a0)
; LMULMAX8-NEXT:    vfcvt.rtz.x.f.v v26, v26
; LMULMAX8-NEXT:    vse32.v v26, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f32_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v25, (a2)
; LMULMAX1-NEXT:    vle32.v v26, (a0)
; LMULMAX1-NEXT:    vfcvt.rtz.x.f.v v25, v25
; LMULMAX1-NEXT:    vfcvt.rtz.x.f.v v26, v26
; LMULMAX1-NEXT:    vse32.v v26, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse32.v v25, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, <8 x float>* %x
  %d = fptosi <8 x float> %a to <8 x i32>
  store <8 x i32> %d, <8 x i32>* %y
  ret void
}

define void @fp2ui_v8f32_v8i32(<8 x float>* %x, <8 x i32>* %y) {
; LMULMAX8-LABEL: fp2ui_v8f32_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vle32.v v26, (a0)
; LMULMAX8-NEXT:    vfcvt.rtz.xu.f.v v26, v26
; LMULMAX8-NEXT:    vse32.v v26, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f32_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v25, (a2)
; LMULMAX1-NEXT:    vle32.v v26, (a0)
; LMULMAX1-NEXT:    vfcvt.rtz.xu.f.v v25, v25
; LMULMAX1-NEXT:    vfcvt.rtz.xu.f.v v26, v26
; LMULMAX1-NEXT:    vse32.v v26, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse32.v v25, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, <8 x float>* %x
  %d = fptoui <8 x float> %a to <8 x i32>
  store <8 x i32> %d, <8 x i32>* %y
  ret void
}

define void @fp2si_v2f32_v2i64(<2 x float>* %x, <2 x i64>* %y) {
; CHECK-LABEL: fp2si_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e32,m1,ta,mu
; CHECK-NEXT:    vle32.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v26, v25
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vse64.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, <2 x float>* %x
  %d = fptosi <2 x float> %a to <2 x i64>
  store <2 x i64> %d, <2 x i64>* %y
  ret void
}

define void @fp2ui_v2f32_v2i64(<2 x float>* %x, <2 x i64>* %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e32,m1,ta,mu
; CHECK-NEXT:    vle32.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v26, v25
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vse64.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, <2 x float>* %x
  %d = fptoui <2 x float> %a to <2 x i64>
  store <2 x i64> %d, <2 x i64>* %y
  ret void
}

define void @fp2si_v8f32_v8i64(<8 x float>* %x, <8 x i64>* %y) {
; LMULMAX8-LABEL: fp2si_v8f32_v8i64:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vle32.v v26, (a0)
; LMULMAX8-NEXT:    vfwcvt.rtz.x.f.v v28, v26
; LMULMAX8-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; LMULMAX8-NEXT:    vse64.v v28, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f32_v8i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v25, (a2)
; LMULMAX1-NEXT:    vle32.v v26, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v27, v25
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 2
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v28, v25
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v25, v26
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v26, v26, 2
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfwcvt.rtz.x.f.v v29, v26
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vsetivli a2, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vse64.v v29, (a0)
; LMULMAX1-NEXT:    vse64.v v25, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 48
; LMULMAX1-NEXT:    vse64.v v28, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 32
; LMULMAX1-NEXT:    vse64.v v27, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, <8 x float>* %x
  %d = fptosi <8 x float> %a to <8 x i64>
  store <8 x i64> %d, <8 x i64>* %y
  ret void
}

define void @fp2ui_v8f32_v8i64(<8 x float>* %x, <8 x i64>* %y) {
; LMULMAX8-LABEL: fp2ui_v8f32_v8i64:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vle32.v v26, (a0)
; LMULMAX8-NEXT:    vfwcvt.rtz.xu.f.v v28, v26
; LMULMAX8-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; LMULMAX8-NEXT:    vse64.v v28, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f32_v8i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle32.v v25, (a2)
; LMULMAX1-NEXT:    vle32.v v26, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v27, v25
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 2
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v28, v25
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v25, v26
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v26, v26, 2
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfwcvt.rtz.xu.f.v v29, v26
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vsetivli a2, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vse64.v v29, (a0)
; LMULMAX1-NEXT:    vse64.v v25, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 48
; LMULMAX1-NEXT:    vse64.v v28, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 32
; LMULMAX1-NEXT:    vse64.v v27, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <8 x float>, <8 x float>* %x
  %d = fptoui <8 x float> %a to <8 x i64>
  store <8 x i64> %d, <8 x i64>* %y
  ret void
}

define void @fp2si_v2f16_v2i64(<2 x half>* %x, <2 x i64>* %y) {
; CHECK-LABEL: fp2si_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e16,m1,ta,mu
; CHECK-NEXT:    vle16.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; CHECK-NEXT:    vfwcvt.f.f.v v26, v25
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v25, v26
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vse64.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, <2 x half>* %x
  %d = fptosi <2 x half> %a to <2 x i64>
  store <2 x i64> %d, <2 x i64>* %y
  ret void
}

define void @fp2ui_v2f16_v2i64(<2 x half>* %x, <2 x i64>* %y) {
; CHECK-LABEL: fp2ui_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e16,m1,ta,mu
; CHECK-NEXT:    vle16.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; CHECK-NEXT:    vfwcvt.f.f.v v26, v25
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v25, v26
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vse64.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, <2 x half>* %x
  %d = fptoui <2 x half> %a to <2 x i64>
  store <2 x i64> %d, <2 x i64>* %y
  ret void
}

define void @fp2si_v2f64_v2i8(<2 x double>* %x, <2 x i8>* %y) {
; CHECK-LABEL: fp2si_v2f64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e64,m1,ta,mu
; CHECK-NEXT:    vle64.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfncvt.rtz.x.f.w v26, v25
; CHECK-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; CHECK-NEXT:    vnsrl.wi v25, v26, 0
; CHECK-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; CHECK-NEXT:    vnsrl.wi v26, v25, 0
; CHECK-NEXT:    vsetivli a0, 2, e8,m1,ta,mu
; CHECK-NEXT:    vse8.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, <2 x double>* %x
  %d = fptosi <2 x double> %a to <2 x i8>
  store <2 x i8> %d, <2 x i8>* %y
  ret void
}

define void @fp2ui_v2f64_v2i8(<2 x double>* %x, <2 x i8>* %y) {
; CHECK-LABEL: fp2ui_v2f64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e64,m1,ta,mu
; CHECK-NEXT:    vle64.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v26, v25
; CHECK-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; CHECK-NEXT:    vnsrl.wi v25, v26, 0
; CHECK-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; CHECK-NEXT:    vnsrl.wi v26, v25, 0
; CHECK-NEXT:    vsetivli a0, 2, e8,m1,ta,mu
; CHECK-NEXT:    vse8.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, <2 x double>* %x
  %d = fptoui <2 x double> %a to <2 x i8>
  store <2 x i8> %d, <2 x i8>* %y
  ret void
}

define void @fp2si_v8f64_v8i8(<8 x double>* %x, <8 x i8>* %y) {
; LMULMAX8-LABEL: fp2si_v8f64_v8i8:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e64,m4,ta,mu
; LMULMAX8-NEXT:    vle64.v v28, (a0)
; LMULMAX8-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vfncvt.rtz.x.f.w v26, v28
; LMULMAX8-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; LMULMAX8-NEXT:    vnsrl.wi v25, v26, 0
; LMULMAX8-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; LMULMAX8-NEXT:    vnsrl.wi v26, v25, 0
; LMULMAX8-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX8-NEXT:    vse8.v v26, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2si_v8f64_v8i8:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vsetivli a3, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vle64.v v25, (a2)
; LMULMAX1-NEXT:    vle64.v v26, (a0)
; LMULMAX1-NEXT:    addi a2, a0, 32
; LMULMAX1-NEXT:    vle64.v v27, (a2)
; LMULMAX1-NEXT:    addi a0, a0, 48
; LMULMAX1-NEXT:    vle64.v v28, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v29, v27
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v27, v29, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v29, v27, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v27, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,m1,tu,mu
; LMULMAX1-NEXT:    vmv1r.v v30, v27
; LMULMAX1-NEXT:    vslideup.vi v30, v29, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v29, v28
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v28, v29, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v29, v28, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v30, v29, 2
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v28, v26
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v26, v28, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v28, v26, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v27, v28, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.x.f.w v26, v25
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v25, v26, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v26, v25, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v27, v26, 2
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v25, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v25, v27, 0
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v25, v30, 4
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vse8.v v25, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x double>, <8 x double>* %x
  %d = fptosi <8 x double> %a to <8 x i8>
  store <8 x i8> %d, <8 x i8>* %y
  ret void
}

define void @fp2ui_v8f64_v8i8(<8 x double>* %x, <8 x i8>* %y) {
; LMULMAX8-LABEL: fp2ui_v8f64_v8i8:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e64,m4,ta,mu
; LMULMAX8-NEXT:    vle64.v v28, (a0)
; LMULMAX8-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vfncvt.rtz.xu.f.w v26, v28
; LMULMAX8-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; LMULMAX8-NEXT:    vnsrl.wi v25, v26, 0
; LMULMAX8-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; LMULMAX8-NEXT:    vnsrl.wi v26, v25, 0
; LMULMAX8-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX8-NEXT:    vse8.v v26, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX1-LABEL: fp2ui_v8f64_v8i8:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vsetivli a3, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vle64.v v25, (a2)
; LMULMAX1-NEXT:    vle64.v v26, (a0)
; LMULMAX1-NEXT:    addi a2, a0, 32
; LMULMAX1-NEXT:    vle64.v v27, (a2)
; LMULMAX1-NEXT:    addi a0, a0, 48
; LMULMAX1-NEXT:    vle64.v v28, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v29, v27
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v27, v29, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v29, v27, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v27, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,m1,tu,mu
; LMULMAX1-NEXT:    vmv1r.v v30, v27
; LMULMAX1-NEXT:    vslideup.vi v30, v29, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v29, v28
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v28, v29, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v29, v28, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v30, v29, 2
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v28, v26
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v26, v28, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v28, v26, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v27, v28, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; LMULMAX1-NEXT:    vfncvt.rtz.xu.f.w v26, v25
; LMULMAX1-NEXT:    vsetivli a0, 2, e16,mf2,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v25, v26, 0
; LMULMAX1-NEXT:    vsetivli a0, 2, e8,mf4,ta,mu
; LMULMAX1-NEXT:    vnsrl.wi v26, v25, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v27, v26, 2
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v25, 0
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v25, v27, 0
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,tu,mu
; LMULMAX1-NEXT:    vslideup.vi v25, v30, 4
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vse8.v v25, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x double>, <8 x double>* %x
  %d = fptoui <8 x double> %a to <8 x i8>
  store <8 x i8> %d, <8 x i8>* %y
  ret void
}
