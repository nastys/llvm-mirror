; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp %s -o - | FileCheck %s

define void @remat_vctp(i32* %arg, i32* %arg1, i32* %arg2, i32* %arg3, i32* %arg4, i16 zeroext %arg5) {
; CHECK-LABEL: remat_vctp:
; CHECK:       @ %bb.0: @ %bb
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    ldrd r5, r12, [sp, #80]
; CHECK-NEXT:    vmvn.i32 q0, #0x80000000
; CHECK-NEXT:    vmov.i32 q1, #0x3f
; CHECK-NEXT:    vmov.i32 q2, #0x1
; CHECK-NEXT:    dlstp.32 lr, r12
; CHECK-NEXT:  .LBB0_1: @ %bb6
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q4, [r1], #16
; CHECK-NEXT:    vabs.s32 q5, q4
; CHECK-NEXT:    vcls.s32 q3, q5
; CHECK-NEXT:    vshl.u32 q5, q5, q3
; CHECK-NEXT:    vadd.i32 q3, q3, q2
; CHECK-NEXT:    vshr.u32 q6, q5, #24
; CHECK-NEXT:    vand q6, q6, q1
; CHECK-NEXT:    vldrw.u32 q7, [r5, q6, uxtw #2]
; CHECK-NEXT:    vqrdmulh.s32 q6, q7, q5
; CHECK-NEXT:    vqsub.s32 q6, q0, q6
; CHECK-NEXT:    vqrdmulh.s32 q6, q7, q6
; CHECK-NEXT:    vqshl.s32 q6, q6, #1
; CHECK-NEXT:    vqrdmulh.s32 q5, q6, q5
; CHECK-NEXT:    vqsub.s32 q5, q0, q5
; CHECK-NEXT:    vqrdmulh.s32 q5, q6, q5
; CHECK-NEXT:    vqshl.s32 q5, q5, #1
; CHECK-NEXT:    vpt.s32 lt, q4, zr
; CHECK-NEXT:    vnegt.s32 q5, q5
; CHECK-NEXT:    vldrw.u32 q4, [r0], #16
; CHECK-NEXT:    vqrdmulh.s32 q4, q4, q5
; CHECK-NEXT:    vstrw.32 q4, [r2], #16
; CHECK-NEXT:    vstrw.32 q3, [r3], #16
; CHECK-NEXT:    letp lr, .LBB0_1
; CHECK-NEXT:  @ %bb.2: @ %bb44
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    pop {r4, r5, r7, pc}
bb:
  %i = zext i16 %arg5 to i32
  br label %bb6

bb6:                                              ; preds = %bb6, %bb
  %i7 = phi i32* [ %arg3, %bb ], [ %i38, %bb6 ]
  %i8 = phi i32 [ %i, %bb ], [ %i42, %bb6 ]
  %i9 = phi i32* [ %arg2, %bb ], [ %i41, %bb6 ]
  %i10 = phi i32* [ %arg1, %bb ], [ %i40, %bb6 ]
  %i11 = phi i32* [ %arg, %bb ], [ %i39, %bb6 ]
  %i12 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %i8)
  %i13 = bitcast i32* %i11 to <4 x i32>*
  %i14 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %i13, i32 4, <4 x i1> %i12, <4 x i32> zeroinitializer)
  %i15 = bitcast i32* %i10 to <4 x i32>*
  %i16 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %i15, i32 4, <4 x i1> %i12, <4 x i32> zeroinitializer)
  %i17 = icmp slt <4 x i32> %i16, zeroinitializer
  %i18 = sub <4 x i32> zeroinitializer, %i16
  %i19 = select <4 x i1> %i17, <4 x i32> %i18, <4 x i32> %i16
  %i20 = tail call <4 x i32> @llvm.arm.mve.vcls.v4i32(<4 x i32> %i19)
  %i21 = shl <4 x i32> %i19, %i20
  %i22 = add <4 x i32> %i20, <i32 1, i32 1, i32 1, i32 1>
  %i23 = lshr <4 x i32> %i21, <i32 24, i32 24, i32 24, i32 24>
  %i24 = and <4 x i32> %i23, <i32 63, i32 63, i32 63, i32 63>
  %i25 = tail call <4 x i32> @llvm.arm.mve.vldr.gather.offset.v4i32.p0i32.v4i32(i32* %arg4, <4 x i32> %i24, i32 32, i32 2, i32 0)
  %i26 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i25, <4 x i32> %i21)
  %i27 = tail call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>, <4 x i32> %i26)
  %i28 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i25, <4 x i32> %i27)
  %i29 = tail call <4 x i32> @llvm.arm.mve.vqshl.imm.v4i32(<4 x i32> %i28, i32 1, i32 0)
  %i30 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i29, <4 x i32> %i21)
  %i31 = tail call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>, <4 x i32> %i30)
  %i32 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i29, <4 x i32> %i31)
  %i33 = tail call <4 x i32> @llvm.arm.mve.vqshl.imm.v4i32(<4 x i32> %i32, i32 1, i32 0)
  %i34 = tail call <4 x i32> @llvm.arm.mve.neg.predicated.v4i32.v4i1(<4 x i32> %i33, <4 x i1> %i17, <4 x i32> %i33)
  %i35 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i14, <4 x i32> %i34)
  %i36 = bitcast i32* %i9 to <4 x i32>*
  %i37 = bitcast i32* %i7 to <4 x i32>*
  tail call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %i35, <4 x i32>* %i36, i32 4, <4 x i1> %i12)
  tail call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %i22, <4 x i32>* %i37, i32 4, <4 x i1> %i12)
  %i38 = getelementptr inbounds i32, i32* %i7, i32 4
  %i39 = getelementptr inbounds i32, i32* %i11, i32 4
  %i40 = getelementptr inbounds i32, i32* %i10, i32 4
  %i41 = getelementptr inbounds i32, i32* %i9, i32 4
  %i42 = add nsw i32 %i8, -4
  %i43 = icmp sgt i32 %i8, 4
  br i1 %i43, label %bb6, label %bb44

