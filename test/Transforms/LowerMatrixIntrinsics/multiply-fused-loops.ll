; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -lower-matrix-intrinsics -fuse-matrix-use-loops -fuse-matrix-tile-size=2 -matrix-allow-contract -force-fuse-matrix -instcombine -verify-dom-info %s -S | FileCheck %s

; REQUIRES: aarch64-registered-target

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "aarch64-apple-ios"

define void @multiply_noalias_4x4(<16 x double>* noalias %A, <16 x double>* noalias %B, <16 x double>* noalias %C) {
; CHECK-LABEL: @multiply_noalias_4x4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[COLS_HEADER:%.*]]
; CHECK:       cols.header:
; CHECK-NEXT:    [[COLS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[COLS_STEP:%.*]], [[COLS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[COLS_BODY:%.*]]
; CHECK:       cols.body:
; CHECK-NEXT:    br label [[ROWS_HEADER:%.*]]
; CHECK:       rows.header:
; CHECK-NEXT:    [[ROWS_IV:%.*]] = phi i64 [ 0, [[COLS_BODY]] ], [ [[ROWS_STEP:%.*]], [[ROWS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[ROWS_BODY:%.*]]
; CHECK:       rows.body:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ 0, [[ROWS_BODY]] ], [ [[INNER_STEP:%.*]], [[INNER_LATCH:%.*]] ]
; CHECK-NEXT:    [[RESULT_VEC_0:%.*]] = phi <2 x double> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP7:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    [[RESULT_VEC_1:%.*]] = phi <2 x double> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP9:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    br label [[INNER_BODY:%.*]]
; CHECK:       inner.body:
; CHECK-NEXT:    [[TMP0:%.*]] = shl i64 [[INNER_IV]], 2
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <16 x double>, <16 x double>* [[A:%.*]], i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[VEC_CAST:%.*]] = bitcast double* [[TMP2]] to <2 x double>*
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <2 x double>, <2 x double>* [[VEC_CAST]], align 8
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr double, double* [[TMP2]], i64 4
; CHECK-NEXT:    [[VEC_CAST1:%.*]] = bitcast double* [[VEC_GEP]] to <2 x double>*
; CHECK-NEXT:    [[COL_LOAD2:%.*]] = load <2 x double>, <2 x double>* [[VEC_CAST1]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP3]], [[INNER_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr <16 x double>, <16 x double>* [[B:%.*]], i64 0, i64 [[TMP4]]
; CHECK-NEXT:    [[VEC_CAST4:%.*]] = bitcast double* [[TMP5]] to <2 x double>*
; CHECK-NEXT:    [[COL_LOAD5:%.*]] = load <2 x double>, <2 x double>* [[VEC_CAST4]], align 8
; CHECK-NEXT:    [[VEC_GEP6:%.*]] = getelementptr double, double* [[TMP5]], i64 4
; CHECK-NEXT:    [[VEC_CAST7:%.*]] = bitcast double* [[VEC_GEP6]] to <2 x double>*
; CHECK-NEXT:    [[COL_LOAD8:%.*]] = load <2 x double>, <2 x double>* [[VEC_CAST7]], align 8
; CHECK-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <2 x double> [[COL_LOAD5]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[COL_LOAD]], <2 x double> [[SPLAT_SPLAT]], <2 x double> [[RESULT_VEC_0]])
; CHECK-NEXT:    [[SPLAT_SPLAT12:%.*]] = shufflevector <2 x double> [[COL_LOAD5]], <2 x double> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP7]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[COL_LOAD2]], <2 x double> [[SPLAT_SPLAT12]], <2 x double> [[TMP6]])
; CHECK-NEXT:    [[SPLAT_SPLAT16:%.*]] = shufflevector <2 x double> [[COL_LOAD8]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP8:%.*]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[COL_LOAD]], <2 x double> [[SPLAT_SPLAT16]], <2 x double> [[RESULT_VEC_1]])
; CHECK-NEXT:    [[SPLAT_SPLAT19:%.*]] = shufflevector <2 x double> [[COL_LOAD8]], <2 x double> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP9]] = call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[COL_LOAD2]], <2 x double> [[SPLAT_SPLAT19]], <2 x double> [[TMP8]])
; CHECK-NEXT:    br label [[INNER_LATCH]]
; CHECK:       inner.latch:
; CHECK-NEXT:    [[INNER_STEP]] = add i64 [[INNER_IV]], 2
; CHECK-NEXT:    [[INNER_COND_NOT:%.*]] = icmp eq i64 [[INNER_STEP]], 4
; CHECK-NEXT:    br i1 [[INNER_COND_NOT]], label [[ROWS_LATCH]], label [[INNER_HEADER]], [[LOOP0:!llvm.loop !.*]]
; CHECK:       rows.latch:
; CHECK-NEXT:    [[ROWS_STEP]] = add i64 [[ROWS_IV]], 2
; CHECK-NEXT:    [[ROWS_COND_NOT:%.*]] = icmp eq i64 [[ROWS_STEP]], 4
; CHECK-NEXT:    [[TMP10:%.*]] = shl i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[TMP11:%.*]] = add i64 [[TMP10]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr <16 x double>, <16 x double>* [[C:%.*]], i64 0, i64 [[TMP11]]
; CHECK-NEXT:    [[VEC_CAST21:%.*]] = bitcast double* [[TMP12]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP7]], <2 x double>* [[VEC_CAST21]], align 8
; CHECK-NEXT:    [[VEC_GEP22:%.*]] = getelementptr double, double* [[TMP12]], i64 4
; CHECK-NEXT:    [[VEC_CAST23:%.*]] = bitcast double* [[VEC_GEP22]] to <2 x double>*
; CHECK-NEXT:    store <2 x double> [[TMP9]], <2 x double>* [[VEC_CAST23]], align 8
; CHECK-NEXT:    br i1 [[ROWS_COND_NOT]], label [[COLS_LATCH]], label [[ROWS_HEADER]]
; CHECK:       cols.latch:
; CHECK-NEXT:    [[COLS_STEP]] = add i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[COLS_COND_NOT:%.*]] = icmp eq i64 [[COLS_STEP]], 4
; CHECK-NEXT:    br i1 [[COLS_COND_NOT]], label [[CONTINUE:%.*]], label [[COLS_HEADER]]
; CHECK:       continue:
; CHECK-NEXT:    ret void
;

