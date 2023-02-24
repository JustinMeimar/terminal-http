; ModuleID = 'gazprea'
source_filename = "gazprea"

%RuntimeStackTy = type { i64, i64, %RuntimeStackItemTy* }
%RuntimeStackItemTy = type { i32, i8* }
%RuntimeVariable = type { %RuntimeType*, i8*, i64, i8* }
%RuntimeType = type { i32, i8* }

@globalStack = internal global %RuntimeStackTy* null

declare void @variableInitFromBooleanScalar(%RuntimeVariable*, i32)

declare void @variableInitFromIntegerScalar(%RuntimeVariable*, i32)

declare void @variableInitFromRealScalar(%RuntimeVariable*, float)

declare void @variableInitFromCharacterScalar(%RuntimeVariable*, i8)

declare void @variableInitFromString(%RuntimeVariable*, i64, i8*)

declare void @variableInitFromNullScalar(%RuntimeVariable*)

declare void @variableInitFromIdentityScalar(%RuntimeVariable*)

declare void @variableInitFromNull(%RuntimeVariable*, %RuntimeType*)

declare void @variableInitFromIdentity(%RuntimeVariable*, %RuntimeType*)

declare void @variableInitFromCast(%RuntimeVariable*, %RuntimeType*, %RuntimeVariable*)

declare void @variableReadFromStdin(%RuntimeVariable*)

declare void @variablePrintToStdout(%RuntimeVariable*)

declare void @variableInitFromUnaryOp(%RuntimeVariable*, %RuntimeVariable*, i32)

declare void @variableInitFromBinaryOp(%RuntimeVariable*, %RuntimeVariable*, %RuntimeVariable*, i32)

declare %RuntimeVariable* @variableMalloc()

declare %RuntimeType* @typeMalloc()

declare void @variableInitFromDeclaration(%RuntimeVariable*, %RuntimeType*, %RuntimeVariable*)

declare void @variableAssignment(%RuntimeVariable*, %RuntimeVariable*)

declare void @variableReplace(%RuntimeVariable*, %RuntimeVariable*)

declare i32 @variableGetIntegerValue(%RuntimeVariable*)

declare i32 @variableGetBooleanValue(%RuntimeVariable*)

declare void @typeInitFromBooleanScalar(%RuntimeType*)

declare void @typeInitFromIntegerScalar(%RuntimeType*)

declare void @typeInitFromRealScalar(%RuntimeType*)

declare void @typeInitFromCharacterScalar(%RuntimeType*)

declare void @typeInitFromUnspecifiedString(%RuntimeType*)

declare void @typeInitFromIntegerInterval(%RuntimeType*)

declare void @typeInitFromVectorSizeSpecification(%RuntimeType*, %RuntimeVariable*, %RuntimeType*)

declare void @typeInitFromMatrixSizeSpecification(%RuntimeType*, %RuntimeVariable*, %RuntimeVariable*, %RuntimeType*)

declare void @typeInitFromUnknownType(%RuntimeType*)

declare void @variableInitFromParameter(%RuntimeVariable*, %RuntimeType*, %RuntimeVariable*)

declare void @variableInitFromMemcpy(%RuntimeVariable*, %RuntimeVariable*)

declare void @variableDestructThenFree(%RuntimeVariable*)

declare void @typeDestructThenFree(%RuntimeType*)

declare %RuntimeVariable** @variableArrayMalloc(i64)

declare void @variableArraySet(%RuntimeVariable**, i64, %RuntimeVariable*)

declare void @variableArrayFree(%RuntimeVariable**)

declare void @freeArrayContents(%RuntimeVariable**, i64)

declare %RuntimeType** @typeArrayMalloc(i64)

declare void @typeArraySet(%RuntimeType**, i64, %RuntimeType*)

declare void @typeArrayFree(%RuntimeType**)

declare i64* @stridArrayMalloc(i64)

declare void @stridArraySet(i64*, i64, i64)

declare void @stridArrayFree(i64*)

declare void @typeInitFromTupleType(%RuntimeType*, i64, %RuntimeType**, i64*)

declare void @variableInitFromTupleLiteral(%RuntimeVariable*, i64, %RuntimeVariable**)

declare %RuntimeVariable* @variableGetTupleField(%RuntimeVariable*, i64)

declare %RuntimeVariable* @variableGetTupleFieldFromID(%RuntimeVariable*, i64)

declare void @variableInitFromVectorLiteral(%RuntimeVariable*, i64, %RuntimeVariable**)

