; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN %s

; Check lowering of some large insertelement that use the stack
; instead of register indexing.

define amdgpu_kernel void @v_insert_v64i32_varidx(<64 x i32> addrspace(1)* %out.ptr, <64 x i32> addrspace(1)* %ptr, i32 %val, i32 %idx) #0 {
; GCN-LABEL: v_insert_v64i32_varidx:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_add_u32 s0, s0, s7
; GCN-NEXT:    s_load_dwordx4 s[8:11], s[4:5], 0x0
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x10
; GCN-NEXT:    v_mov_b32_e32 v16, 0x100
; GCN-NEXT:    s_addc_u32 s1, s1, 0
; GCN-NEXT:    v_add_u32_e32 v31, 64, v16
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_load_dwordx16 s[12:27], s[10:11], 0x0
; GCN-NEXT:    s_load_dwordx16 s[52:67], s[10:11], 0x40
; GCN-NEXT:    s_load_dwordx16 s[36:51], s[10:11], 0x80
; GCN-NEXT:    v_add_u32_e32 v32, 0x44, v16
; GCN-NEXT:    v_add_u32_e32 v33, 0x48, v16
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, s12
; GCN-NEXT:    v_mov_b32_e32 v1, s13
; GCN-NEXT:    v_mov_b32_e32 v2, s14
; GCN-NEXT:    v_mov_b32_e32 v3, s15
; GCN-NEXT:    v_mov_b32_e32 v4, s16
; GCN-NEXT:    v_mov_b32_e32 v5, s17
; GCN-NEXT:    v_mov_b32_e32 v6, s18
; GCN-NEXT:    v_mov_b32_e32 v7, s19
; GCN-NEXT:    v_mov_b32_e32 v8, s20
; GCN-NEXT:    v_mov_b32_e32 v9, s21
; GCN-NEXT:    v_mov_b32_e32 v10, s22
; GCN-NEXT:    v_mov_b32_e32 v11, s23
; GCN-NEXT:    v_mov_b32_e32 v12, s24
; GCN-NEXT:    v_mov_b32_e32 v13, s25
; GCN-NEXT:    v_mov_b32_e32 v14, s26
; GCN-NEXT:    v_mov_b32_e32 v15, s27
; GCN-NEXT:    s_load_dwordx16 s[12:27], s[10:11], 0xc0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:256
; GCN-NEXT:    v_add_u32_e32 v0, 4, v16
; GCN-NEXT:    buffer_store_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v1, s52
; GCN-NEXT:    buffer_store_dword v1, v31, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v1, s53
; GCN-NEXT:    buffer_store_dword v1, v32, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v1, s54
; GCN-NEXT:    buffer_store_dword v1, v33, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s4, 0x50
; GCN-NEXT:    v_add_u32_e32 v34, 0x4c, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s55
; GCN-NEXT:    buffer_store_dword v1, v34, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v35, s4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s56
; GCN-NEXT:    buffer_store_dword v1, v35, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v36, 0x54, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s57
; GCN-NEXT:    buffer_store_dword v1, v36, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v37, 0x58, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s58
; GCN-NEXT:    buffer_store_dword v1, v37, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s5, 0x60
; GCN-NEXT:    v_add_u32_e32 v38, 0x5c, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s59
; GCN-NEXT:    buffer_store_dword v1, v38, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v39, s5, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s60
; GCN-NEXT:    buffer_store_dword v1, v39, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v40, 0x64, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s61
; GCN-NEXT:    buffer_store_dword v1, v40, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v41, 0x68, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s62
; GCN-NEXT:    buffer_store_dword v1, v41, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s10, 0x70
; GCN-NEXT:    v_add_u32_e32 v42, 0x6c, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s63
; GCN-NEXT:    buffer_store_dword v1, v42, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v43, s10, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s64
; GCN-NEXT:    buffer_store_dword v1, v43, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v44, 0x74, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s65
; GCN-NEXT:    buffer_store_dword v1, v44, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v45, 0x78, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s66
; GCN-NEXT:    buffer_store_dword v1, v45, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v46, 0x7c, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s67
; GCN-NEXT:    buffer_store_dword v1, v46, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v47, 0x80, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s36
; GCN-NEXT:    buffer_store_dword v1, v47, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v48, 0x84, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s37
; GCN-NEXT:    buffer_store_dword v1, v48, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v49, 0x88, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s38
; GCN-NEXT:    buffer_store_dword v1, v49, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s11, 0x90
; GCN-NEXT:    v_add_u32_e32 v50, 0x8c, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s39
; GCN-NEXT:    buffer_store_dword v1, v50, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v51, s11, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s40
; GCN-NEXT:    buffer_store_dword v1, v51, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v52, 0x94, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s41
; GCN-NEXT:    buffer_store_dword v1, v52, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v53, 0x98, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s42
; GCN-NEXT:    buffer_store_dword v1, v53, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s28, 0xa0
; GCN-NEXT:    v_add_u32_e32 v54, 0x9c, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s43
; GCN-NEXT:    buffer_store_dword v1, v54, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v55, s28, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s44
; GCN-NEXT:    buffer_store_dword v1, v55, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v56, 0xa4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s45
; GCN-NEXT:    buffer_store_dword v1, v56, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v57, 0xa8, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s46
; GCN-NEXT:    buffer_store_dword v1, v57, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s29, 0xb0
; GCN-NEXT:    v_add_u32_e32 v58, 0xac, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s47
; GCN-NEXT:    buffer_store_dword v1, v58, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v59, s29, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s48
; GCN-NEXT:    buffer_store_dword v1, v59, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v60, 0xb4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s49
; GCN-NEXT:    buffer_store_dword v1, v60, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v61, 0xb8, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s50
; GCN-NEXT:    buffer_store_dword v1, v61, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v62, 0xbc, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s51
; GCN-NEXT:    buffer_store_dword v1, v62, s[0:3], 0 offen
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v1, s12
; GCN-NEXT:    v_add_u32_e32 v63, 0xc0, v16
; GCN-NEXT:    buffer_store_dword v1, v63, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v1, s13
; GCN-NEXT:    v_add_u32_e32 v64, 0xc4, v16
; GCN-NEXT:    buffer_store_dword v1, v64, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v1, s14
; GCN-NEXT:    v_add_u32_e32 v65, 0xc8, v16
; GCN-NEXT:    buffer_store_dword v1, v65, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s12, 0xd0
; GCN-NEXT:    v_add_u32_e32 v66, 0xcc, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s15
; GCN-NEXT:    buffer_store_dword v1, v66, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v67, s12, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s16
; GCN-NEXT:    buffer_store_dword v1, v67, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v68, 0xd4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s17
; GCN-NEXT:    buffer_store_dword v1, v68, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v69, 0xd8, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s18
; GCN-NEXT:    buffer_store_dword v1, v69, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s13, 0xe0
; GCN-NEXT:    v_add_u32_e32 v70, 0xdc, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s19
; GCN-NEXT:    buffer_store_dword v1, v70, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v71, s13, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s20
; GCN-NEXT:    buffer_store_dword v1, v71, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v72, 0xe4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s21
; GCN-NEXT:    buffer_store_dword v1, v72, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v73, 0xe8, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s22
; GCN-NEXT:    buffer_store_dword v1, v73, s[0:3], 0 offen
; GCN-NEXT:    s_movk_i32 s14, 0xf0
; GCN-NEXT:    v_add_u32_e32 v74, 0xec, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s23
; GCN-NEXT:    buffer_store_dword v1, v74, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v75, s14, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s24
; GCN-NEXT:    buffer_store_dword v1, v75, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v76, 0xf4, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s25
; GCN-NEXT:    s_and_b32 s7, s7, 63
; GCN-NEXT:    buffer_store_dword v1, v76, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v77, 0xf8, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s26
; GCN-NEXT:    v_add_u32_e32 v17, 8, v16
; GCN-NEXT:    buffer_store_dword v1, v77, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v78, 0xfc, v16
; GCN-NEXT:    v_mov_b32_e32 v1, s27
; GCN-NEXT:    s_lshl_b32 s7, s7, 2
; GCN-NEXT:    buffer_store_dword v2, v17, s[0:3], 0 offen
; GCN-NEXT:    v_add_u32_e32 v18, 12, v16
; GCN-NEXT:    v_add_u32_e32 v19, 16, v16
; GCN-NEXT:    v_add_u32_e32 v20, 20, v16
; GCN-NEXT:    v_add_u32_e32 v21, 24, v16
; GCN-NEXT:    v_add_u32_e32 v22, 28, v16
; GCN-NEXT:    v_add_u32_e32 v23, 32, v16
; GCN-NEXT:    v_add_u32_e32 v24, 36, v16
; GCN-NEXT:    v_add_u32_e32 v25, 40, v16
; GCN-NEXT:    v_add_u32_e32 v26, 44, v16
; GCN-NEXT:    v_add_u32_e32 v27, 48, v16
; GCN-NEXT:    v_add_u32_e32 v28, 52, v16
; GCN-NEXT:    v_add_u32_e32 v29, 56, v16
; GCN-NEXT:    v_add_u32_e32 v30, 60, v16
; GCN-NEXT:    buffer_store_dword v1, v78, s[0:3], 0 offen
; GCN-NEXT:    v_mov_b32_e32 v2, s6
; GCN-NEXT:    v_add_u32_e32 v1, s7, v16
; GCN-NEXT:    buffer_store_dword v3, v18, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v4, v19, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v5, v20, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v6, v21, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v7, v22, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v8, v23, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v9, v24, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v10, v25, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v11, v26, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v12, v27, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v13, v28, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v14, v29, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v15, v30, s[0:3], 0 offen
; GCN-NEXT:    buffer_store_dword v2, v1, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v1, v0, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v2, v17, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v3, v18, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v4, v19, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v5, v20, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v6, v21, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v7, v22, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v8, v23, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v9, v24, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v10, v25, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v11, v26, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v12, v27, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v13, v28, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v14, v29, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v15, v30, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v16, v31, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v17, v32, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v18, v33, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v19, v34, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v20, v35, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v21, v36, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v22, v37, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v23, v38, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v24, v39, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v25, v40, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v26, v41, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v27, v42, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v28, v43, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v29, v44, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v30, v45, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v31, v46, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v32, v47, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v33, v48, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v34, v49, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v35, v50, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v36, v51, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v37, v52, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v38, v53, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v39, v54, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v40, v55, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v41, v56, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v42, v57, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v43, v58, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v44, v59, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v45, v60, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v46, v61, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v47, v62, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v48, v63, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v49, v64, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v50, v65, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v51, v66, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v52, v67, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v53, v68, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v54, v69, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v55, v70, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v56, v71, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v57, v72, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v58, v73, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v59, v74, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v60, v75, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v61, v76, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v62, v77, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v63, v78, s[0:3], 0 offen
; GCN-NEXT:    buffer_load_dword v0, off, s[0:3], 0 offset:256
; GCN-NEXT:    v_mov_b32_e32 v65, s9
; GCN-NEXT:    s_add_u32 s6, s8, 16
; GCN-NEXT:    v_mov_b32_e32 v64, s8
; GCN-NEXT:    s_addc_u32 s7, s9, 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    global_store_dwordx4 v[64:65], v[0:3], off
; GCN-NEXT:    s_nop 0
; GCN-NEXT:    v_mov_b32_e32 v0, s6
; GCN-NEXT:    v_mov_b32_e32 v1, s7
; GCN-NEXT:    s_add_u32 s6, s8, 32
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[4:7], off
; GCN-NEXT:    s_addc_u32 s7, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s6
; GCN-NEXT:    v_mov_b32_e32 v1, s7
; GCN-NEXT:    s_add_u32 s6, s8, 48
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[8:11], off
; GCN-NEXT:    s_addc_u32 s7, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s6
; GCN-NEXT:    v_mov_b32_e32 v1, s7
; GCN-NEXT:    s_add_u32 s6, s8, 64
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[12:15], off
; GCN-NEXT:    s_addc_u32 s7, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s6
; GCN-NEXT:    v_mov_b32_e32 v1, s7
; GCN-NEXT:    s_add_u32 s6, s8, s4
; GCN-NEXT:    s_addc_u32 s7, s9, 0
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[16:19], off
; GCN-NEXT:    v_mov_b32_e32 v0, s6
; GCN-NEXT:    s_add_u32 s4, s8, s5
; GCN-NEXT:    v_mov_b32_e32 v1, s7
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[20:23], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s10
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[24:27], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, 0x80
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[28:31], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s11
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[32:35], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s28
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[36:39], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s29
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[40:43], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, 0xc0
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[44:47], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s12
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[48:51], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s13
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[52:55], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    s_add_u32 s4, s8, s14
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[56:59], off
; GCN-NEXT:    s_addc_u32 s5, s9, 0
; GCN-NEXT:    v_mov_b32_e32 v0, s4
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    global_store_dwordx4 v[0:1], v[60:63], off
; GCN-NEXT:    s_endpgm
  %vec = load <64 x i32>, <64 x i32> addrspace(1)* %ptr
  %insert = insertelement <64 x i32> %vec, i32 %val, i32 %idx
  store <64 x i32> %insert, <64 x i32> addrspace(1)* %out.ptr
  ret void
}

attributes #0 = { "amdgpu-waves-per-eu"="1,10" }