entry:
  %a = load <16 x double>, <16 x double>* %A, align 8
  %b = load <16 x double>, <16 x double>* %B, align 8

  %c = call <16 x double> @llvm.matrix.multiply.v16f64.v16f64.v16f64(<16 x double> %a, <16 x double> %b, i32 4, i32 4, i32 4)

  store <16 x double> %c, <16 x double>* %C, align 8
  ret void
}


declare <16 x double> @llvm.matrix.multiply.v16f64.v16f64.v16f64(<16 x double>, <16 x double>, i32, i32, i32)

define void @multiply_noalias_2x4(<8 x i64>* noalias %A, <8 x i64>* noalias %B, <4 x i64>* noalias %C) {
; CHECK-LABEL: @multiply_noalias_2x4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[COLS_HEADER:%.*]]
; CHECK:       cols.header:
; CHECK-NEXT:    [[COLS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[COLS_STEP:%.*]], [[COLS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[COLS_BODY:%.*]]
; CHECK:       cols.body:
; CHECK-NEXT:    br label [[ROWS_HEADER:%.*]]
; CHECK:       rows.header:
; CHECK-NEXT:    [[ROWS_IV:%.*]] = phi i64 [ 0, [[COLS_BODY]] ], [ [[ROWS_STEP:%.*]], [[ROWS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[ROWS_BODY:%.*]]
; CHECK:       rows.body:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ 0, [[ROWS_BODY]] ], [ [[INNER_STEP:%.*]], [[INNER_LATCH:%.*]] ]
; CHECK-NEXT:    [[RESULT_VEC_0:%.*]] = phi <2 x i64> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP9:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    [[RESULT_VEC_1:%.*]] = phi <2 x i64> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP13:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    br label [[INNER_BODY:%.*]]
; CHECK:       inner.body:
; CHECK-NEXT:    [[TMP0:%.*]] = shl i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <8 x i64>, <8 x i64>* [[A:%.*]], i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[VEC_CAST:%.*]] = bitcast i64* [[TMP2]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST]], align 8
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr i64, i64* [[TMP2]], i64 2
; CHECK-NEXT:    [[VEC_CAST1:%.*]] = bitcast i64* [[VEC_GEP]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD2:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST1]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP3]], [[INNER_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr <8 x i64>, <8 x i64>* [[B:%.*]], i64 0, i64 [[TMP4]]
; CHECK-NEXT:    [[VEC_CAST4:%.*]] = bitcast i64* [[TMP5]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD5:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST4]], align 8
; CHECK-NEXT:    [[VEC_GEP6:%.*]] = getelementptr i64, i64* [[TMP5]], i64 4
; CHECK-NEXT:    [[VEC_CAST7:%.*]] = bitcast i64* [[VEC_GEP6]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD8:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST7]], align 8
; CHECK-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <2 x i64> [[COL_LOAD5]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = mul <2 x i64> [[COL_LOAD]], [[SPLAT_SPLAT]]
; CHECK-NEXT:    [[TMP7:%.*]] = add <2 x i64> [[RESULT_VEC_0]], [[TMP6]]
; CHECK-NEXT:    [[SPLAT_SPLAT12:%.*]] = shufflevector <2 x i64> [[COL_LOAD5]], <2 x i64> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP8:%.*]] = mul <2 x i64> [[COL_LOAD2]], [[SPLAT_SPLAT12]]
; CHECK-NEXT:    [[TMP9]] = add <2 x i64> [[TMP7]], [[TMP8]]
; CHECK-NEXT:    [[SPLAT_SPLAT16:%.*]] = shufflevector <2 x i64> [[COL_LOAD8]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP10:%.*]] = mul <2 x i64> [[COL_LOAD]], [[SPLAT_SPLAT16]]
; CHECK-NEXT:    [[TMP11:%.*]] = add <2 x i64> [[RESULT_VEC_1]], [[TMP10]]
; CHECK-NEXT:    [[SPLAT_SPLAT19:%.*]] = shufflevector <2 x i64> [[COL_LOAD8]], <2 x i64> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP12:%.*]] = mul <2 x i64> [[COL_LOAD2]], [[SPLAT_SPLAT19]]
; CHECK-NEXT:    [[TMP13]] = add <2 x i64> [[TMP11]], [[TMP12]]
; CHECK-NEXT:    br label [[INNER_LATCH]]
; CHECK:       inner.latch:
; CHECK-NEXT:    [[INNER_STEP]] = add i64 [[INNER_IV]], 2
; CHECK-NEXT:    [[INNER_COND_NOT:%.*]] = icmp eq i64 [[INNER_STEP]], 4
; CHECK-NEXT:    br i1 [[INNER_COND_NOT]], label [[ROWS_LATCH]], label [[INNER_HEADER]], [[LOOP2:!llvm.loop !.*]]
; CHECK:       rows.latch:
; CHECK-NEXT:    [[ROWS_STEP]] = add i64 [[ROWS_IV]], 2
; CHECK-NEXT:    [[ROWS_COND_NOT:%.*]] = icmp eq i64 [[ROWS_IV]], 0
; CHECK-NEXT:    [[TMP14:%.*]] = shl i64 [[COLS_IV]], 1
; CHECK-NEXT:    [[TMP15:%.*]] = add i64 [[TMP14]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr <4 x i64>, <4 x i64>* [[C:%.*]], i64 0, i64 [[TMP15]]
; CHECK-NEXT:    [[VEC_CAST21:%.*]] = bitcast i64* [[TMP16]] to <2 x i64>*
; CHECK-NEXT:    store <2 x i64> [[TMP9]], <2 x i64>* [[VEC_CAST21]], align 8
; CHECK-NEXT:    [[VEC_GEP22:%.*]] = getelementptr i64, i64* [[TMP16]], i64 2
; CHECK-NEXT:    [[VEC_CAST23:%.*]] = bitcast i64* [[VEC_GEP22]] to <2 x i64>*
; CHECK-NEXT:    store <2 x i64> [[TMP13]], <2 x i64>* [[VEC_CAST23]], align 8
; CHECK-NEXT:    br i1 [[ROWS_COND_NOT]], label [[COLS_LATCH]], label [[ROWS_HEADER]]
; CHECK:       cols.latch:
; CHECK-NEXT:    [[COLS_STEP]] = add i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[COLS_COND_NOT:%.*]] = icmp eq i64 [[COLS_IV]], 0
; CHECK-NEXT:    br i1 [[COLS_COND_NOT]], label [[CONTINUE:%.*]], label [[COLS_HEADER]]
; CHECK:       continue:
; CHECK-NEXT:    ret void
;

