; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc <4 x i32> @cmpeqz_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpeqz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.i32 eq, q1, zr
; CHECK-NEXT:    vcmpt.i32 ne, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.i32 eq, q0, zr
; CHECK-NEXT:    vcmpt.i32 eq, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %c2 = icmp eq <4 x i32> %b, zeroinitializer
  %c3 = icmp eq <4 x i32> %c, zeroinitializer
  %c4 = select <4 x i1> %c3, <4 x i1> %c1, <4 x i1> %c2
  %s = select <4 x i1> %c4, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <8 x i16> @cmpeqz_v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c) {
; CHECK-LABEL: cmpeqz_v8i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.i16 eq, q1, zr
; CHECK-NEXT:    vcmpt.i16 ne, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.i16 eq, q0, zr
; CHECK-NEXT:    vcmpt.i16 eq, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <8 x i16> %a, zeroinitializer
  %c2 = icmp eq <8 x i16> %b, zeroinitializer
  %c3 = icmp eq <8 x i16> %c, zeroinitializer
  %c4 = select <8 x i1> %c3, <8 x i1> %c1, <8 x i1> %c2
  %s = select <8 x i1> %c4, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %s
}

define arm_aapcs_vfpcc <16 x i8> @cmpeqz_v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: cmpeqz_v16i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.i8 eq, q1, zr
; CHECK-NEXT:    vcmpt.i8 ne, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.i8 eq, q0, zr
; CHECK-NEXT:    vcmpt.i8 eq, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <16 x i8> %a, zeroinitializer
  %c2 = icmp eq <16 x i8> %b, zeroinitializer
  %c3 = icmp eq <16 x i8> %c, zeroinitializer
  %c4 = select <16 x i1> %c3, <16 x i1> %c1, <16 x i1> %c2
  %s = select <16 x i1> %c4, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %s
}

define arm_aapcs_vfpcc <2 x i64> @cmpeqz_v2i1(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c) {
; CHECK-LABEL: cmpeqz_v2i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov r0, s11
; CHECK-NEXT:    vmov r1, s10
; CHECK-NEXT:    vmov r2, s8
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s9
; CHECK-NEXT:    cset r0, eq
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    vmov r2, s4
; CHECK-NEXT:    cset r1, eq
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vmov r0, s7
; CHECK-NEXT:    vmov r1, s6
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    cset r0, eq
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    vmov r2, s0
; CHECK-NEXT:    cset r1, eq
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q3[2], q3[0], r1, r0
; CHECK-NEXT:    vmov q3[3], q3[1], r1, r0
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov r1, s2
; CHECK-NEXT:    vbic q3, q3, q2
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s1
; CHECK-NEXT:    cset r0, eq
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    cset r1, eq
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q4[2], q4[0], r1, r0
; CHECK-NEXT:    vmov q4[3], q4[1], r1, r0
; CHECK-NEXT:    vand q2, q4, q2
; CHECK-NEXT:    vorr q2, q2, q3
; CHECK-NEXT:    vbic q1, q1, q2
; CHECK-NEXT:    vand q0, q0, q2
; CHECK-NEXT:    vorr q0, q0, q1
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <2 x i64> %a, zeroinitializer
  %c2 = icmp eq <2 x i64> %b, zeroinitializer
  %c3 = icmp eq <2 x i64> %c, zeroinitializer
  %c4 = select <2 x i1> %c3, <2 x i1> %c1, <2 x i1> %c2
  %s = select <2 x i1> %c4, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %s
}

