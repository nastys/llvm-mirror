; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s 2>%t | FileCheck %s
; RUN: FileCheck --check-prefix=WARN --allow-empty %s <%t

; If this check fails please read test/CodeGen/AArch64/README for instructions on how to resolve it.
; WARN-NOT: warning

; LEGAL ADDS

define <vscale x 16 x i1> @add_nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: add_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.b
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = add <vscale x 16 x i1> %a, %b
  ret <vscale x 16 x i1> %res;
}

define <vscale x 8 x i1> @add_nxv8i1(<vscale x 8 x i1> %a, <vscale x 8 x i1> %b) {
; CHECK-LABEL: add_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.h
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = add <vscale x 8 x i1> %a, %b
  ret <vscale x 8 x i1> %res;
}

define <vscale x 4 x i1> @add_nxv4i1(<vscale x 4 x i1> %a, <vscale x 4 x i1> %b) {
; CHECK-LABEL: add_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.s
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = add <vscale x 4 x i1> %a, %b
  ret <vscale x 4 x i1> %res;
}

define <vscale x 2 x i1> @add_nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %b) {
; CHECK-LABEL: add_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.d
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = add <vscale x 2 x i1> %a, %b
  ret <vscale x 2 x i1> %res;
}


; ILLEGAL ADDS

define aarch64_sve_vector_pcs <vscale x 64 x i1> @add_nxv64i1(<vscale x 64 x i1> %a, <vscale x 64 x i1> %b) {
; CHECK-LABEL: add_nxv64i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #3, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 8 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ldr p4, [x3]
; CHECK-NEXT:    ldr p5, [x0]
; CHECK-NEXT:    ldr p6, [x1]
; CHECK-NEXT:    ldr p7, [x2]
; CHECK-NEXT:    ptrue p8.b
; CHECK-NEXT:    eor p0.b, p8/z, p0.b, p5.b
; CHECK-NEXT:    eor p1.b, p8/z, p1.b, p6.b
; CHECK-NEXT:    eor p2.b, p8/z, p2.b, p7.b
; CHECK-NEXT:    eor p3.b, p8/z, p3.b, p4.b
; CHECK-NEXT:    ldr p8, [sp, #3, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = add <vscale x 64 x i1> %a, %b
  ret <vscale x 64 x i1> %res;
}


; LEGAL SUBS

define <vscale x 16 x i1> @sub_xv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b) {
; CHECK-LABEL: sub_xv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.b
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = sub <vscale x 16 x i1> %a, %b
  ret <vscale x 16 x i1> %res;
}

define <vscale x 8 x i1> @sub_xv8i1(<vscale x 8 x i1> %a, <vscale x 8 x i1> %b) {
; CHECK-LABEL: sub_xv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.h
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = sub <vscale x 8 x i1> %a, %b
  ret <vscale x 8 x i1> %res;
}

define <vscale x 4 x i1> @sub_xv4i1(<vscale x 4 x i1> %a, <vscale x 4 x i1> %b) {
; CHECK-LABEL: sub_xv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.s
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = sub <vscale x 4 x i1> %a, %b
  ret <vscale x 4 x i1> %res;
}

define <vscale x 2 x i1> @sub_xv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %b) {
; CHECK-LABEL: sub_xv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p2.d
; CHECK-NEXT:    eor p0.b, p2/z, p0.b, p1.b
; CHECK-NEXT:    ret
  %res = sub <vscale x 2 x i1> %a, %b
  ret <vscale x 2 x i1> %res;
}


; ILLEGAL SUBGS


define aarch64_sve_vector_pcs <vscale x 64 x i1> @sub_nxv64i1(<vscale x 64 x i1> %a, <vscale x 64 x i1> %b) {
; CHECK-LABEL: sub_nxv64i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    str p8, [sp, #3, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 8 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ldr p4, [x3]
; CHECK-NEXT:    ldr p5, [x0]
; CHECK-NEXT:    ldr p6, [x1]
; CHECK-NEXT:    ldr p7, [x2]
; CHECK-NEXT:    ptrue p8.b
; CHECK-NEXT:    eor p0.b, p8/z, p0.b, p5.b
; CHECK-NEXT:    eor p1.b, p8/z, p1.b, p6.b
; CHECK-NEXT:    eor p2.b, p8/z, p2.b, p7.b
; CHECK-NEXT:    eor p3.b, p8/z, p3.b, p4.b
; CHECK-NEXT:    ldr p8, [sp, #3, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %res = sub <vscale x 64 x i1> %a, %b
  ret <vscale x 64 x i1> %res;
}
