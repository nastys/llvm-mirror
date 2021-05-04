; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basic-aa -slp-vectorizer -S -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

define void @tiny_tree_fully_vectorizable(double* noalias nocapture %dst, double* noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_fully_vectorizable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP12:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP12]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_015:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_014:%.*]] = phi double* [ [[ADD_PTR4:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_013:%.*]] = phi double* [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, double* [[SRC_ADDR_013]], i64 1
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast double* [[SRC_ADDR_013]] to <2 x double>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, <2 x double>* [[TMP0]], align 8
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds double, double* [[DST_ADDR_014]], i64 1
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double* [[DST_ADDR_014]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP1]], <2 x double>* [[TMP2]], align 8
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds double, double* [[SRC_ADDR_013]], i64 [[I_015]]
; CHECK-NEXT:    [[ADD_PTR4]] = getelementptr inbounds double, double* [[DST_ADDR_014]], i64 [[I_015]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_015]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp12 = icmp eq i64 %count, 0
  br i1 %cmp12, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.015 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.014 = phi double* [ %add.ptr4, %for.body ], [ %dst, %entry ]
  %src.addr.013 = phi double* [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load double, double* %src.addr.013, align 8
  store double %0, double* %dst.addr.014, align 8
  %arrayidx2 = getelementptr inbounds double, double* %src.addr.013, i64 1
  %1 = load double, double* %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds double, double* %dst.addr.014, i64 1
  store double %1, double* %arrayidx3, align 8
  %add.ptr = getelementptr inbounds double, double* %src.addr.013, i64 %i.015
  %add.ptr4 = getelementptr inbounds double, double* %dst.addr.014, i64 %i.015
  %inc = add i64 %i.015, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @tiny_tree_fully_vectorizable2(float* noalias nocapture %dst, float* noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_fully_vectorizable2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP20:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP20]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_022:%.*]] = phi float* [ [[ADD_PTR8:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_021:%.*]] = phi float* [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 1
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 1
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 2
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 2
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 3
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast float* [[SRC_ADDR_021]] to <4 x float>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x float>, <4 x float>* [[TMP0]], align 4
; CHECK-NEXT:    [[ARRAYIDX7:%.*]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 3
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float* [[DST_ADDR_022]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[TMP1]], <4 x float>* [[TMP2]], align 4
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 [[I_023]]
; CHECK-NEXT:    [[ADD_PTR8]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 [[I_023]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp20 = icmp eq i64 %count, 0
  br i1 %cmp20, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.023 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.022 = phi float* [ %add.ptr8, %for.body ], [ %dst, %entry ]
  %src.addr.021 = phi float* [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load float, float* %src.addr.021, align 4
  store float %0, float* %dst.addr.022, align 4
  %arrayidx2 = getelementptr inbounds float, float* %src.addr.021, i64 1
  %1 = load float, float* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds float, float* %dst.addr.022, i64 1
  store float %1, float* %arrayidx3, align 4
  %arrayidx4 = getelementptr inbounds float, float* %src.addr.021, i64 2
  %2 = load float, float* %arrayidx4, align 4
  %arrayidx5 = getelementptr inbounds float, float* %dst.addr.022, i64 2
  store float %2, float* %arrayidx5, align 4
  %arrayidx6 = getelementptr inbounds float, float* %src.addr.021, i64 3
  %3 = load float, float* %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds float, float* %dst.addr.022, i64 3
  store float %3, float* %arrayidx7, align 4
  %add.ptr = getelementptr inbounds float, float* %src.addr.021, i64 %i.023
  %add.ptr8 = getelementptr inbounds float, float* %dst.addr.022, i64 %i.023
  %inc = add i64 %i.023, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

; We do not vectorize the tiny tree which is not fully vectorizable.

define void @tiny_tree_not_fully_vectorizable(double* noalias nocapture %dst, double* noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_not_fully_vectorizable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP12:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP12]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_015:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_014:%.*]] = phi double* [ [[ADD_PTR4:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_013:%.*]] = phi double* [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load double, double* [[SRC_ADDR_013]], align 8
; CHECK-NEXT:    store double [[TMP0]], double* [[DST_ADDR_014]], align 8
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds double, double* [[SRC_ADDR_013]], i64 2
; CHECK-NEXT:    [[TMP1:%.*]] = load double, double* [[ARRAYIDX2]], align 8
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds double, double* [[DST_ADDR_014]], i64 1
; CHECK-NEXT:    store double [[TMP1]], double* [[ARRAYIDX3]], align 8
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds double, double* [[SRC_ADDR_013]], i64 [[I_015]]
; CHECK-NEXT:    [[ADD_PTR4]] = getelementptr inbounds double, double* [[DST_ADDR_014]], i64 [[I_015]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_015]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp12 = icmp eq i64 %count, 0
  br i1 %cmp12, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.015 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.014 = phi double* [ %add.ptr4, %for.body ], [ %dst, %entry ]
  %src.addr.013 = phi double* [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load double, double* %src.addr.013, align 8
  store double %0, double* %dst.addr.014, align 8
  %arrayidx2 = getelementptr inbounds double, double* %src.addr.013, i64 2
  %1 = load double, double* %arrayidx2, align 8
  %arrayidx3 = getelementptr inbounds double, double* %dst.addr.014, i64 1
  store double %1, double* %arrayidx3, align 8
  %add.ptr = getelementptr inbounds double, double* %src.addr.013, i64 %i.015
  %add.ptr4 = getelementptr inbounds double, double* %dst.addr.014, i64 %i.015
  %inc = add i64 %i.015, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @tiny_tree_not_fully_vectorizable2(float* noalias nocapture %dst, float* noalias nocapture readonly %src, i64 %count) #0 {
; CHECK-LABEL: @tiny_tree_not_fully_vectorizable2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP20:%.*]] = icmp eq i64 [[COUNT:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP20]], label [[FOR_END:%.*]], label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[I_023:%.*]] = phi i64 [ [[INC:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[DST_ADDR_022:%.*]] = phi float* [ [[ADD_PTR8:%.*]], [[FOR_BODY]] ], [ [[DST:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[SRC_ADDR_021:%.*]] = phi float* [ [[ADD_PTR:%.*]], [[FOR_BODY]] ], [ [[SRC:%.*]], [[ENTRY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load float, float* [[SRC_ADDR_021]], align 4
; CHECK-NEXT:    store float [[TMP0]], float* [[DST_ADDR_022]], align 4
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[ARRAYIDX2]], align 4
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 1
; CHECK-NEXT:    store float [[TMP1]], float* [[ARRAYIDX3]], align 4
; CHECK-NEXT:    [[ARRAYIDX4:%.*]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[ARRAYIDX4]], align 4
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 2
; CHECK-NEXT:    store float [[TMP2]], float* [[ARRAYIDX5]], align 4
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = load float, float* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ARRAYIDX7:%.*]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 3
; CHECK-NEXT:    store float [[TMP3]], float* [[ARRAYIDX7]], align 4
; CHECK-NEXT:    [[ADD_PTR]] = getelementptr inbounds float, float* [[SRC_ADDR_021]], i64 [[I_023]]
; CHECK-NEXT:    [[ADD_PTR8]] = getelementptr inbounds float, float* [[DST_ADDR_022]], i64 [[I_023]]
; CHECK-NEXT:    [[INC]] = add i64 [[I_023]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INC]], [[COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp20 = icmp eq i64 %count, 0
  br i1 %cmp20, label %for.end, label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.023 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %dst.addr.022 = phi float* [ %add.ptr8, %for.body ], [ %dst, %entry ]
  %src.addr.021 = phi float* [ %add.ptr, %for.body ], [ %src, %entry ]
  %0 = load float, float* %src.addr.021, align 4
  store float %0, float* %dst.addr.022, align 4
  %arrayidx2 = getelementptr inbounds float, float* %src.addr.021, i64 4
  %1 = load float, float* %arrayidx2, align 4
  %arrayidx3 = getelementptr inbounds float, float* %dst.addr.022, i64 1
  store float %1, float* %arrayidx3, align 4
  %arrayidx4 = getelementptr inbounds float, float* %src.addr.021, i64 2
  %2 = load float, float* %arrayidx4, align 4
  %arrayidx5 = getelementptr inbounds float, float* %dst.addr.022, i64 2
  store float %2, float* %arrayidx5, align 4
  %arrayidx6 = getelementptr inbounds float, float* %src.addr.021, i64 3
  %3 = load float, float* %arrayidx6, align 4
  %arrayidx7 = getelementptr inbounds float, float* %dst.addr.022, i64 3
  store float %3, float* %arrayidx7, align 4
  %add.ptr = getelementptr inbounds float, float* %src.addr.021, i64 %i.023
  %add.ptr8 = getelementptr inbounds float, float* %dst.addr.022, i64 %i.023
  %inc = add i64 %i.023, 1
  %exitcond = icmp eq i64 %inc, %count
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @store_splat(float*, float) {
; CHECK-LABEL: @store_splat(
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds float, float* [[TMP0:%.*]], i64 0
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds float, float* [[TMP0]], i64 1
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds float, float* [[TMP0]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds float, float* [[TMP0]], i64 3
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x float> poison, float [[TMP1:%.*]], i32 0
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <4 x float> [[TMP7]], float [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x float> [[TMP8]], float [[TMP1]], i32 2
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <4 x float> [[TMP9]], float [[TMP1]], i32 3
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast float* [[TMP3]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[TMP10]], <4 x float>* [[TMP11]], align 4
; CHECK-NEXT:    ret void
;
  %3 = getelementptr inbounds float, float* %0, i64 0
  store float %1, float* %3, align 4
  %4 = getelementptr inbounds float, float* %0, i64 1
  store float %1, float* %4, align 4
  %5 = getelementptr inbounds float, float* %0, i64 2
  store float %1, float* %5, align 4
  %6 = getelementptr inbounds float, float* %0, i64 3
  store float %1, float* %6, align 4
  ret void
}

define void @store_const(i32* %a) {
; CHECK-LABEL: @store_const(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR0:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 0
; CHECK-NEXT:    [[PTR1:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 1
; CHECK-NEXT:    [[PTR2:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 2
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 3
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[PTR0]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> <i32 10, i32 30, i32 20, i32 40>, <4 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %ptr0 = getelementptr inbounds i32, i32* %a, i64 0
  store i32 10, i32* %ptr0, align 4
  %ptr1 = getelementptr inbounds i32, i32* %a, i64 1
  store i32 30, i32* %ptr1, align 4
  %ptr2 = getelementptr inbounds i32, i32* %a, i64 2
  store i32 20, i32* %ptr2, align 4
  %ptr3 = getelementptr inbounds i32, i32* %a, i64 3
  store i32 40, i32* %ptr3, align 4
  ret void
}

define void @tiny_vector_gather(i32 *%a, i32 *%v1, i32 *%v2) {
; CHECK-LABEL: @tiny_vector_gather(
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[V1:%.*]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[V2:%.*]], align 4
; CHECK-NEXT:    [[PTR0:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 0
; CHECK-NEXT:    [[PTR1:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 1
; CHECK-NEXT:    [[PTR2:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 2
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 3
; CHECK-NEXT:    [[PTR4:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 4
; CHECK-NEXT:    [[PTR5:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 5
; CHECK-NEXT:    [[PTR6:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 6
; CHECK-NEXT:    [[PTR7:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 7
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x i32> poison, i32 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x i32> [[TMP3]], i32 [[TMP2]], i32 1
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x i32> [[TMP4]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast i32* [[PTR0]] to <8 x i32>*
; CHECK-NEXT:    store <8 x i32> [[SHUFFLE]], <8 x i32>* [[TMP5]], align 16
; CHECK-NEXT:    ret void
;
  %1 = load i32, i32* %v1, align 4
  %2 = load i32, i32* %v2, align 4
  %ptr0 = getelementptr inbounds i32, i32* %a, i64 0
  store i32 %1, i32* %ptr0, align 16
  %ptr1 = getelementptr inbounds i32, i32* %a, i64 1
  store i32 %2, i32* %ptr1, align 4
  %ptr2 = getelementptr inbounds i32, i32* %a, i64 2
  store i32 %1, i32* %ptr2, align 8
  %ptr3 = getelementptr inbounds i32, i32* %a, i64 3
  store i32 %2, i32* %ptr3, align 4
  %ptr4 = getelementptr inbounds i32, i32* %a, i64 4
  store i32 %1, i32* %ptr4, align 16
  %ptr5 = getelementptr inbounds i32, i32* %a, i64 5
  store i32 %2, i32* %ptr5, align 4
  %ptr6 = getelementptr inbounds i32, i32* %a, i64 6
  store i32 %1, i32* %ptr6, align 8
  %ptr7 = getelementptr inbounds i32, i32* %a, i64 7
  store i32 %2, i32* %ptr7, align 4
  ret void
}
