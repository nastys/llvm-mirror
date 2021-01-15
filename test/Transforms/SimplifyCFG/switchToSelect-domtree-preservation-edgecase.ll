; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=0 -sink-common-insts=1 < %s | FileCheck %s

declare void @widget(i8)

define void @baz(i8 %arg, i8 %arg10, i1 %arg11) {
; CHECK-LABEL: @baz(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB12:%.*]]
; CHECK:       bb12:
; CHECK-NEXT:    [[TMP:%.*]] = icmp eq i8 [[ARG:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP]], label [[BB17:%.*]], label [[BB13:%.*]]
; CHECK:       bb13:
; CHECK-NEXT:    tail call void @widget(i8 11)
; CHECK-NEXT:    [[SWITCH_SELECTCMP:%.*]] = icmp eq i8 [[ARG10:%.*]], 73
; CHECK-NEXT:    [[SWITCH_SELECT:%.*]] = select i1 [[SWITCH_SELECTCMP]], i8 44, i8 22
; CHECK-NEXT:    [[SWITCH_SELECTCMP1:%.*]] = icmp eq i8 [[ARG10]], 68
; CHECK-NEXT:    [[SWITCH_SELECT2:%.*]] = select i1 [[SWITCH_SELECTCMP1]], i8 33, i8 [[SWITCH_SELECT]]
; CHECK-NEXT:    tail call void @widget(i8 [[SWITCH_SELECT2]])
; CHECK-NEXT:    br label [[BB17]]
; CHECK:       bb17:
; CHECK-NEXT:    br i1 [[ARG11:%.*]], label [[BB12]], label [[BB18:%.*]]
; CHECK:       bb18:
; CHECK-NEXT:    ret void
;
bb:
  br label %bb12

bb12:                                             ; preds = %bb17, %bb
  %tmp = icmp eq i8 %arg, 0
  br i1 %tmp, label %bb17, label %bb13

bb13:                                             ; preds = %bb12
  tail call void @widget(i8 11)
  switch i8 %arg10, label %bb14 [
  i8 68, label %bb15
  i8 73, label %bb16
  ]

bb14:                                             ; preds = %bb13
  tail call void @widget(i8 22)
  br label %bb17

bb15:                                             ; preds = %bb13
  tail call void @widget(i8 33)
  br label %bb17

bb16:                                             ; preds = %bb13
  tail call void @widget(i8 44)
  br label %bb17

bb17:                                             ; preds = %bb16, %bb15, %bb14, %bb12
  br i1 %arg11, label %bb12, label %bb18

bb18:                                             ; preds = %bb17
  ret void
}