declare %RuntimeType* @variableSwapType(%RuntimeVariable*, %RuntimeType*)

declare %RuntimeType* @variableGetType(%RuntimeVariable*)

declare void @variableInitFromVectorIndexing(%RuntimeVariable*, %RuntimeVariable*, %RuntimeVariable*)

declare void @variableInitFromMatrixIndexing(%RuntimeVariable*, %RuntimeVariable*, %RuntimeVariable*, %RuntimeVariable*)

declare void @variableInitFromDomainExpression(%RuntimeVariable*, %RuntimeVariable*)

declare i64 @variableGetLength(%RuntimeVariable*)

declare void @variableInitFromArrayElementAtIndex(%RuntimeVariable*, %RuntimeVariable*, i64)

declare void @variableInitFromIntegerArrayElementAtIndex(%RuntimeVariable*, %RuntimeVariable*, i64)

declare void @variableInitFromFilterArray(%RuntimeVariable*, i64, %RuntimeVariable*, i32*)

declare i32* @acceptMatrixMalloc(i64, i64)

declare void @acceptArraySet(i32*, i64, i64, i64, i32)

declare void @acceptMatrixFree(i32*)

declare void @variableSetIsBlockScoped(%RuntimeVariable*, i8)

declare %RuntimeStackTy* @runtimeStackMallocThenInit()

declare void @runtimeStackDestructThenFree(%RuntimeStackTy*)

declare %RuntimeVariable* @variableStackAllocate(%RuntimeStackTy*)

declare %RuntimeType* @typeStackAllocate(%RuntimeStackTy*)

declare i64 @runtimeStackSave(%RuntimeStackTy*)

declare void @runtimeStackRestore(%RuntimeStackTy*, i64)

declare %RuntimeVariable* @BuiltInStreamState()

declare %RuntimeVariable* @BuiltInLength(%RuntimeVariable*)

declare %RuntimeVariable* @BuiltInReverse(%RuntimeVariable*)

declare %RuntimeVariable* @BuiltInRows(%RuntimeVariable*)

declare %RuntimeVariable* @BuiltInColumns(%RuntimeVariable*)

define void @gazprea.subroutine.swap(%RuntimeVariable* %0, %RuntimeVariable* %1) {
enterSubroutine:
  %2 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %2)
  %3 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %3)
  call void @typeDestructThenFree(%RuntimeType* %2)
  call void @typeDestructThenFree(%RuntimeType* %3)
  %4 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  %5 = call i64 @runtimeStackSave(%RuntimeStackTy* %4)
  %6 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %6)
  %7 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %7)
  call void @typeDestructThenFree(%RuntimeType* %6)
  %8 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromDeclaration(%RuntimeVariable* %8, %RuntimeType* %7, %RuntimeVariable* %0)
  call void @typeDestructThenFree(%RuntimeType* %7)
  call void @variableAssignment(%RuntimeVariable* %0, %RuntimeVariable* %1)
  call void @variableAssignment(%RuntimeVariable* %1, %RuntimeVariable* %8)
  call void @variableDestructThenFree(%RuntimeVariable* %8)
  ret void
}

define %RuntimeVariable* @gazprea.subroutine.partition(%RuntimeVariable* %0, %RuntimeVariable* %1, %RuntimeVariable* %2) {
enterSubroutine:
  %3 = call %RuntimeType* @typeMalloc()
  %4 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %4)
  call void @typeInitFromVectorSizeSpecification(%RuntimeType* %3, %RuntimeVariable* null, %RuntimeType* %4)
  call void @typeDestructThenFree(%RuntimeType* %4)
  %5 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %5)
  %6 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %6)
  call void @typeDestructThenFree(%RuntimeType* %3)
  %7 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromParameter(%RuntimeVariable* %7, %RuntimeType* %5, %RuntimeVariable* %1)
  call void @typeDestructThenFree(%RuntimeType* %5)
  %8 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromParameter(%RuntimeVariable* %8, %RuntimeType* %6, %RuntimeVariable* %2)
  call void @typeDestructThenFree(%RuntimeType* %6)
  %9 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  %10 = call i64 @runtimeStackSave(%RuntimeStackTy* %9)
  %11 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %11)
  %12 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %12)
  call void @typeDestructThenFree(%RuntimeType* %11)
  %13 = call %RuntimeVariable* @variableMalloc()
  %14 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorIndexing(%RuntimeVariable* %14, %RuntimeVariable* %0, %RuntimeVariable* %8)
  call void @variableInitFromDeclaration(%RuntimeVariable* %13, %RuntimeType* %12, %RuntimeVariable* %14)
  call void @variableDestructThenFree(%RuntimeVariable* %14)
  call void @typeDestructThenFree(%RuntimeType* %12)
  %15 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %15)
  %16 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %16)
  call void @typeDestructThenFree(%RuntimeType* %15)
  %17 = call %RuntimeVariable* @variableMalloc()
  %18 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %18, i32 1)
  %19 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %19, %RuntimeVariable* %7, %RuntimeVariable* %18, i32 8)
  call void @variableDestructThenFree(%RuntimeVariable* %18)
  call void @variableInitFromDeclaration(%RuntimeVariable* %17, %RuntimeType* %16, %RuntimeVariable* %19)
  call void @variableDestructThenFree(%RuntimeVariable* %19)
  call void @typeDestructThenFree(%RuntimeType* %16)
  %20 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %20)
  %21 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %21)
  call void @typeDestructThenFree(%RuntimeType* %20)
  %22 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromDeclaration(%RuntimeVariable* %22, %RuntimeType* %21, %RuntimeVariable* %7)
  call void @typeDestructThenFree(%RuntimeType* %21)
  br label %LoopCondition

