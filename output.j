.class public output
.super java/lang/Object

.method public <init>()V
	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 20
	.limit locals 4

	ldc 1
	newarray int
	astore 1
	aload 1
	iconst_0
	iconst_2
	iastore
	iconst_2
	i2d
	iconst_3
	i2d
	invokestatic java/lang/Math/pow(DD)D
	d2i
	istore 3
	iconst_0
	istore 2
	getstatic java/lang/System/out Ljava/io/PrintStream;
	ldc 11
	aload 1
	iconst_0
	iaload
	irem
	invokevirtual java/io/PrintStream/print(I)V
	return
.end method
