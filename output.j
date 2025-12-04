.class public output
.super java/lang/Object

.method public <init>()V
	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return
.end method

.method public static main([Ljava/lang/String;)V
	.limit stack 10
	.limit locals 10

	iconst_2
	iconst_3
	i2d
	swap
	i2d
	invokestatic java/lang/Math/pow(DD)D
	d2i
	istore 0
	iconst_0
	istore 0
	iconst_0
	istore 0
l0:
	iload 0
	iconst_5
	if_icmplt l1
	goto l2
l1:
	getstatic java/lang/System/out Ljava/io/PrintStream;
	iload 0
	iconst_2
	irem
	swap
	invokevirtual java/io/PrintStream/print(I)V
	iload 0
	iconst_1
	iadd
	istore 0
	goto l0
l2:
	return
.end method