LoopCondition:                                    ; preds = %Merge, %enterSubroutine
  %23 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %23, i32 1)
  %24 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %24, %RuntimeVariable* %8, %RuntimeVariable* %23, i32 8)
  call void @variableDestructThenFree(%RuntimeVariable* %23)
  %25 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %25, %RuntimeVariable* %22, %RuntimeVariable* %24, i32 12)
  call void @variableDestructThenFree(%RuntimeVariable* %24)
  %26 = call i32 @variableGetBooleanValue(%RuntimeVariable* %25)
  call void @variableDestructThenFree(%RuntimeVariable* %25)
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %LoopBody, label %LoopMerge

LoopBody:                                         ; preds = %LoopCondition
  br label %IfHeaderBlock

IfHeaderBlock:                                    ; preds = %LoopBody
  %28 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorIndexing(%RuntimeVariable* %28, %RuntimeVariable* %0, %RuntimeVariable* %22)
  %29 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %29, %RuntimeVariable* %28, %RuntimeVariable* %13, i32 10)
  call void @variableDestructThenFree(%RuntimeVariable* %28)
  %30 = call i32 @variableGetBooleanValue(%RuntimeVariable* %29)
  call void @variableDestructThenFree(%RuntimeVariable* %29)
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %IfBodyBlock, label %Merge

IfBodyBlock:                                      ; preds = %IfHeaderBlock
  %32 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %32, i32 1)
  %33 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %33, %RuntimeVariable* %17, %RuntimeVariable* %32, i32 7)
  call void @variableDestructThenFree(%RuntimeVariable* %32)
  call void @variableAssignment(%RuntimeVariable* %17, %RuntimeVariable* %33)
  call void @variableDestructThenFree(%RuntimeVariable* %33)
  %34 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorIndexing(%RuntimeVariable* %34, %RuntimeVariable* %0, %RuntimeVariable* %17)
  %35 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorIndexing(%RuntimeVariable* %35, %RuntimeVariable* %0, %RuntimeVariable* %22)
  call void @gazprea.subroutine.swap(%RuntimeVariable* %34, %RuntimeVariable* %35)
  call void @variableDestructThenFree(%RuntimeVariable* %34)
  call void @variableDestructThenFree(%RuntimeVariable* %35)
  br label %Merge

Merge:                                            ; preds = %IfBodyBlock, %IfHeaderBlock
  %36 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %36, i32 1)
  %37 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %37, %RuntimeVariable* %22, %RuntimeVariable* %36, i32 7)
  call void @variableDestructThenFree(%RuntimeVariable* %36)
  call void @variableAssignment(%RuntimeVariable* %22, %RuntimeVariable* %37)
  call void @variableDestructThenFree(%RuntimeVariable* %37)
  br label %LoopCondition