define arm_aapcs_vfpcc <4 x i32> @cmpnez_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpnez_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.i32 ne, q1, zr
; CHECK-NEXT:    vcmpt.i32 eq, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.i32 ne, q0, zr
; CHECK-NEXT:    vcmpt.i32 ne, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ne <4 x i32> %a, zeroinitializer
  %c2 = icmp ne <4 x i32> %b, zeroinitializer
  %c3 = icmp ne <4 x i32> %c, zeroinitializer
  %c4 = select <4 x i1> %c3, <4 x i1> %c1, <4 x i1> %c2
  %s = select <4 x i1> %c4, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <8 x i16> @cmpnez_v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c) {
; CHECK-LABEL: cmpnez_v8i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.i16 ne, q1, zr
; CHECK-NEXT:    vcmpt.i16 eq, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.i16 ne, q0, zr
; CHECK-NEXT:    vcmpt.i16 ne, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ne <8 x i16> %a, zeroinitializer
  %c2 = icmp ne <8 x i16> %b, zeroinitializer
  %c3 = icmp ne <8 x i16> %c, zeroinitializer
  %c4 = select <8 x i1> %c3, <8 x i1> %c1, <8 x i1> %c2
  %s = select <8 x i1> %c4, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %s
}

define arm_aapcs_vfpcc <16 x i8> @cmpnez_v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: cmpnez_v16i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.i8 ne, q1, zr
; CHECK-NEXT:    vcmpt.i8 eq, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.i8 ne, q0, zr
; CHECK-NEXT:    vcmpt.i8 ne, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ne <16 x i8> %a, zeroinitializer
  %c2 = icmp ne <16 x i8> %b, zeroinitializer
  %c3 = icmp ne <16 x i8> %c, zeroinitializer
  %c4 = select <16 x i1> %c3, <16 x i1> %c1, <16 x i1> %c2
  %s = select <16 x i1> %c4, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %s
}

define arm_aapcs_vfpcc <2 x i64> @cmpnez_v2i1(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c) {
; CHECK-LABEL: cmpnez_v2i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov r0, s11
; CHECK-NEXT:    vmov r1, s10
; CHECK-NEXT:    vmov r2, s8
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s9
; CHECK-NEXT:    cset r0, ne
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    vmov r2, s4
; CHECK-NEXT:    cset r1, ne
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vmov r0, s7
; CHECK-NEXT:    vmov r1, s6
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    cset r0, ne
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    vmov r2, s0
; CHECK-NEXT:    cset r1, ne
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q3[2], q3[0], r1, r0
; CHECK-NEXT:    vmov q3[3], q3[1], r1, r0
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov r1, s2
; CHECK-NEXT:    vbic q3, q3, q2
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmov r1, s1
; CHECK-NEXT:    cset r0, ne
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    csetm r0, ne
; CHECK-NEXT:    orrs r1, r2
; CHECK-NEXT:    cset r1, ne
; CHECK-NEXT:    cmp r1, #0
; CHECK-NEXT:    csetm r1, ne
; CHECK-NEXT:    vmov q4[2], q4[0], r1, r0
; CHECK-NEXT:    vmov q4[3], q4[1], r1, r0
; CHECK-NEXT:    vand q2, q4, q2
; CHECK-NEXT:    vorr q2, q2, q3
; CHECK-NEXT:    vbic q1, q1, q2
; CHECK-NEXT:    vand q0, q0, q2
; CHECK-NEXT:    vorr q0, q0, q1
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp ne <2 x i64> %a, zeroinitializer
  %c2 = icmp ne <2 x i64> %b, zeroinitializer
  %c3 = icmp ne <2 x i64> %c, zeroinitializer
  %c4 = select <2 x i1> %c3, <2 x i1> %c1, <2 x i1> %c2
  %s = select <2 x i1> %c4, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %s
}



define arm_aapcs_vfpcc <4 x i32> @cmpsltz_v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: cmpsltz_v4i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.s32 lt, q1, zr
; CHECK-NEXT:    vcmpt.s32 ge, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.s32 lt, q0, zr
; CHECK-NEXT:    vcmpt.s32 lt, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <4 x i32> %a, zeroinitializer
  %c2 = icmp slt <4 x i32> %b, zeroinitializer
  %c3 = icmp slt <4 x i32> %c, zeroinitializer
  %c4 = select <4 x i1> %c3, <4 x i1> %c1, <4 x i1> %c2
  %s = select <4 x i1> %c4, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <8 x i16> @cmpsltz_v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c) {
; CHECK-LABEL: cmpsltz_v8i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.s16 lt, q1, zr
; CHECK-NEXT:    vcmpt.s16 ge, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.s16 lt, q0, zr
; CHECK-NEXT:    vcmpt.s16 lt, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <8 x i16> %a, zeroinitializer
  %c2 = icmp slt <8 x i16> %b, zeroinitializer
  %c3 = icmp slt <8 x i16> %c, zeroinitializer
  %c4 = select <8 x i1> %c3, <8 x i1> %c1, <8 x i1> %c2
  %s = select <8 x i1> %c4, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %s
}