; In the inner loop, compute
;   Result += Load(A, ROWS_IV, INNER_IV) * Load(B, INNER_IV, COLS_IV)


; Store the current 2x2 tile.

entry:
  %a = load <8 x i64>, <8 x i64>* %A, align 8
  %b = load <8 x i64>, <8 x i64>* %B, align 8

  %c = call <4 x i64> @llvm.matrix.multiply.v4i64.v8i64.v8i64(<8 x i64> %a, <8 x i64> %b, i32 2, i32 4, i32 2)

  store <4 x i64> %c, <4 x i64>* %C, align 8
  ret void
}


declare <4 x i64> @llvm.matrix.multiply.v4i64.v8i64.v8i64(<8 x i64>, <8 x i64>, i32, i32, i32)

define void @multiply_noalias_4x2_2x8(<8 x i64>* noalias %A, <16 x i64>* noalias %B, <32 x i64>* noalias %C) {
; CHECK-LABEL: @multiply_noalias_4x2_2x8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[COLS_HEADER:%.*]]
; CHECK:       cols.header:
; CHECK-NEXT:    [[COLS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[COLS_STEP:%.*]], [[COLS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[COLS_BODY:%.*]]
; CHECK:       cols.body:
; CHECK-NEXT:    br label [[ROWS_HEADER:%.*]]
; CHECK:       rows.header:
; CHECK-NEXT:    [[ROWS_IV:%.*]] = phi i64 [ 0, [[COLS_BODY]] ], [ [[ROWS_STEP:%.*]], [[ROWS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[ROWS_BODY:%.*]]
; CHECK:       rows.body:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ 0, [[ROWS_BODY]] ], [ [[INNER_STEP:%.*]], [[INNER_LATCH:%.*]] ]
; CHECK-NEXT:    [[RESULT_VEC_0:%.*]] = phi <2 x i64> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP9:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    [[RESULT_VEC_1:%.*]] = phi <2 x i64> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP13:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    br label [[INNER_BODY:%.*]]
; CHECK:       inner.body:
; CHECK-NEXT:    [[TMP0:%.*]] = shl i64 [[INNER_IV]], 2
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[TMP0]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr <8 x i64>, <8 x i64>* [[A:%.*]], i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[VEC_CAST:%.*]] = bitcast i64* [[TMP2]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST]], align 8
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr i64, i64* [[TMP2]], i64 4
; CHECK-NEXT:    [[VEC_CAST1:%.*]] = bitcast i64* [[VEC_GEP]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD2:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST1]], align 8
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[COLS_IV]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[TMP3]], [[INNER_IV]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr <16 x i64>, <16 x i64>* [[B:%.*]], i64 0, i64 [[TMP4]]
; CHECK-NEXT:    [[VEC_CAST4:%.*]] = bitcast i64* [[TMP5]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD5:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST4]], align 8
; CHECK-NEXT:    [[VEC_GEP6:%.*]] = getelementptr i64, i64* [[TMP5]], i64 2
; CHECK-NEXT:    [[VEC_CAST7:%.*]] = bitcast i64* [[VEC_GEP6]] to <2 x i64>*
; CHECK-NEXT:    [[COL_LOAD8:%.*]] = load <2 x i64>, <2 x i64>* [[VEC_CAST7]], align 8
; CHECK-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <2 x i64> [[COL_LOAD5]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP6:%.*]] = mul <2 x i64> [[COL_LOAD]], [[SPLAT_SPLAT]]
; CHECK-NEXT:    [[TMP7:%.*]] = add <2 x i64> [[RESULT_VEC_0]], [[TMP6]]
; CHECK-NEXT:    [[SPLAT_SPLAT12:%.*]] = shufflevector <2 x i64> [[COL_LOAD5]], <2 x i64> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP8:%.*]] = mul <2 x i64> [[COL_LOAD2]], [[SPLAT_SPLAT12]]
; CHECK-NEXT:    [[TMP9]] = add <2 x i64> [[TMP7]], [[TMP8]]
; CHECK-NEXT:    [[SPLAT_SPLAT16:%.*]] = shufflevector <2 x i64> [[COL_LOAD8]], <2 x i64> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP10:%.*]] = mul <2 x i64> [[COL_LOAD]], [[SPLAT_SPLAT16]]
; CHECK-NEXT:    [[TMP11:%.*]] = add <2 x i64> [[RESULT_VEC_1]], [[TMP10]]
; CHECK-NEXT:    [[SPLAT_SPLAT19:%.*]] = shufflevector <2 x i64> [[COL_LOAD8]], <2 x i64> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP12:%.*]] = mul <2 x i64> [[COL_LOAD2]], [[SPLAT_SPLAT19]]
; CHECK-NEXT:    [[TMP13]] = add <2 x i64> [[TMP11]], [[TMP12]]
; CHECK-NEXT:    br label [[INNER_LATCH]]
; CHECK:       inner.latch:
; CHECK-NEXT:    [[INNER_STEP]] = add i64 [[INNER_IV]], 2
; CHECK-NEXT:    [[INNER_COND_NOT:%.*]] = icmp eq i64 [[INNER_IV]], 0
; CHECK-NEXT:    br i1 [[INNER_COND_NOT]], label [[ROWS_LATCH]], label [[INNER_HEADER]], [[LOOP3:!llvm.loop !.*]]
; CHECK:       rows.latch:
; CHECK-NEXT:    [[ROWS_STEP]] = add i64 [[ROWS_IV]], 2
; CHECK-NEXT:    [[ROWS_COND_NOT:%.*]] = icmp eq i64 [[ROWS_STEP]], 4
; CHECK-NEXT:    [[TMP14:%.*]] = shl i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[TMP15:%.*]] = add i64 [[TMP14]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr <32 x i64>, <32 x i64>* [[C:%.*]], i64 0, i64 [[TMP15]]
; CHECK-NEXT:    [[VEC_CAST21:%.*]] = bitcast i64* [[TMP16]] to <2 x i64>*
; CHECK-NEXT:    store <2 x i64> [[TMP9]], <2 x i64>* [[VEC_CAST21]], align 8
; CHECK-NEXT:    [[VEC_GEP22:%.*]] = getelementptr i64, i64* [[TMP16]], i64 4
; CHECK-NEXT:    [[VEC_CAST23:%.*]] = bitcast i64* [[VEC_GEP22]] to <2 x i64>*
; CHECK-NEXT:    store <2 x i64> [[TMP13]], <2 x i64>* [[VEC_CAST23]], align 8
; CHECK-NEXT:    br i1 [[ROWS_COND_NOT]], label [[COLS_LATCH]], label [[ROWS_HEADER]]
; CHECK:       cols.latch:
; CHECK-NEXT:    [[COLS_STEP]] = add i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[COLS_COND_NOT:%.*]] = icmp eq i64 [[COLS_STEP]], 8
; CHECK-NEXT:    br i1 [[COLS_COND_NOT]], label [[CONTINUE:%.*]], label [[COLS_HEADER]]
; CHECK:       continue:
; CHECK-NEXT:    ret void
;

