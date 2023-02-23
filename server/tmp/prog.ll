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

define i32 @main() {
enterSubroutine:
  %0 = call %RuntimeStackTy* @runtimeStackMallocThenInit()
  store %RuntimeStackTy* %0, %RuntimeStackTy** @globalStack
  %1 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  %2 = call i64 @runtimeStackSave(%RuntimeStackTy* %1)
  %3 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %3, i32 123)
  call void @variablePrintToStdout(%RuntimeVariable* %3)
  call void @variableDestructThenFree(%RuntimeVariable* %3)
  %4 = call %RuntimeType* @typeMalloc()
  call void @typeInitFromIntegerScalar(%RuntimeType* %4)
  %5 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromIntegerScalar(%RuntimeVariable* %5, i32 0)
  %6 = call %RuntimeVariable* @variableMalloc()
  call void @variableInitFromDeclaration(%RuntimeVariable* %6, %RuntimeType* %4, %RuntimeVariable* %5)
  call void @typeDestructThenFree(%RuntimeType* %4)
  call void @variableDestructThenFree(%RuntimeVariable* %5)
  %7 = call i32 @variableGetIntegerValue(%RuntimeVariable* %6)
  call void @variableDestructThenFree(%RuntimeVariable* %6)
  %8 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  call void @runtimeStackRestore(%RuntimeStackTy* %8, i64 %2)
  %9 = load %RuntimeStackTy*, %RuntimeStackTy** @globalStack
  call void @runtimeStackDestructThenFree(%RuntimeStackTy* %9)
  ret i32 %7
}