define arm_aapcs_vfpcc <16 x i8> @cmpsltz_v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c) {
; CHECK-LABEL: cmpsltz_v16i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vpt.s8 lt, q1, zr
; CHECK-NEXT:    vcmpt.s8 ge, q2, zr
; CHECK-NEXT:    vmrs r0, p0
; CHECK-NEXT:    vpt.s8 lt, q0, zr
; CHECK-NEXT:    vcmpt.s8 lt, q2, zr
; CHECK-NEXT:    vmrs r1, p0
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <16 x i8> %a, zeroinitializer
  %c2 = icmp slt <16 x i8> %b, zeroinitializer
  %c3 = icmp slt <16 x i8> %c, zeroinitializer
  %c4 = select <16 x i1> %c3, <16 x i1> %c1, <16 x i1> %c2
  %s = select <16 x i1> %c4, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %s
}

define arm_aapcs_vfpcc <2 x i64> @cmpsltz_v2i1(<2 x i64> %a, <2 x i64> %b, <2 x i64> %c) {
; CHECK-LABEL: cmpsltz_v2i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov r0, s11
; CHECK-NEXT:    vmov r1, s9
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    asrs r1, r1, #31
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vmov r0, s7
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    asrs r1, r1, #31
; CHECK-NEXT:    vmov q3[2], q3[0], r1, r0
; CHECK-NEXT:    vmov q3[3], q3[1], r1, r0
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov r1, s1
; CHECK-NEXT:    vbic q3, q3, q2
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    asrs r1, r1, #31
; CHECK-NEXT:    vmov q4[2], q4[0], r1, r0
; CHECK-NEXT:    vmov q4[3], q4[1], r1, r0
; CHECK-NEXT:    vand q2, q4, q2
; CHECK-NEXT:    vorr q2, q2, q3
; CHECK-NEXT:    vbic q1, q1, q2
; CHECK-NEXT:    vand q0, q0, q2
; CHECK-NEXT:    vorr q0, q0, q1
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp slt <2 x i64> %a, zeroinitializer
  %c2 = icmp slt <2 x i64> %b, zeroinitializer
  %c3 = icmp slt <2 x i64> %c, zeroinitializer
  %c4 = select <2 x i1> %c3, <2 x i1> %c1, <2 x i1> %c2
  %s = select <2 x i1> %c4, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %s
}



define arm_aapcs_vfpcc <4 x i32> @cmpeqz_v4i1_i1(<4 x i32> %a, <4 x i32> %b, i32 %c) {
; CHECK-LABEL: cmpeqz_v4i1_i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    cbz r0, .LBB12_2
; CHECK-NEXT:  @ %bb.1: @ %select.false
; CHECK-NEXT:    vcmp.i32 eq, q1, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB12_2:
; CHECK-NEXT:    vcmp.i32 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <4 x i32> %a, zeroinitializer
  %c2 = icmp eq <4 x i32> %b, zeroinitializer
  %c3 = icmp eq i32 %c, 0
  %c4 = select i1 %c3, <4 x i1> %c1, <4 x i1> %c2
  %s = select <4 x i1> %c4, <4 x i32> %a, <4 x i32> %b
  ret <4 x i32> %s
}

