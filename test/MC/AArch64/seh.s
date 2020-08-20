// This test checks that the SEH directives don't cause the assembler to fail.
// Checking that llvm-readobj doesn't bail out on the unwind data, but not
// really checking the contents yet.

// RUN: llvm-mc -triple aarch64-pc-win32 -filetype=obj %s | llvm-readobj -S -r -u - | FileCheck %s

// CHECK:      Sections [
// CHECK:        Section {
// CHECK:          Name: .text
// CHECK:          RelocationCount: 0
// CHECK:          Characteristics [
// CHECK-NEXT:       ALIGN_4BYTES
// CHECK-NEXT:       CNT_CODE
// CHECK-NEXT:       MEM_EXECUTE
// CHECK-NEXT:       MEM_READ
// CHECK-NEXT:     ]
// CHECK-NEXT:   }
// CHECK:        Section {
// CHECK:          Name: .xdata
// CHECK:          RawDataSize: 20
// CHECK:          RelocationCount: 1
// CHECK:          Characteristics [
// CHECK-NEXT:       ALIGN_4BYTES
// CHECK-NEXT:       CNT_INITIALIZED_DATA
// CHECK-NEXT:       MEM_READ
// CHECK-NEXT:     ]
// CHECK-NEXT:   }
// CHECK:        Section {
// CHECK:          Name: .pdata
// CHECK:          RelocationCount: 2
// CHECK:          Characteristics [
// CHECK-NEXT:       ALIGN_4BYTES
// CHECK-NEXT:       CNT_INITIALIZED_DATA
// CHECK-NEXT:       MEM_READ
// CHECK-NEXT:     ]
// CHECK-NEXT:   }
// CHECK-NEXT: ]

// CHECK-NEXT: Relocations [
// CHECK-NEXT:   Section (4) .xdata {
// CHECK-NEXT:     0x8 IMAGE_REL_ARM64_ADDR32NB __C_specific_handler
// CHECK-NEXT:   }
// CHECK-NEXT:   Section (5) .pdata {
// CHECK-NEXT:     0x0 IMAGE_REL_ARM64_ADDR32NB func
// CHECK-NEXT:     0x4 IMAGE_REL_ARM64_ADDR32NB .xdata
// CHECK-NEXT:   }
// CHECK-NEXT: ]

// CHECK-NEXT: UnwindInformation [
// CHECK-NEXT:   RuntimeFunction {
// CHECK-NEXT:     Function: func
// CHECK-NEXT:     ExceptionRecord: .xdata
// CHECK-NEXT:     ExceptionData {
// CHECK-NEXT:       FunctionLength: 8

    .text
    .globl func
    .def func
    .scl 2
    .type 32
    .endef
    .seh_proc func
func:
    sub sp, sp, #24
    .seh_stackalloc 24
    mov x29, sp
    .seh_endprologue
    .seh_handler __C_specific_handler, @except
    .seh_handlerdata
    .long 0
    .text
    add sp, sp, #24
    ret
    .seh_endproc

    // Function with no .seh directives; no pdata/xdata entries are
    // generated.
    .globl smallFunc
    .def smallFunc
    .scl 2
    .type 32
    .endef
    .seh_proc smallFunc
smallFunc:
    ret
    .seh_endproc

    // Function with no .seh directives, but with .seh_handlerdata.
    // No xdata/pdata entries are generated, but the custom handler data
    // (the .long after .seh_handlerdata) is left orphaned in the xdata
    // section.
    .globl handlerFunc
    .def handlerFunc
    .scl 2
    .type 32
    .endef
    .seh_proc handlerFunc
handlerFunc:
    ret
    .seh_handler __C_specific_handler, @except
    .seh_handlerdata
    .long 0
    .text
    .seh_endproc
