; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -indvars -S < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

define void @test() personality i32* ()* @snork {
; CHECK-LABEL: @test(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB4:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[INDVARS_IV_NEXT:%.*]] = add i32 [[INDVARS_IV:%.*]], 1
; CHECK-NEXT:    [[TMP0:%.*]] = sub i32 [[TMP1:%.*]], [[SMAX:%.*]]
; CHECK-NEXT:    br i1 true, label [[BB2:%.*]], label [[BB4]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i32 [ [[TMP0]], [[BB1:%.*]] ]
; CHECK-NEXT:    ret void
; CHECK:       bb4:
; CHECK-NEXT:    [[INDVARS_IV]] = phi i32 [ [[INDVARS_IV_NEXT]], [[BB1]] ], [ undef, [[BB:%.*]] ]
; CHECK-NEXT:    [[SMAX]] = call i32 @llvm.smax.i32(i32 [[INDVARS_IV]], i32 36)
; CHECK-NEXT:    [[TMP6:%.*]] = invoke i32 @quux() [ "deopt"(i32 0, i32 0, i32 0, i32 180, i32 0, i32 25, i32 0, i32 7, i8* null, i32 7, i8* null, i32 7, i8* null, i32 3, i32 [[INDVARS_IV]], i32 3, i32 undef, i32 7, i8* null, i32 3, i32 undef, i32 3, i32 undef, i32 3, i32 undef, i32 3, i32 undef, i32 4, double undef, i32 7, i8* null, i32 4, i64 undef, i32 7, i8* null, i32 0, i8 addrspace(1)* undef, i32 3, i32 undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 7, i8* null) ]
; CHECK-NEXT:    to label [[BB7:%.*]] unwind label [[BB15:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[TMP1]] = add i32 [[TMP6]], [[INDVARS_IV]]
; CHECK-NEXT:    br label [[BB9:%.*]]
; CHECK:       bb9:
; CHECK-NEXT:    br i1 true, label [[BB1]], label [[BB9]]
; CHECK:       bb15:
; CHECK-NEXT:    [[TMP16:%.*]] = landingpad { i8*, i32 }
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    ret void
;

bb:
  br label %bb4

bb1:                                              ; preds = %bb9
  %tmp = phi i32 [ %tmp12, %bb9 ]
  br i1 undef, label %bb2, label %bb4

bb2:                                              ; preds = %bb1
  %tmp3 = phi i32 [ %tmp, %bb1 ]
  ret void

bb4:                                              ; preds = %bb1, %bb
  %tmp5 = phi i32 [ %tmp8, %bb1 ], [ undef, %bb ]
  %tmp6 = invoke i32 @quux() #2 [ "deopt"(i32 0, i32 0, i32 0, i32 180, i32 0, i32 25, i32 0, i32 7, i8* null, i32 7, i8* null, i32 7, i8* null, i32 3, i32 %tmp5, i32 3, i32 undef, i32 7, i8* null, i32 3, i32 undef, i32 3, i32 undef, i32 3, i32 undef, i32 3, i32 undef, i32 4, double undef, i32 7, i8* null, i32 4, i64 undef, i32 7, i8* null, i32 0, i8 addrspace(1)* undef, i32 3, i32 undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 0, i8 addrspace(1)* undef, i32 7, i8* null) ]
  to label %bb7 unwind label %bb15

bb7:                                              ; preds = %bb4
  %tmp8 = add nsw i32 %tmp5, 1
  br label %bb9

bb9:                                              ; preds = %bb9, %bb7
  %tmp10 = phi i32 [ %tmp5, %bb7 ], [ %tmp13, %bb9 ]
  %tmp11 = phi i32 [ %tmp6, %bb7 ], [ %tmp12, %bb9 ]
  %tmp12 = add i32 %tmp11, -1
  %tmp13 = add nsw i32 %tmp10, 1
  %tmp14 = icmp sgt i32 %tmp10, 35
  br i1 %tmp14, label %bb1, label %bb9

bb15:                                             ; preds = %bb4
  %tmp16 = landingpad { i8*, i32 }
  cleanup
  ret void
}

declare i32* @snork()

declare i32 @quux()