; In the inner loop, compute
;   Result += Load(A, ROWS_IV, INNER_IV) * Load(B, INNER_IV, COLS_IV)


; Store the current 2x2 tile.

entry:
  %a = load <8 x i64>, <8 x i64>* %A, align 8
  %b = load <16 x i64>, <16 x i64>* %B, align 8

  %c = call <32 x i64> @llvm.matrix.multiply.v32i64.v8i64.v16i64(<8 x i64> %a, <16 x i64> %b, i32 4, i32 2, i32 8)

  store <32 x i64> %c, <32 x i64>* %C, align 8
  ret void
}

declare <32 x i64> @llvm.matrix.multiply.v32i64.v8i64.v16i64(<8 x i64>, <16 x i64>, i32, i32, i32)


; Check the runtime aliasing checks.
define void @multiply_alias_2x2(<4 x float>* %A, <4 x float>* %B, <4 x float>* %C) {
; CHECK-LABEL: @multiply_alias_2x2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[STORE_BEGIN:%.*]] = ptrtoint <4 x float>* [[C:%.*]] to i64
; CHECK-NEXT:    [[STORE_END:%.*]] = add nuw nsw i64 [[STORE_BEGIN]], 16
; CHECK-NEXT:    [[LOAD_BEGIN:%.*]] = ptrtoint <4 x float>* [[A:%.*]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ugt i64 [[STORE_END]], [[LOAD_BEGIN]]
; CHECK-NEXT:    br i1 [[TMP0]], label [[ALIAS_CONT:%.*]], label [[NO_ALIAS:%.*]]
; CHECK:       alias_cont:
; CHECK-NEXT:    [[LOAD_END:%.*]] = add nuw nsw i64 [[LOAD_BEGIN]], 16
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i64 [[LOAD_END]], [[STORE_BEGIN]]
; CHECK-NEXT:    br i1 [[TMP1]], label [[COPY:%.*]], label [[NO_ALIAS]]
; CHECK:       copy:
; CHECK-NEXT:    [[TMP2:%.*]] = alloca <4 x float>, align 16
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <4 x float>* [[TMP2]] to i8*
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast <4 x float>* [[A]] to i8*
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 16 dereferenceable(16) [[TMP3]], i8* noundef nonnull align 8 dereferenceable(16) [[TMP4]], i64 16, i1 false)
; CHECK-NEXT:    br label [[NO_ALIAS]]
; CHECK:       no_alias:
; CHECK-NEXT:    [[TMP5:%.*]] = phi <4 x float>* [ [[A]], [[ENTRY:%.*]] ], [ [[A]], [[ALIAS_CONT]] ], [ [[TMP2]], [[COPY]] ]
; CHECK-NEXT:    [[STORE_BEGIN4:%.*]] = ptrtoint <4 x float>* [[C]] to i64
; CHECK-NEXT:    [[STORE_END5:%.*]] = add nuw nsw i64 [[STORE_BEGIN4]], 16
; CHECK-NEXT:    [[LOAD_BEGIN6:%.*]] = ptrtoint <4 x float>* [[B:%.*]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ugt i64 [[STORE_END5]], [[LOAD_BEGIN6]]
; CHECK-NEXT:    br i1 [[TMP6]], label [[ALIAS_CONT1:%.*]], label [[NO_ALIAS3:%.*]]
; CHECK:       alias_cont1:
; CHECK-NEXT:    [[LOAD_END7:%.*]] = add nuw nsw i64 [[LOAD_BEGIN6]], 16
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ugt i64 [[LOAD_END7]], [[STORE_BEGIN4]]
; CHECK-NEXT:    br i1 [[TMP7]], label [[COPY2:%.*]], label [[NO_ALIAS3]]
; CHECK:       copy2:
; CHECK-NEXT:    [[TMP8:%.*]] = alloca <4 x float>, align 16
; CHECK-NEXT:    [[TMP9:%.*]] = bitcast <4 x float>* [[TMP8]] to i8*
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast <4 x float>* [[B]] to i8*
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 16 dereferenceable(16) [[TMP9]], i8* noundef nonnull align 8 dereferenceable(16) [[TMP10]], i64 16, i1 false)
; CHECK-NEXT:    br label [[NO_ALIAS3]]
; CHECK:       no_alias3:
; CHECK-NEXT:    [[TMP11:%.*]] = phi <4 x float>* [ [[B]], [[NO_ALIAS]] ], [ [[B]], [[ALIAS_CONT1]] ], [ [[TMP8]], [[COPY2]] ]
; CHECK-NEXT:    br label [[COLS_HEADER:%.*]]
; CHECK:       cols.header:
; CHECK-NEXT:    [[COLS_IV:%.*]] = phi i64 [ 0, [[NO_ALIAS3]] ], [ [[COLS_STEP:%.*]], [[COLS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[COLS_BODY:%.*]]
; CHECK:       cols.body:
; CHECK-NEXT:    br label [[ROWS_HEADER:%.*]]
; CHECK:       rows.header:
; CHECK-NEXT:    [[ROWS_IV:%.*]] = phi i64 [ 0, [[COLS_BODY]] ], [ [[ROWS_STEP:%.*]], [[ROWS_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[ROWS_BODY:%.*]]
; CHECK:       rows.body:
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[INNER_IV:%.*]] = phi i64 [ 0, [[ROWS_BODY]] ], [ [[INNER_STEP:%.*]], [[INNER_LATCH:%.*]] ]
; CHECK-NEXT:    [[RESULT_VEC_0:%.*]] = phi <2 x float> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP19:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    [[RESULT_VEC_1:%.*]] = phi <2 x float> [ zeroinitializer, [[ROWS_BODY]] ], [ [[TMP21:%.*]], [[INNER_LATCH]] ]
; CHECK-NEXT:    br label [[INNER_BODY:%.*]]
; CHECK:       inner.body:
; CHECK-NEXT:    [[TMP12:%.*]] = shl i64 [[INNER_IV]], 1
; CHECK-NEXT:    [[TMP13:%.*]] = add i64 [[TMP12]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr <4 x float>, <4 x float>* [[TMP5]], i64 0, i64 [[TMP13]]
; CHECK-NEXT:    [[VEC_CAST:%.*]] = bitcast float* [[TMP14]] to <2 x float>*
; CHECK-NEXT:    [[COL_LOAD:%.*]] = load <2 x float>, <2 x float>* [[VEC_CAST]], align 4
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr float, float* [[TMP14]], i64 2
; CHECK-NEXT:    [[VEC_CAST8:%.*]] = bitcast float* [[VEC_GEP]] to <2 x float>*
; CHECK-NEXT:    [[COL_LOAD9:%.*]] = load <2 x float>, <2 x float>* [[VEC_CAST8]], align 4
; CHECK-NEXT:    [[TMP15:%.*]] = shl i64 [[COLS_IV]], 1
; CHECK-NEXT:    [[TMP16:%.*]] = add i64 [[TMP15]], [[INNER_IV]]
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr <4 x float>, <4 x float>* [[TMP11]], i64 0, i64 [[TMP16]]
; CHECK-NEXT:    [[VEC_CAST11:%.*]] = bitcast float* [[TMP17]] to <2 x float>*
; CHECK-NEXT:    [[COL_LOAD12:%.*]] = load <2 x float>, <2 x float>* [[VEC_CAST11]], align 4
; CHECK-NEXT:    [[VEC_GEP13:%.*]] = getelementptr float, float* [[TMP17]], i64 2
; CHECK-NEXT:    [[VEC_CAST14:%.*]] = bitcast float* [[VEC_GEP13]] to <2 x float>*
; CHECK-NEXT:    [[COL_LOAD15:%.*]] = load <2 x float>, <2 x float>* [[VEC_CAST14]], align 4
; CHECK-NEXT:    [[SPLAT_SPLAT:%.*]] = shufflevector <2 x float> [[COL_LOAD12]], <2 x float> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP18:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[COL_LOAD]], <2 x float> [[SPLAT_SPLAT]], <2 x float> [[RESULT_VEC_0]])
; CHECK-NEXT:    [[SPLAT_SPLAT19:%.*]] = shufflevector <2 x float> [[COL_LOAD12]], <2 x float> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP19]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[COL_LOAD9]], <2 x float> [[SPLAT_SPLAT19]], <2 x float> [[TMP18]])
; CHECK-NEXT:    [[SPLAT_SPLAT23:%.*]] = shufflevector <2 x float> [[COL_LOAD15]], <2 x float> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP20:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[COL_LOAD]], <2 x float> [[SPLAT_SPLAT23]], <2 x float> [[RESULT_VEC_1]])
; CHECK-NEXT:    [[SPLAT_SPLAT26:%.*]] = shufflevector <2 x float> [[COL_LOAD15]], <2 x float> undef, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP21]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[COL_LOAD9]], <2 x float> [[SPLAT_SPLAT26]], <2 x float> [[TMP20]])
; CHECK-NEXT:    br label [[INNER_LATCH]]
; CHECK:       inner.latch:
; CHECK-NEXT:    [[INNER_STEP]] = add i64 [[INNER_IV]], 2
; CHECK-NEXT:    [[INNER_COND_NOT:%.*]] = icmp eq i64 [[INNER_IV]], 0
; CHECK-NEXT:    br i1 [[INNER_COND_NOT]], label [[ROWS_LATCH]], label [[INNER_HEADER]], [[LOOP5:!llvm.loop !.*]]
; CHECK:       rows.latch:
; CHECK-NEXT:    [[ROWS_STEP]] = add i64 [[ROWS_IV]], 2
; CHECK-NEXT:    [[ROWS_COND_NOT:%.*]] = icmp eq i64 [[ROWS_IV]], 0
; CHECK-NEXT:    [[TMP22:%.*]] = shl i64 [[COLS_IV]], 1
; CHECK-NEXT:    [[TMP23:%.*]] = add i64 [[TMP22]], [[ROWS_IV]]
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr <4 x float>, <4 x float>* [[C]], i64 0, i64 [[TMP23]]
; CHECK-NEXT:    [[VEC_CAST28:%.*]] = bitcast float* [[TMP24]] to <2 x float>*
; CHECK-NEXT:    store <2 x float> [[TMP19]], <2 x float>* [[VEC_CAST28]], align 8
; CHECK-NEXT:    [[VEC_GEP29:%.*]] = getelementptr float, float* [[TMP24]], i64 2
; CHECK-NEXT:    [[VEC_CAST30:%.*]] = bitcast float* [[VEC_GEP29]] to <2 x float>*
; CHECK-NEXT:    store <2 x float> [[TMP21]], <2 x float>* [[VEC_CAST30]], align 8
; CHECK-NEXT:    br i1 [[ROWS_COND_NOT]], label [[COLS_LATCH]], label [[ROWS_HEADER]]
; CHECK:       cols.latch:
; CHECK-NEXT:    [[COLS_STEP]] = add i64 [[COLS_IV]], 2
; CHECK-NEXT:    [[COLS_COND_NOT:%.*]] = icmp eq i64 [[COLS_IV]], 0
; CHECK-NEXT:    br i1 [[COLS_COND_NOT]], label [[CONTINUE:%.*]], label [[COLS_HEADER]]
; CHECK:       continue:
; CHECK-NEXT:    ret void
;

; First, check for aliasing at runtime, create non-aliasing copies if required.
entry:
  %a = load <4 x float>, <4 x float>* %A, align 8
  %b = load <4 x float>, <4 x float>* %B, align 8

  %c = call <4 x float> @llvm.matrix.multiply.v4f32.v4f32.v4f32(<4 x float> %a, <4 x float> %b, i32 2, i32 2, i32 2)

  store <4 x float> %c, <4 x float>* %C, align 8
  ret void
}

declare <4 x float> @llvm.matrix.multiply.v4f32.v4f32.v4f32(<4 x float>, <4 x float>, i32, i32, i32)

; CHECK:      !0 = distinct !{!0, !1}
; CHECK-NEXT: !1 = !{!"llvm.loop.unroll.count", i32 2}
; CHECK-NEXT: !2 = distinct !{!2, !1}
; CHECK-NEXT: !3 = distinct !{!3, !4}
; CHECK-NEXT: !4 = !{!"llvm.loop.unroll.count", i32 1}
; CHECK-NEXT: !5 = distinct !{!5, !4}
