; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv -spirv-text %t.bc -o %t.spt
; RUN: FileCheck < %t.spt %s -check-prefix=CHECK-SPIRV

; RUN: llvm-spirv -to-binary %t.spt -o %t.spv
; RUN: llvm-spirv -r %t.spv -o %t.rev.bc
; RUN: llvm-dis %t.rev.bc -o %t.rev.ll
; RUN: FileCheck < %t.rev.ll %s -check-prefix=CHECK-LLVM

; CHECK-SPIRV: String [[#VarNameId:]] "A$1$upperbound"
; CHECK-SPIRV: [[#FuncNameId:]] "random_fill_sp"
; CHECK-SPIRV: [[#DbgFuncId:]] [[#]] DebugFunction [[#FuncNameId]]
; CHECK-SPIRV: [[#DbgTemplateId:]] [[#]] DebugTemplate [[#DbgFuncId]]
; CHECK-SPIRV: [[#]] [[#DbgLocVarId:]] [[#]] DebugLocalVariable [[#VarNameId]] [[#]] [[#]] [[#]] [[#]] [[#DbgTemplateId]]
; CHECK-SPIRV: DebugTypeArray [[#]] [[#DbgLocVarId]]

; CHECK-LLVM: !DICompositeType(tag: DW_TAG_array_type, baseType: ![[#BaseType:]], size: 32, elements: ![[#Subrange1:]])
; CHECK-LLVM: [[#BaseType]] = !DIBasicType(name: "REAL*4", size: 32, encoding: DW_ATE_float)
; CHECK-LLVM: [[#Subrange1]] = !{![[#Subrange2:]]}
; CHECK-LLVM: [[#Subrange2:]] = !DISubrange(lowerBound: 1, upperBound: ![[#UpperBound:]])
; CHECK-LLVM: [[#UpperBound]] = !DILocalVariable(name: "A$1$upperbound"

; ModuleID = 'DebugInfoSubrangeUpperBound.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

%structtype = type { [72 x i1] }
%"QNCA_a0$float" = type { float addrspace(4)*, i64, i64, i64, i64, i64, [1 x %structtype2] }
%structtype2 = type { i64, i64, i64 }

; Function Attrs: noinline nounwind
define spir_kernel void @__omp_offloading_811_198142f_random_fill_sp_l25(%structtype* byval(%structtype) %"ascast$val") #0 !kernel_arg_addr_space !9 !kernel_arg_access_qual !10 !kernel_arg_type !11 !kernel_arg_type_qual !12 !kernel_arg_base_type !11 {
newFuncRoot:
  %.ascast = bitcast %structtype* %"ascast$val" to %"QNCA_a0$float"*
  call void @llvm.dbg.value(metadata %"QNCA_a0$float"* %.ascast, metadata !13, metadata !DIExpression(DW_OP_deref)), !dbg !27
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0, !1}
!llvm.dbg.cu = !{!2}
!spirv.MemoryModel = !{!4}
!opencl.enable.FP_CONTRACT = !{}
!spirv.Source = !{!5}
!opencl.spir.version = !{!6}
!opencl.ocl.version = !{!6}
!opencl.used.extensions = !{!7}
!opencl.used.optional.core.features = !{!7}
!spirv.Generator = !{!8}

!0 = !{i32 7, !"Dwarf Version", i32 4}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = distinct !DICompileUnit(language: DW_LANG_OpenCL, file: !3, producer: "Fortran", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug)
!3 = !DIFile(filename: "f.f90", directory: "Fortran")
!4 = !{i32 2, i32 2}
!5 = !{i32 4, i32 200000}
!6 = !{i32 2, i32 0}
!7 = !{}
!8 = !{i16 6, i16 14}
!9 = !{i32 0}
!10 = !{!"none"}
!11 = !{!"structtype"}
!12 = !{!""}
!13 = !DILocalVariable(name: "a", scope: !14, file: !3, line: 15, type: !18)
!14 = distinct !DISubprogram(name: "random_fill_sp.DIR.OMP.TARGET.8.split.split.split.split", scope: null, file: !3, line: 25, type: !15, scopeLine: 25, flags: DIFlagArtificial, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, templateParams: !7, retainedNodes: !17)
!15 = !DISubroutineType(types: !16)
!16 = !{null}
!17 = !{!13}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 32, elements: !21)
!20 = !DIBasicType(name: "REAL*4", size: 32, encoding: DW_ATE_float)
!21 = !{!22}
!22 = !DISubrange(lowerBound: 1, upperBound: !23)
!23 = !DILocalVariable(name: "A$1$upperbound", scope: !24, type: !26, flags: DIFlagArtificial)
!24 = distinct !DISubprogram(name: "random_fill_sp", linkageName: "random_fill_sp", scope: null, file: !3, line: 15, type: !15, scopeLine: 15, spFlags: DISPFlagDefinition, unit: !2, templateParams: !7, retainedNodes: !25)
!25 = !{!23}
!26 = !DIBasicType(name: "INTEGER*8", size: 64, encoding: DW_ATE_signed)
!27 = !DILocation(line: 15, column: 67, scope: !14)
