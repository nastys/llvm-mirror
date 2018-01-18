; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

define i32 @square(i32 %a) nounwind {
; RV32I-LABEL: square:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    lui a1, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a1, %lo(__mulsi3)
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:    jalr a2
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = mul i32 %a, %a
  ret i32 %1
}

define i32 @mul(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: mul:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    lui a2, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a2, %lo(__mulsi3)
; RV32I-NEXT:    jalr a2
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @mul_constant(i32 %a) nounwind {
; RV32I-LABEL: mul_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    lui a1, %hi(__mulsi3)
; RV32I-NEXT:    addi a2, a1, %lo(__mulsi3)
; RV32I-NEXT:    addi a1, zero, 5
; RV32I-NEXT:    jalr a2
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = mul i32 %a, 5
  ret i32 %1
}

define i32 @mul_pow2(i32 %a) nounwind {
; RV32I-LABEL: mul_pow2:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 3
; RV32I-NEXT:    ret
  %1 = mul i32 %a, 8
  ret i32 %1
}

define i64 @mul64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: mul64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    lui a4, %hi(__muldi3)
; RV32I-NEXT:    addi a4, a4, %lo(__muldi3)
; RV32I-NEXT:    jalr a4
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = mul i64 %a, %b
  ret i64 %1
}

define i64 @mul64_constant(i64 %a) nounwind {
; RV32I-LABEL: mul64_constant:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp)
; RV32I-NEXT:    lui a2, %hi(__muldi3)
; RV32I-NEXT:    addi a4, a2, %lo(__muldi3)
; RV32I-NEXT:    addi a2, zero, 5
; RV32I-NEXT:    mv a3, zero
; RV32I-NEXT:    jalr a4
; RV32I-NEXT:    lw ra, 12(sp)
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
  %1 = mul i64 %a, 5
  ret i64 %1
}
