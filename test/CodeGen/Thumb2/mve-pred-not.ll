; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc <4 x i32> @cmpeqz_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpeqz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpnez_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpnez_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpsltz_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpsltz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpsgtz_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpsgtz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpslez_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpslez_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpsgez_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpsgez_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpultz_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpultz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpugtz_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpugtz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpulez_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpulez_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpugez_v4i1(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: cmpugez_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}



define arm_aapcs_vfpcc <4 x i32> @cmpeq_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpeq_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpne_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpne_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpslt_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpslt_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpsgt_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpsgt_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpsle_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpsle_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpsge_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpsge_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpult_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpult_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpugt_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpugt_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpule_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpule_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpuge_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpuge_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %o = xor <4 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}




define arm_aapcs_vfpcc <8 x i16> @cmpeqz_v8i1(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: cmpeqz_v8i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i16 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <8 x i16> %a, zeroinitializer
  %o = xor <8 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <8 x i1> %o, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %s
}

define arm_aapcs_vfpcc <8 x i16> @cmpeq_v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c) {
; CHECK-LABEL: cmpeq_v8i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i16 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <8 x i16> %a, zeroinitializer
  %o = xor <8 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <8 x i1> %o, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %s
}


define arm_aapcs_vfpcc <16 x i8> @cmpeqz_v16i1(<16 x i8> %a, <16 x i8> %b) {
; CHECK-LABEL: cmpeqz_v16i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i8 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <16 x i8> %a, zeroinitializer
  %o = xor <16 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <16 x i1> %o, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %s
}

define arm_aapcs_vfpcc <16 x i8> @cmpeq_v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: cmpeq_v16i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vcmp.i8 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <16 x i8> %a, zeroinitializer
  %o = xor <16 x i1> %c1, <i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1>
  %s = select <16 x i1> %o, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %s
}


define arm_aapcs_vfpcc <2 x i64> @cmpeqz_v2i1(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LABEL: cmpeqz_v2i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov r1, s2
; CHECK-NEXT:    vmov r2, s0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s1
; CHECK-NEXT:    cset r0, eq
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    cset r1, eq
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vbic q0, q0, q2
; CHECK-NEXT:    vand q1, q1, q2
; CHECK-NEXT:    vorr q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <2 x i64> %a, zeroinitializer
  %o = xor <2 x i1> %c1, <i1 -1, i1 -1>
  %s = select <2 x i1> %o, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %s
}

define arm_aapcs_vfpcc <2 x i64> @cmpeq_v2i1(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c) {
; CHECK-LABEL: cmpeq_v2i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov r1, s2
; CHECK-NEXT:    vmov r2, s0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s1
; CHECK-NEXT:    cset r0, eq
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    cset r1, eq
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vbic q0, q0, q2
; CHECK-NEXT:    vand q1, q1, q2
; CHECK-NEXT:    vorr q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <2 x i64> %a, zeroinitializer
  %o = xor <2 x i1> %c1, <i1 -1, i1 -1>
  %s = select <2 x i1> %o, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %s
}

define arm_aapcs_vfpcc <4 x i32> @vpnot_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: vpnot_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpte.s32 lt, q0, zr
; CHECK-NEXT:    vcmpt.s32 gt, q1, zr
; CHECK-NEXT:    vcmpe.i32 eq, q2, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <4 x i32> %a, zeroinitializer
  %c2 = icmp sgt <4 x i32> %b, zeroinitializer
  %c3 = icmp eq <4 x i32> %c, zeroinitializer
  %o1 = and <4 x i1> %c1, %c2
  %o2 = xor <4 x i1> %o1, <i1 -1, i1 -1, i1 -1, i1 -1>
  %o = and <4 x i1> %c3, %o2
  %s = select <4 x i1> %o, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

declare <4 x i32> @llvm.arm.mve.max.predicated.v4i32.v4i1(<4 x i32>, <4 x i32>, i32, <4 x i1>, <4 x i32>)
declare <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32>, <4 x i32>, <4 x i1>, <4 x i32>)