LoopMerge:                                        ; preds = %LoopCondition
  %38 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %38, i32 1)
  %39 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %39, %RuntimeVariable* %17, %RuntimeVariable* %38, i32 7)
  call void @variableDestructThenFree(%RuntimeVariable* %38)
  %40 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorIndexing(%RuntimeVariable* %40, %RuntimeVariable* %0, %RuntimeVariable* %39)
  call void @variableDestructThenFree(%RuntimeVariable* %39)
  %41 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorIndexing(%RuntimeVariable* %41, %RuntimeVariable* %0, %RuntimeVariable* %8)
  call void @gazprea.subroutine.swap(%RuntimeVariable* %40, %RuntimeVariable* %41)
  call void @variableDestructThenFree(%RuntimeVariable* %40)
  call void @variableDestructThenFree(%RuntimeVariable* %41)
  %42 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %42)
  %43 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %43, i32 1)
  %44 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %44, %RuntimeVariable* %17, %RuntimeVariable* %43, i32 7)
  call void @variableDestructThenFree(%RuntimeVariable* %43)
  %45 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromDeclaration(%RuntimeVariable* %45, %RuntimeType* %42, %RuntimeVariable* %44)
  call void @typeDestructThenFree(%RuntimeType* %42)
  call void @variableDestructThenFree(%RuntimeVariable* %44)
  call void @variableDestructThenFree(%RuntimeVariable* %7)
  call void @variableDestructThenFree(%RuntimeVariable* %8)
  call void @variableDestructThenFree(%RuntimeVariable* %17)
  call void @variableDestructThenFree(%RuntimeVariable* %22)
  call void @variableDestructThenFree(%RuntimeVariable* %13)
  %46 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  call void @runtimeStackRestore(%RuntimeStackTy* %46, i64 %10)
  ret %RuntimeVariable* %45
}

define void @gazprea.subroutine.quickSort(%RuntimeVariable* %0, %RuntimeVariable* %1, %RuntimeVariable* %2) {
enterSubroutine:
  %3 = call %RuntimeType* @typeMalloc()
  %4 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %4)
  call void @typeInitFromVectorSizeSpecification(%RuntimeType* %3, %RuntimeVariable* null, %RuntimeType* %4)
  call void @typeDestructThenFree(%RuntimeType* %4)
  %5 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %5)
  %6 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %6)
  call void @typeDestructThenFree(%RuntimeType* %3)
  %7 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromParameter(%RuntimeVariable* %7, %RuntimeType* %5, %RuntimeVariable* %1)
  call void @typeDestructThenFree(%RuntimeType* %5)
  %8 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromParameter(%RuntimeVariable* %8, %RuntimeType* %6, %RuntimeVariable* %2)
  call void @typeDestructThenFree(%RuntimeType* %6)
  %9 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  %10 = call i64 @runtimeStackSave(%RuntimeStackTy* %9)
  br label %IfHeaderBlock

IfHeaderBlock:                                    ; preds = %enterSubroutine
  %11 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %11, %RuntimeVariable* %7, %RuntimeVariable* %8, i32 10)
  %12 = call i32 @variableGetBooleanValue(%RuntimeVariable* %11)
  call void @variableDestructThenFree(%RuntimeVariable* %11)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %IfBodyBlock, label %Merge

IfBodyBlock:                                      ; preds = %IfHeaderBlock
  %14 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %14)
  %15 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %15)
  call void @typeDestructThenFree(%RuntimeType* %14)
  %16 = call %RuntimeVariable* @variableMalloc()
  %17 = call %RuntimeVariable* @gazprea.subroutine.partition(%RuntimeVariable* %0, %RuntimeVariable* %7, %RuntimeVariable* %8)
  call void @variableInitFromDeclaration(%RuntimeVariable* %16, %RuntimeType* %15, %RuntimeVariable* %17)
  call void @variableDestructThenFree(%RuntimeVariable* %17)
  call void @typeDestructThenFree(%RuntimeType* %15)
  %18 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %18, i32 1)
  %19 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %19, %RuntimeVariable* %16, %RuntimeVariable* %18, i32 8)
  call void @variableDestructThenFree(%RuntimeVariable* %18)
  call void @gazprea.subroutine.quickSort(%RuntimeVariable* %0, %RuntimeVariable* %7, %RuntimeVariable* %19)
  call void @variableDestructThenFree(%RuntimeVariable* %19)
  %20 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %20, i32 1)
  %21 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromBinaryOp(%RuntimeVariable* %21, %RuntimeVariable* %16, %RuntimeVariable* %20, i32 7)
  call void @variableDestructThenFree(%RuntimeVariable* %20)
  call void @gazprea.subroutine.quickSort(%RuntimeVariable* %0, %RuntimeVariable* %21, %RuntimeVariable* %8)
  call void @variableDestructThenFree(%RuntimeVariable* %21)
  call void @variableDestructThenFree(%RuntimeVariable* %16)
  br label %Merge

