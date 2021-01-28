; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define amdgpu_kernel void @set_inactive(i32 addrspace(1)* %out, i32 %in) {
; GCN-LABEL: set_inactive:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GCN-NEXT:    s_load_dword s0, s[0:1], 0x2c
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    s_not_b64 exec, exec
; GCN-NEXT:    v_mov_b32_e32 v0, 42
; GCN-NEXT:    s_not_b64 exec, exec
; GCN-NEXT:    s_mov_b32 s7, 0xf000
; GCN-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GCN-NEXT:    s_endpgm
  %tmp = call i32 @llvm.amdgcn.set.inactive.i32(i32 %in, i32 42) #0
  store i32 %tmp, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @set_inactive_64(i64 addrspace(1)* %out, i64 %in) {
; GCN-LABEL: set_inactive_64:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s2
; GCN-NEXT:    v_mov_b32_e32 v1, s3
; GCN-NEXT:    s_not_b64 exec, exec
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    s_not_b64 exec, exec
; GCN-NEXT:    v_mov_b32_e32 v3, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    flat_store_dwordx2 v[2:3], v[0:1]
; GCN-NEXT:    s_endpgm
  %tmp = call i64 @llvm.amdgcn.set.inactive.i64(i64 %in, i64 0) #0
  store i64 %tmp, i64 addrspace(1)* %out
  ret void
}

declare i32 @llvm.amdgcn.set.inactive.i32(i32, i32) #0
declare i64 @llvm.amdgcn.set.inactive.i64(i64, i64) #0

attributes #0 = { convergent readnone }