define arm_aapcs_vfpcc <4 x i32> @vpttet_v4i1(<4 x i32> %x, <4 x i32> %y, <4 x i32> %z) {
; CHECK-LABEL: vpttet_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpttet.s32 ge, q0, q2
; CHECK-NEXT:    vmovt q0, q2
; CHECK-NEXT:    vmovt q0, q2
; CHECK-NEXT:    vmove q0, q2
; CHECK-NEXT:    vmovt q0, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp sge <4 x i32> %x, %z
  %1 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %0, <4 x i32> %x)
  %2 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %0, <4 x i32> %1)
  %3 = xor <4 x i1> %0, <i1 true, i1 true, i1 true, i1 true>
  %4 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %3, <4 x i32> %2)
  %5 = xor <4 x i1> %3, <i1 true, i1 true, i1 true, i1 true>
  %6 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %5, <4 x i32> %4)
  ret <4 x i32> %6
}

define arm_aapcs_vfpcc <4 x i32> @vpttee_v4i1(<4 x i32> %x, <4 x i32> %y, <4 x i32> %z) {
; CHECK-LABEL: vpttee_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q3, q2
; CHECK-NEXT:    vpttee.s32 ge, q0, q2
; CHECK-NEXT:    vmaxt.s32 q3, q0, q1
; CHECK-NEXT:    vcmpt.s32 gt, q0, zr
; CHECK-NEXT:    vmove q3, q2
; CHECK-NEXT:    vmove q3, q2
; CHECK-NEXT:    vmov q0, q3
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp sge <4 x i32> %x, %z
  %1 = tail call <4 x i32> @llvm.arm.mve.max.predicated.v4i32.v4i1(<4 x i32> %x, <4 x i32> %y, i32 0, <4 x i1> %0, <4 x i32> %z)
  %2 = icmp sgt <4 x i32> %x, zeroinitializer
  %3 = and <4 x i1> %0, %2
  %4 = xor <4 x i1> %3, <i1 true, i1 true, i1 true, i1 true>
  %5 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %4, <4 x i32> %1)
  %6 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %4, <4 x i32> %5)
  ret <4 x i32> %6
}

define arm_aapcs_vfpcc <4 x i32> @vpttee2_v4i1(<4 x i32> %x, <4 x i32> %y, <4 x i32> %z) {
; CHECK-LABEL: vpttee2_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q3, q2
; CHECK-NEXT:    vpttee.s32 ge, q0, q2
; CHECK-NEXT:    vmaxt.s32 q3, q0, q1
; CHECK-NEXT:    vcmpt.s32 gt, q0, zr
; CHECK-NEXT:    vcmpe.s32 gt, q1, zr
; CHECK-NEXT:    vmove q3, q2
; CHECK-NEXT:    vmov q0, q3
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp sge <4 x i32> %x, %z
  %1 = tail call <4 x i32> @llvm.arm.mve.max.predicated.v4i32.v4i1(<4 x i32> %x, <4 x i32> %y, i32 0, <4 x i1> %0, <4 x i32> %z)
  %2 = icmp sgt <4 x i32> %x, zeroinitializer
  %3 = and <4 x i1> %0, %2
  %4 = xor <4 x i1> %3, <i1 true, i1 true, i1 true, i1 true>
  %5 = icmp sgt <4 x i32> %y, zeroinitializer
  %6 = and <4 x i1> %5, %4
  %7 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %6, <4 x i32> %1)
  ret <4 x i32> %7
}

define arm_aapcs_vfpcc <4 x i32> @vpttte_v4i1(<4 x i32> %x, <4 x i32> %y, <4 x i32> %z) {
; CHECK-LABEL: vpttte_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q3, q2
; CHECK-NEXT:    vpttte.s32 ge, q0, q2
; CHECK-NEXT:    vmaxt.s32 q3, q0, q1
; CHECK-NEXT:    vcmpt.s32 gt, q0, zr
; CHECK-NEXT:    vmovt q3, q2
; CHECK-NEXT:    vmove q3, q2
; CHECK-NEXT:    vmov q0, q3
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp sge <4 x i32> %x, %z
  %1 = tail call <4 x i32> @llvm.arm.mve.max.predicated.v4i32.v4i1(<4 x i32> %x, <4 x i32> %y, i32 0, <4 x i1> %0, <4 x i32> %z)
  %2 = icmp sgt <4 x i32> %x, zeroinitializer
  %3 = and <4 x i1> %0, %2
  %4 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %3, <4 x i32> %1)
  %5 = xor <4 x i1> %3, <i1 true, i1 true, i1 true, i1 true>
  %6 = tail call <4 x i32> @llvm.arm.mve.orr.predicated.v4i32.v4i1(<4 x i32> %z, <4 x i32> %z, <4 x i1> %5, <4 x i32> %4)
  ret <4 x i32> %6
}