define arm_aapcs_vfpcc <8 x i16> @cmpeqz_v8i1_i1(<8 x i16> %a, <8 x i16> %b, i16 %c) {
; CHECK-LABEL: cmpeqz_v8i1_i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    lsls r0, r0, #16
; CHECK-NEXT:    beq .LBB13_2
; CHECK-NEXT:  @ %bb.1: @ %select.false
; CHECK-NEXT:    vcmp.i16 eq, q1, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB13_2:
; CHECK-NEXT:    vcmp.i16 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <8 x i16> %a, zeroinitializer
  %c2 = icmp eq <8 x i16> %b, zeroinitializer
  %c3 = icmp eq i16 %c, 0
  %c4 = select i1 %c3, <8 x i1> %c1, <8 x i1> %c2
  %s = select <8 x i1> %c4, <8 x i16> %a, <8 x i16> %b
  ret <8 x i16> %s
}

define arm_aapcs_vfpcc <16 x i8> @cmpeqz_v16i1_i1(<16 x i8> %a, <16 x i8> %b, i8 %c) {
; CHECK-LABEL: cmpeqz_v16i1_i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    lsls r0, r0, #24
; CHECK-NEXT:    beq .LBB14_2
; CHECK-NEXT:  @ %bb.1: @ %select.false
; CHECK-NEXT:    vcmp.i8 eq, q1, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB14_2:
; CHECK-NEXT:    vcmp.i8 eq, q0, zr
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %c1 = icmp eq <16 x i8> %a, zeroinitializer
  %c2 = icmp eq <16 x i8> %b, zeroinitializer
  %c3 = icmp eq i8 %c, 0
  %c4 = select i1 %c3, <16 x i1> %c1, <16 x i1> %c2
  %s = select <16 x i1> %c4, <16 x i8> %a, <16 x i8> %b
  ret <16 x i8> %s
}

define arm_aapcs_vfpcc <2 x i64> @cmpeqz_v2i1_i1(<2 x i64> %a, <2 x i64> %b, i64 %c) {
; CHECK-LABEL: cmpeqz_v2i1_i1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    vmov r2, s7
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    orrs r2, r3
; CHECK-NEXT:    vmov r3, s4
; CHECK-NEXT:    cset r2, eq
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    vmov r2, s5
; CHECK-NEXT:    csetm r12, ne
; CHECK-NEXT:    orrs r2, r3
; CHECK-NEXT:    vmov r3, s2
; CHECK-NEXT:    cset r2, eq
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    vmov r2, s3
; CHECK-NEXT:    csetm r4, ne
; CHECK-NEXT:    orrs r2, r3
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    cset r2, eq
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    vmov r2, s1
; CHECK-NEXT:    csetm lr, ne
; CHECK-NEXT:    orrs r2, r3
; CHECK-NEXT:    cset r2, eq
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    csetm r2, ne
; CHECK-NEXT:    orrs r0, r1
; CHECK-NEXT:    beq .LBB15_2
; CHECK-NEXT:  @ %bb.1: @ %select.false
; CHECK-NEXT:    vmov q2[2], q2[0], r4, r12
; CHECK-NEXT:    vmov q2[3], q2[1], r4, r12
; CHECK-NEXT:    b .LBB15_3
; CHECK-NEXT:  .LBB15_2:
; CHECK-NEXT:    vmov q2[2], q2[0], r2, lr
; CHECK-NEXT:    vmov q2[3], q2[1], r2, lr
; CHECK-NEXT:  .LBB15_3: @ %select.end
; CHECK-NEXT:    vmov r0, s10
; CHECK-NEXT:    vmov r1, s8
; CHECK-NEXT:    and r0, r0, #1
; CHECK-NEXT:    and r1, r1, #1
; CHECK-NEXT:    rsbs r0, r0, #0
; CHECK-NEXT:    rsbs r1, r1, #0
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vbic q1, q1, q2
; CHECK-NEXT:    vand q0, q0, q2
; CHECK-NEXT:    vorr q0, q0, q1
; CHECK-NEXT:    pop {r4, pc}
entry:
  %c1 = icmp eq <2 x i64> %a, zeroinitializer
  %c2 = icmp eq <2 x i64> %b, zeroinitializer
  %c3 = icmp eq i64 %c, zeroinitializer
  %c4 = select i1 %c3, <2 x i1> %c1, <2 x i1> %c2
  %s = select <2 x i1> %c4, <2 x i64> %a, <2 x i64> %b
  ret <2 x i64> %s
}