Merge:                                            ; preds = %IfBodyBlock, %IfHeaderBlock
  call void @variableDestructThenFree(%RuntimeVariable* %7)
  call void @variableDestructThenFree(%RuntimeVariable* %8)
  ret void
}

define i32 @main() {
enterSubroutine:
  %0 = call %RuntimeStackTy* @runtimeStackMallocThenInit()
  store %RuntimeStackTy* %0, %RuntimeStackTy** @globalStack
  %1 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  %2 = call i64 @runtimeStackSave(%RuntimeStackTy* %1)
  %3 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %3)
  %4 = call %RuntimeType* @typeMalloc()
  %5 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %5)
  call void @typeInitFromVectorSizeSpecification(%RuntimeType* %4, %RuntimeVariable* null, %RuntimeType* %5)
  call void @typeDestructThenFree(%RuntimeType* %5)
  call void @typeDestructThenFree(%RuntimeType* %3)
  %6 = call %RuntimeVariable* @variableMalloc()
  %7 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %7, i32 10)
  %8 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %8, i32 7)
  %9 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %9, i32 8)
  %10 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %10, i32 9)
  %11 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %11, i32 1)
  %12 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %12, i32 5)
  %13 = call %RuntimeVariable** @variableArrayMalloc(i64 6)
  call void @variableArraySet(%RuntimeVariable** %13, i64 0, %RuntimeVariable* %7)
  call void @variableArraySet(%RuntimeVariable** %13, i64 1, %RuntimeVariable* %8)
  call void @variableArraySet(%RuntimeVariable** %13, i64 2, %RuntimeVariable* %9)
  call void @variableArraySet(%RuntimeVariable** %13, i64 3, %RuntimeVariable* %10)
  call void @variableArraySet(%RuntimeVariable** %13, i64 4, %RuntimeVariable* %11)
  call void @variableArraySet(%RuntimeVariable** %13, i64 5, %RuntimeVariable* %12)
  %14 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromVectorLiteral(%RuntimeVariable* %14, i64 6, %RuntimeVariable** %13)
  call void @variableArrayFree(%RuntimeVariable** %13)
  call void @variableDestructThenFree(%RuntimeVariable* %7)
  call void @variableDestructThenFree(%RuntimeVariable* %8)
  call void @variableDestructThenFree(%RuntimeVariable* %9)
  call void @variableDestructThenFree(%RuntimeVariable* %10)
  call void @variableDestructThenFree(%RuntimeVariable* %11)
  call void @variableDestructThenFree(%RuntimeVariable* %12)
  call void @variableInitFromDeclaration(%RuntimeVariable* %6, %RuntimeType* %4, %RuntimeVariable* %14)
  call void @variableDestructThenFree(%RuntimeVariable* %14)
  call void @typeDestructThenFree(%RuntimeType* %4)
  %15 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %15, i32 1)
  %16 = call %RuntimeVariable* @BuiltInLength(%RuntimeVariable* %6)
  call void @gazprea.subroutine.quickSort(%RuntimeVariable* %6, %RuntimeVariable* %15, %RuntimeVariable* %16)
  call void @variableDestructThenFree(%RuntimeVariable* %15)
  call void @variableDestructThenFree(%RuntimeVariable* %16)
  call void @variablePrintToStdout(%RuntimeVariable* %6)
  %17 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %17)
  %18 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %18)
  %19 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromRealScalar(%RuntimeVariable* %19, float 0.000000e+00)
  %20 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromCast(%RuntimeVariable* %20, %RuntimeType* %18, %RuntimeVariable* %19)
  call void @typeDestructThenFree(%RuntimeType* %18)
  call void @variableDestructThenFree(%RuntimeVariable* %19)
  %21 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromDeclaration(%RuntimeVariable* %21, %RuntimeType* %17, %RuntimeVariable* %20)
  call void @typeDestructThenFree(%RuntimeType* %17)
  call void @variableDestructThenFree(%RuntimeVariable* %20)
  %22 = call i32 @variableGetIntegerValue(%RuntimeVariable* %21)
  call void @variableDestructThenFree(%RuntimeVariable* %6)
  call void @variableDestructThenFree(%RuntimeVariable* %21)
  %23 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  call void @runtimeStackRestore(%RuntimeStackTy* %23, i64 %2)
  %24 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  call void @runtimeStackDestructThenFree(%RuntimeStackTy* %24)
  ret i32 %22
}