bb44:                                             ; preds = %bb6
  ret void
}

define void @dont_remat_predicated_vctp(i32* %arg, i32* %arg1, i32* %arg2, i32* %arg3, i32* %arg4, i16 zeroext %arg5, i32 %conv.mask) {
; CHECK-LABEL: dont_remat_predicated_vctp:
; CHECK:       @ %bb.0: @ %bb
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    ldrd r6, r12, [sp, #88]
; CHECK-NEXT:    movs r4, #4
; CHECK-NEXT:    cmp.w r12, #4
; CHECK-NEXT:    vmvn.i32 q0, #0x80000000
; CHECK-NEXT:    csel r5, r12, r4, lt
; CHECK-NEXT:    vmov.i32 q1, #0x3f
; CHECK-NEXT:    sub.w r5, r12, r5
; CHECK-NEXT:    vmov.i32 q2, #0x1
; CHECK-NEXT:    add.w lr, r5, #3
; CHECK-NEXT:    movs r5, #1
; CHECK-NEXT:    add.w r5, r5, lr, lsr #2
; CHECK-NEXT:    dls lr, r5
; CHECK-NEXT:  .LBB1_1: @ %bb6
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vctp.32 r12
; CHECK-NEXT:    sub.w r12, r12, #4
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vctpt.32 r4
; CHECK-NEXT:    vstr p0, [sp, #4] @ 4-byte Spill
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vldrwt.u32 q4, [r1], #16
; CHECK-NEXT:    vabs.s32 q5, q4
; CHECK-NEXT:    vcls.s32 q3, q5
; CHECK-NEXT:    vshl.u32 q5, q5, q3
; CHECK-NEXT:    vadd.i32 q3, q3, q2
; CHECK-NEXT:    vshr.u32 q6, q5, #24
; CHECK-NEXT:    vand q6, q6, q1
; CHECK-NEXT:    vldrw.u32 q7, [r6, q6, uxtw #2]
; CHECK-NEXT:    vqrdmulh.s32 q6, q7, q5
; CHECK-NEXT:    vqsub.s32 q6, q0, q6
; CHECK-NEXT:    vqrdmulh.s32 q6, q7, q6
; CHECK-NEXT:    vqshl.s32 q6, q6, #1
; CHECK-NEXT:    vqrdmulh.s32 q5, q6, q5
; CHECK-NEXT:    vqsub.s32 q5, q0, q5
; CHECK-NEXT:    vqrdmulh.s32 q5, q6, q5
; CHECK-NEXT:    vqshl.s32 q5, q5, #1
; CHECK-NEXT:    vpt.s32 lt, q4, zr
; CHECK-NEXT:    vnegt.s32 q5, q5
; CHECK-NEXT:    vldr p0, [sp, #4] @ 4-byte Reload
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vldrwt.u32 q4, [r0], #16
; CHECK-NEXT:    vqrdmulh.s32 q4, q4, q5
; CHECK-NEXT:    vpstt
; CHECK-NEXT:    vstrwt.32 q4, [r2], #16
; CHECK-NEXT:    vstrwt.32 q3, [r3], #16
; CHECK-NEXT:    le lr, .LBB1_1
; CHECK-NEXT:  @ %bb.2: @ %bb44
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    pop {r4, r5, r6, pc}
bb:
  %i = zext i16 %arg5 to i32
  br label %bb6

bb6:                                              ; preds = %bb6, %bb
  %i7 = phi i32* [ %arg3, %bb ], [ %i38, %bb6 ]
  %i8 = phi i32 [ %i, %bb ], [ %i42, %bb6 ]
  %i9 = phi i32* [ %arg2, %bb ], [ %i41, %bb6 ]
  %i10 = phi i32* [ %arg1, %bb ], [ %i40, %bb6 ]
  %i11 = phi i32* [ %arg, %bb ], [ %i39, %bb6 ]
  %i12 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 4)
  %mask = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %i8)
  %pred = and <4 x i1> %i12, %mask
  %i13 = bitcast i32* %i11 to <4 x i32>*
  %i14 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %i13, i32 4, <4 x i1> %pred, <4 x i32> zeroinitializer)
  %i15 = bitcast i32* %i10 to <4 x i32>*
  %i16 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %i15, i32 4, <4 x i1> %pred, <4 x i32> zeroinitializer)
  %i17 = icmp slt <4 x i32> %i16, zeroinitializer
  %i18 = sub <4 x i32> zeroinitializer, %i16
  %i19 = select <4 x i1> %i17, <4 x i32> %i18, <4 x i32> %i16
  %i20 = tail call <4 x i32> @llvm.arm.mve.vcls.v4i32(<4 x i32> %i19)
  %i21 = shl <4 x i32> %i19, %i20
  %i22 = add <4 x i32> %i20, <i32 1, i32 1, i32 1, i32 1>
  %i23 = lshr <4 x i32> %i21, <i32 24, i32 24, i32 24, i32 24>
  %i24 = and <4 x i32> %i23, <i32 63, i32 63, i32 63, i32 63>
  %i25 = tail call <4 x i32> @llvm.arm.mve.vldr.gather.offset.v4i32.p0i32.v4i32(i32* %arg4, <4 x i32> %i24, i32 32, i32 2, i32 0)
  %i26 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i25, <4 x i32> %i21)
  %i27 = tail call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>, <4 x i32> %i26)
  %i28 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i25, <4 x i32> %i27)
  %i29 = tail call <4 x i32> @llvm.arm.mve.vqshl.imm.v4i32(<4 x i32> %i28, i32 1, i32 0)
  %i30 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i29, <4 x i32> %i21)
  %i31 = tail call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>, <4 x i32> %i30)
  %i32 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i29, <4 x i32> %i31)
  %i33 = tail call <4 x i32> @llvm.arm.mve.vqshl.imm.v4i32(<4 x i32> %i32, i32 1, i32 0)
  %i34 = tail call <4 x i32> @llvm.arm.mve.neg.predicated.v4i32.v4i1(<4 x i32> %i33, <4 x i1> %i17, <4 x i32> %i33)
  %i35 = tail call <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32> %i14, <4 x i32> %i34)
  %i36 = bitcast i32* %i9 to <4 x i32>*
  %i37 = bitcast i32* %i7 to <4 x i32>*
  tail call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %i35, <4 x i32>* %i36, i32 4, <4 x i1> %pred)
  tail call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %i22, <4 x i32>* %i37, i32 4, <4 x i1> %pred)
  %i38 = getelementptr inbounds i32, i32* %i7, i32 4
  %i39 = getelementptr inbounds i32, i32* %i11, i32 4
  %i40 = getelementptr inbounds i32, i32* %i10, i32 4
  %i41 = getelementptr inbounds i32, i32* %i9, i32 4
  %i42 = add nsw i32 %i8, -4
  %i43 = icmp sgt i32 %i8, 4
  br i1 %i43, label %bb6, label %bb44

bb44:                                             ; preds = %bb6
  ret void
}

declare <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32)
declare <4 x i1> @llvm.arm.mve.vctp32(i32)
declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32 immarg, <4 x i1>, <4 x i32>)
declare <4 x i32> @llvm.arm.mve.vqrdmulh.v4i32(<4 x i32>, <4 x i32>)
declare void @llvm.masked.store.v4i32.p0v4i32(<4 x i32>, <4 x i32>*, i32 immarg, <4 x i1>)
declare <4 x i32> @llvm.arm.mve.vcls.v4i32(<4 x i32>)
declare <4 x i32> @llvm.arm.mve.vldr.gather.offset.v4i32.p0i32.v4i32(i32*, <4 x i32>, i32, i32, i32)
declare <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32>, <4 x i32>)
declare <4 x i32> @llvm.arm.mve.vqshl.imm.v4i32(<4 x i32>, i32, i32)
declare <4 x i32> @llvm.arm.mve.neg.predicated.v4i32.v4i1(<4 x i32>, <4 x i1>, <4 x i32>)
