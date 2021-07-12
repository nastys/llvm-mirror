; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefixes=SSE
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=slm -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefixes=SLM
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefixes=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefixes=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=knl -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefixes=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=skx -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefixes=AVX

define <8 x float> @ceil_floor(<8 x float> %a) {
; SSE-LABEL: @ceil_floor(
; SSE-NEXT:    [[A0:%.*]] = extractelement <8 x float> [[A:%.*]], i32 0
; SSE-NEXT:    [[A3:%.*]] = extractelement <8 x float> [[A]], i32 3
; SSE-NEXT:    [[AB0:%.*]] = call float @llvm.ceil.f32(float [[A0]])
; SSE-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 1, i32 2>
; SSE-NEXT:    [[TMP2:%.*]] = call <2 x float> @llvm.floor.v2f32(<2 x float> [[TMP1]])
; SSE-NEXT:    [[AB3:%.*]] = call float @llvm.ceil.f32(float [[A3]])
; SSE-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 4, i32 5>
; SSE-NEXT:    [[TMP4:%.*]] = call <2 x float> @llvm.ceil.v2f32(<2 x float> [[TMP3]])
; SSE-NEXT:    [[TMP5:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 6, i32 7>
; SSE-NEXT:    [[TMP6:%.*]] = call <2 x float> @llvm.floor.v2f32(<2 x float> [[TMP5]])
; SSE-NEXT:    [[R0:%.*]] = insertelement <8 x float> poison, float [[AB0]], i32 0
; SSE-NEXT:    [[TMP7:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:    [[R23:%.*]] = shufflevector <8 x float> [[R0]], <8 x float> [[TMP7]], <8 x i32> <i32 0, i32 8, i32 9, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:    [[R3:%.*]] = insertelement <8 x float> [[R23]], float [[AB3]], i32 3
; SSE-NEXT:    [[TMP8:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:    [[R52:%.*]] = shufflevector <8 x float> [[R3]], <8 x float> [[TMP8]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 undef, i32 undef>
; SSE-NEXT:    [[TMP9:%.*]] = shufflevector <2 x float> [[TMP6]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:    [[R71:%.*]] = shufflevector <8 x float> [[R52]], <8 x float> [[TMP9]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; SSE-NEXT:    ret <8 x float> [[R71]]
;
; SLM-LABEL: @ceil_floor(
; SLM-NEXT:    [[A0:%.*]] = extractelement <8 x float> [[A:%.*]], i32 0
; SLM-NEXT:    [[A3:%.*]] = extractelement <8 x float> [[A]], i32 3
; SLM-NEXT:    [[AB0:%.*]] = call float @llvm.ceil.f32(float [[A0]])
; SLM-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 1, i32 2>
; SLM-NEXT:    [[TMP2:%.*]] = call <2 x float> @llvm.floor.v2f32(<2 x float> [[TMP1]])
; SLM-NEXT:    [[AB3:%.*]] = call float @llvm.ceil.f32(float [[A3]])
; SLM-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 4, i32 5>
; SLM-NEXT:    [[TMP4:%.*]] = call <2 x float> @llvm.ceil.v2f32(<2 x float> [[TMP3]])
; SLM-NEXT:    [[TMP5:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 6, i32 7>
; SLM-NEXT:    [[TMP6:%.*]] = call <2 x float> @llvm.floor.v2f32(<2 x float> [[TMP5]])
; SLM-NEXT:    [[R0:%.*]] = insertelement <8 x float> poison, float [[AB0]], i32 0
; SLM-NEXT:    [[TMP7:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SLM-NEXT:    [[R23:%.*]] = shufflevector <8 x float> [[R0]], <8 x float> [[TMP7]], <8 x i32> <i32 0, i32 8, i32 9, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SLM-NEXT:    [[R3:%.*]] = insertelement <8 x float> [[R23]], float [[AB3]], i32 3
; SLM-NEXT:    [[TMP8:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SLM-NEXT:    [[R52:%.*]] = shufflevector <8 x float> [[R3]], <8 x float> [[TMP8]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 undef, i32 undef>
; SLM-NEXT:    [[TMP9:%.*]] = shufflevector <2 x float> [[TMP6]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SLM-NEXT:    [[R71:%.*]] = shufflevector <8 x float> [[R52]], <8 x float> [[TMP9]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; SLM-NEXT:    ret <8 x float> [[R71]]
;
; AVX-LABEL: @ceil_floor(
; AVX-NEXT:    [[A0:%.*]] = extractelement <8 x float> [[A:%.*]], i32 0
; AVX-NEXT:    [[A3:%.*]] = extractelement <8 x float> [[A]], i32 3
; AVX-NEXT:    [[AB0:%.*]] = call float @llvm.ceil.f32(float [[A0]])
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 1, i32 2>
; AVX-NEXT:    [[TMP2:%.*]] = call <2 x float> @llvm.floor.v2f32(<2 x float> [[TMP1]])
; AVX-NEXT:    [[AB3:%.*]] = call float @llvm.ceil.f32(float [[A3]])
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 4, i32 5>
; AVX-NEXT:    [[TMP4:%.*]] = call <2 x float> @llvm.ceil.v2f32(<2 x float> [[TMP3]])
; AVX-NEXT:    [[TMP5:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <2 x i32> <i32 6, i32 7>
; AVX-NEXT:    [[TMP6:%.*]] = call <2 x float> @llvm.floor.v2f32(<2 x float> [[TMP5]])
; AVX-NEXT:    [[R0:%.*]] = insertelement <8 x float> poison, float [[AB0]], i32 0
; AVX-NEXT:    [[TMP7:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[R23:%.*]] = shufflevector <8 x float> [[R0]], <8 x float> [[TMP7]], <8 x i32> <i32 0, i32 8, i32 9, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[R3:%.*]] = insertelement <8 x float> [[R23]], float [[AB3]], i32 3
; AVX-NEXT:    [[TMP8:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[R52:%.*]] = shufflevector <8 x float> [[R3]], <8 x float> [[TMP8]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 undef, i32 undef>
; AVX-NEXT:    [[TMP9:%.*]] = shufflevector <2 x float> [[TMP6]], <2 x float> poison, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[R71:%.*]] = shufflevector <8 x float> [[R52]], <8 x float> [[TMP9]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; AVX-NEXT:    ret <8 x float> [[R71]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %ab0 = call float @llvm.ceil.f32(float %a0)
  %ab1 = call float @llvm.floor.f32(float %a1)
  %ab2 = call float @llvm.floor.f32(float %a2)
  %ab3 = call float @llvm.ceil.f32(float %a3)
  %ab4 = call float @llvm.ceil.f32(float %a4)
  %ab5 = call float @llvm.ceil.f32(float %a5)
  %ab6 = call float @llvm.floor.f32(float %a6)
  %ab7 = call float @llvm.floor.f32(float %a7)
  %r0 = insertelement <8 x float> poison, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

declare float @llvm.ceil.f32(float)
declare float @llvm.floor.f32(float)
