	.file	"HiAE.c"
	.text
	.p2align 4
	.globl	HiAE_stream_init
	.type	HiAE_stream_init, @function
HiAE_stream_init:
.LFB5524:
	.cfi_startproc
	endbr64
	vmovdqa	.LC0(%rip), %xmm0
	vmovdqu	16(%rsi), %xmm1
	vpxor	%xmm13, %xmm13, %xmm13
	vmovdqu	(%rdx), %xmm2
	vmovdqu	(%rsi), %xmm12
	vmovdqa	.LC2(%rip), %xmm14
	vmovdqa	.LC1(%rip), %xmm4
	vpxorq	%xmm0, %xmm1, %xmm20
	vaesenc	%xmm0, %xmm0, %xmm3
	vpxor	%xmm2, %xmm1, %xmm6
	vmovdqa64	%xmm20, %xmm5
	vaesenc	%xmm0, %xmm2, %xmm10
	vpxor	%xmm12, %xmm2, %xmm2
	vaesenc	%xmm0, %xmm6, %xmm7
	vaesenc	%xmm0, %xmm5, %xmm5
	vpxor	%xmm14, %xmm6, %xmm6
	vaesenc	%xmm5, %xmm1, %xmm9
	vaesenc	%xmm7, %xmm13, %xmm13
	vaesenc	%xmm0, %xmm2, %xmm2
	vaesenc	%xmm3, %xmm9, %xmm3
	vaesenc	%xmm2, %xmm13, %xmm15
	vaesenc	%xmm0, %xmm14, %xmm8
	vaesenc	%xmm0, %xmm6, %xmm6
	vaesenc	%xmm10, %xmm4, %xmm10
	vmovdqa64	%xmm15, %xmm16
	vaesenc	%xmm6, %xmm15, %xmm6
	vaesenc	%xmm8, %xmm3, %xmm8
	vaesenc	%xmm0, %xmm1, %xmm15
	vaesenc	%xmm2, %xmm10, %xmm2
	vpxor	%xmm4, %xmm1, %xmm1
	vaesenc	%xmm15, %xmm8, %xmm14
	vaesenc	%xmm7, %xmm2, %xmm7
	vmovdqa64	%xmm14, %xmm18
	vaesenc	%xmm5, %xmm6, %xmm5
	vaesenc	%xmm0, %xmm4, %xmm14
	vpxor	%xmm4, %xmm9, %xmm4
	vpxor	%xmm9, %xmm13, %xmm9
	vaesenc	%xmm14, %xmm7, %xmm11
	vaesenc	%xmm15, %xmm5, %xmm15
	vpxor	%xmm13, %xmm10, %xmm13
	vaesenc	%xmm0, %xmm9, %xmm9
	vpxor	%xmm10, %xmm3, %xmm10
	vpxorq	%xmm3, %xmm16, %xmm3
	vmovdqa64	%xmm11, %xmm17
	vaesenc	%xmm9, %xmm15, %xmm9
	vmovdqa64	%xmm18, %xmm11
	vaesenc	%xmm0, %xmm1, %xmm1
	vaesenc	%xmm0, %xmm3, %xmm3
	vaesenc	%xmm1, %xmm11, %xmm1
	vmovdqa64	%xmm17, %xmm11
	vaesenc	%xmm3, %xmm9, %xmm3
	vaesenc	%xmm14, %xmm11, %xmm14
	vmovdqa64	%xmm3, %xmm19
	vaesenc	%xmm0, %xmm13, %xmm13
	vaesenc	%xmm0, %xmm4, %xmm4
	vpxorq	%xmm16, %xmm2, %xmm3
	vaesenc	%xmm13, %xmm14, %xmm13
	vaesenc	%xmm0, %xmm3, %xmm3
	vaesenc	%xmm3, %xmm13, %xmm3
	vaesenc	%xmm4, %xmm1, %xmm4
	vmovdqa	%xmm13, 16(%rdi)
	vmovdqa64	%xmm3, %xmm16
	vaesenc	%xmm0, %xmm10, %xmm10
	vpxor	%xmm2, %xmm8, %xmm3
	vpxor	%xmm8, %xmm6, %xmm8
	vaesenc	%xmm10, %xmm4, %xmm10
	vaesenc	%xmm0, %xmm3, %xmm3
	vaesenc	%xmm3, %xmm10, %xmm2
	vaesenc	%xmm0, %xmm8, %xmm8
	vmovdqa64	%xmm19, %xmm3
	vpxorq	%xmm0, %xmm19, %xmm19
	vaesenc	%xmm8, %xmm3, %xmm8
	vpxor	%xmm6, %xmm7, %xmm3
	vmovdqa64	%xmm16, %xmm6
	vpxorq	%xmm7, %xmm18, %xmm7
	vaesenc	%xmm0, %xmm3, %xmm3
	vpxorq	%xmm0, %xmm16, %xmm16
	vaesenc	%xmm0, %xmm7, %xmm7
	vmovdqa64	%xmm19, 48(%rdi)
	vaesenc	%xmm3, %xmm6, %xmm3
	vpxorq	%xmm18, %xmm5, %xmm6
	vaesenc	%xmm7, %xmm2, %xmm7
	vmovdqa64	%xmm16, 64(%rdi)
	vaesenc	%xmm0, %xmm6, %xmm6
	vpxorq	%xmm0, %xmm2, %xmm16
	vpxorq	%xmm5, %xmm17, %xmm5
	vpxorq	%xmm17, %xmm1, %xmm2
	vpxor	%xmm1, %xmm15, %xmm1
	vaesenc	%xmm6, %xmm8, %xmm6
	vpxor	%xmm15, %xmm14, %xmm15
	vpxor	%xmm14, %xmm4, %xmm14
	vaesenc	%xmm0, %xmm5, %xmm5
	vpxor	%xmm4, %xmm9, %xmm4
	vaesenc	%xmm0, %xmm2, %xmm2
	vpxor	%xmm0, %xmm8, %xmm8
	vaesenc	%xmm0, %xmm1, %xmm1
	vaesenc	%xmm5, %xmm3, %xmm5
	vpxor	%xmm12, %xmm9, %xmm9
	vpxorq	%xmm20, %xmm3, %xmm3
	vaesenc	%xmm2, %xmm7, %xmm2
	vaesenc	%xmm1, %xmm6, %xmm1
	vpxor	%xmm0, %xmm7, %xmm7
	vpxor	%xmm0, %xmm6, %xmm6
	vaesenc	%xmm0, %xmm15, %xmm15
	vaesenc	%xmm0, %xmm14, %xmm14
	vmovdqa64	%xmm16, 80(%rdi)
	vmovdqa	%xmm8, 96(%rdi)
	vaesenc	%xmm0, %xmm4, %xmm4
	vaesenc	%xmm15, %xmm5, %xmm15
	vpxor	%xmm0, %xmm5, %xmm5
	vmovdqa	%xmm7, 128(%rdi)
	vaesenc	%xmm14, %xmm2, %xmm14
	vaesenc	%xmm4, %xmm1, %xmm4
	vpxor	%xmm0, %xmm2, %xmm2
	vpxor	%xmm0, %xmm1, %xmm1
	vmovdqa	%xmm6, 144(%rdi)
	vmovdqa	%xmm15, 208(%rdi)
	vmovdqa	%xmm5, 160(%rdi)
	vmovdqa	%xmm14, 224(%rdi)
	vmovdqa	%xmm2, 176(%rdi)
	vmovdqa	%xmm4, 240(%rdi)
	vmovdqa	%xmm10, 32(%rdi)
	vmovdqa	%xmm1, 192(%rdi)
	vmovdqa	%xmm9, (%rdi)
	vmovdqa	%xmm3, 112(%rdi)
	ret
	.cfi_endproc
.LFE5524:
	.size	HiAE_stream_init, .-HiAE_stream_init
	.p2align 4
	.globl	HiAE_stream_proc_ad
	.type	HiAE_stream_proc_ad, @function
HiAE_stream_proc_ad:
.LFB5525:
	.cfi_startproc
	endbr64
	movq	%rdx, %r8
	andq	$-256, %r8
	je	.L9
	vmovdqa	16(%rdi), %xmm10
	vmovdqa	(%rdi), %xmm11
	movq	%rsi, %rax
	xorl	%ecx, %ecx
	vmovdqa64	208(%rdi), %xmm21
	vmovdqa	48(%rdi), %xmm14
	vmovdqa	32(%rdi), %xmm15
	vmovdqa64	224(%rdi), %xmm20
	vmovdqa	64(%rdi), %xmm6
	vmovdqa64	240(%rdi), %xmm19
	vmovdqa	80(%rdi), %xmm5
	vmovdqa	96(%rdi), %xmm4
	vmovdqa	112(%rdi), %xmm13
	vmovdqa	128(%rdi), %xmm12
	vmovdqa	144(%rdi), %xmm3
	vmovdqa	160(%rdi), %xmm2
	vmovdqa	176(%rdi), %xmm1
	vmovdqa	192(%rdi), %xmm0
	.p2align 4
	.p2align 3
.L5:
	vmovdqu	32(%rax), %xmm7
	vmovdqu	(%rax), %xmm9
	vpxor	%xmm10, %xmm11, %xmm11
	vpxor	%xmm10, %xmm15, %xmm10
	vmovdqu	16(%rax), %xmm8
	vmovdqu64	48(%rax), %xmm18
	addq	$256, %rcx
	addq	$256, %rax
	vmovdqu64	-192(%rax), %xmm17
	vmovdqu64	-176(%rax), %xmm16
	vmovdqu64	-160(%rax), %xmm31
	vmovdqu64	-144(%rax), %xmm30
	vmovdqu64	-128(%rax), %xmm29
	vmovdqu64	-112(%rax), %xmm28
	vmovdqu64	-96(%rax), %xmm27
	vmovdqu64	-80(%rax), %xmm26
	vmovdqu64	-64(%rax), %xmm25
	vmovdqu64	-48(%rax), %xmm24
	vmovdqu64	-32(%rax), %xmm23
	vmovdqu64	-16(%rax), %xmm22
	vmovdqa	%xmm7, -24(%rsp)
	vpxor	-24(%rsp), %xmm5, %xmm5
	vmovdqa64	%xmm21, %xmm7
	vpxor	%xmm9, %xmm14, %xmm14
	vaesenc	%xmm9, %xmm11, %xmm11
	vpxor	%xmm8, %xmm6, %xmm6
	vaesenc	%xmm11, %xmm7, %xmm11
	vaesenc	%xmm8, %xmm10, %xmm10
	vmovdqa64	%xmm20, %xmm7
	vpxor	%xmm14, %xmm15, %xmm15
	vaesenc	%xmm10, %xmm7, %xmm10
	vaesenc	-24(%rsp), %xmm15, %xmm15
	vmovdqa64	%xmm19, %xmm7
	vpxor	%xmm14, %xmm6, %xmm14
	vaesenc	%xmm15, %xmm7, %xmm15
	vmovdqa64	%xmm18, %xmm7
	vpxorq	%xmm18, %xmm4, %xmm4
	vpxorq	%xmm17, %xmm13, %xmm13
	vaesenc	%xmm7, %xmm14, %xmm14
	vmovdqa64	%xmm17, %xmm7
	vpxorq	%xmm16, %xmm12, %xmm12
	vpxorq	%xmm31, %xmm3, %xmm3
	vpxorq	%xmm30, %xmm2, %xmm2
	vpxorq	%xmm29, %xmm1, %xmm1
	vpxorq	%xmm28, %xmm0, %xmm0
	vpxorq	%xmm9, %xmm27, %xmm9
	vpxorq	%xmm21, %xmm9, %xmm9
	vaesenc	%xmm14, %xmm11, %xmm14
	vpxorq	%xmm8, %xmm26, %xmm8
	vpxorq	%xmm18, %xmm24, %xmm18
	vpxor	%xmm6, %xmm5, %xmm6
	vpxor	%xmm5, %xmm4, %xmm5
	vpxor	%xmm4, %xmm13, %xmm4
	vpxor	%xmm13, %xmm12, %xmm13
	vaesenc	%xmm7, %xmm6, %xmm6
	vmovdqa64	%xmm16, %xmm7
	vpxor	%xmm12, %xmm3, %xmm12
	vpxor	%xmm3, %xmm2, %xmm3
	vaesenc	%xmm7, %xmm5, %xmm5
	vmovdqa64	%xmm31, %xmm7
	vpxor	%xmm2, %xmm1, %xmm2
	vpxor	%xmm1, %xmm0, %xmm1
	vaesenc	%xmm7, %xmm4, %xmm4
	vmovdqa64	%xmm30, %xmm7
	vpxor	%xmm9, %xmm0, %xmm0
	vpxorq	%xmm20, %xmm8, %xmm8
	vaesenc	%xmm7, %xmm13, %xmm13
	vmovdqa64	%xmm29, %xmm7
	vaesenc	%xmm4, %xmm14, %xmm4
	vpxor	%xmm8, %xmm9, %xmm9
	vaesenc	%xmm7, %xmm12, %xmm12
	vmovdqa64	%xmm28, %xmm7
	vaesenc	%xmm5, %xmm15, %xmm5
	vpxorq	%xmm11, %xmm18, %xmm11
	vaesenc	%xmm7, %xmm3, %xmm3
	vmovdqa64	%xmm27, %xmm7
	vaesenc	%xmm6, %xmm10, %xmm6
	vpxorq	%xmm17, %xmm23, %xmm17
	vaesenc	%xmm7, %xmm2, %xmm2
	vmovdqa64	%xmm26, %xmm7
	vaesenc	%xmm3, %xmm4, %xmm3
	vpxorq	%xmm31, %xmm14, %xmm14
	vaesenc	%xmm7, %xmm1, %xmm1
	vmovdqa64	%xmm25, %xmm7
	vaesenc	%xmm12, %xmm5, %xmm12
	vpxorq	%xmm28, %xmm4, %xmm4
	vaesenc	%xmm7, %xmm0, %xmm0
	vpxorq	-24(%rsp), %xmm25, %xmm7
	vaesenc	%xmm13, %xmm6, %xmm13
	vpxorq	%xmm29, %xmm5, %xmm5
	vaesenc	%xmm0, %xmm3, %xmm0
	vaesenc	%xmm1, %xmm12, %xmm1
	vpxorq	%xmm26, %xmm12, %xmm12
	vmovdqa64	%xmm0, %xmm26
	vmovdqa64	%xmm24, %xmm0
	vaesenc	%xmm2, %xmm13, %xmm2
	vpxorq	%xmm30, %xmm6, %xmm6
	vaesenc	%xmm0, %xmm9, %xmm9
	vpxorq	%xmm27, %xmm13, %xmm13
	vpxorq	%xmm25, %xmm3, %xmm3
	vpxorq	%xmm10, %xmm17, %xmm10
	vaesenc	%xmm9, %xmm2, %xmm0
	vpxorq	%xmm16, %xmm22, %xmm16
	vpxorq	%xmm24, %xmm2, %xmm2
	vmovdqa	%xmm14, 48(%rdi)
	vmovdqa	%xmm0, 208(%rdi)
	vmovdqa64	%xmm0, %xmm21
	vmovdqa64	%xmm23, %xmm0
	vmovdqa	%xmm6, 64(%rdi)
	vmovdqa	%xmm5, 80(%rdi)
	vmovdqa	%xmm4, 96(%rdi)
	vmovdqa	%xmm13, 112(%rdi)
	vpxorq	%xmm15, %xmm16, %xmm15
	vmovdqa	%xmm12, 128(%rdi)
	vmovdqa	%xmm3, 144(%rdi)
	vmovdqa	%xmm11, (%rdi)
	vpxorq	%xmm19, %xmm7, %xmm7
	vmovdqa	%xmm2, 160(%rdi)
	vmovdqa	%xmm10, 16(%rdi)
	vpxor	%xmm7, %xmm8, %xmm8
	vpxor	%xmm11, %xmm7, %xmm7
	vaesenc	%xmm0, %xmm8, %xmm8
	vaesenc	%xmm8, %xmm1, %xmm0
	vpxorq	%xmm23, %xmm1, %xmm1
	vmovdqa	%xmm0, 224(%rdi)
	vmovdqa64	%xmm0, %xmm20
	vmovdqa64	%xmm22, %xmm0
	vmovdqa	%xmm1, 176(%rdi)
	vaesenc	%xmm0, %xmm7, %xmm7
	vmovdqa64	%xmm26, %xmm0
	vmovdqa	%xmm15, 32(%rdi)
	vaesenc	%xmm7, %xmm0, %xmm0
	vmovdqa64	%xmm0, %xmm19
	vmovdqa	%xmm0, 240(%rdi)
	vpxorq	%xmm22, %xmm26, %xmm0
	vmovdqa	%xmm0, 192(%rdi)
	cmpq	%rcx, %r8
	ja	.L5
.L4:
	cmpq	%rcx, %rdx
	jbe	.L12
	vmovdqa	16(%rdi), %xmm2
	vmovdqa	(%rdi), %xmm1
	vmovdqa	208(%rdi), %xmm12
	vmovdqa64	48(%rdi), %xmm18
	vmovdqa64	32(%rdi), %xmm17
	vmovdqa	64(%rdi), %xmm11
	vmovdqa	80(%rdi), %xmm10
	vmovdqa	96(%rdi), %xmm9
	vmovdqa	112(%rdi), %xmm8
	vmovdqa	128(%rdi), %xmm7
	vmovdqa	144(%rdi), %xmm6
	vmovdqa	160(%rdi), %xmm5
	vmovdqa	176(%rdi), %xmm4
	vmovdqa	192(%rdi), %xmm14
	vmovdqa	224(%rdi), %xmm3
	vmovdqa	240(%rdi), %xmm13
	jmp	.L7
	.p2align 4
	.p2align 3
.L10:
	vmovdqa64	%xmm17, %xmm2
	vmovdqa	%xmm15, %xmm13
	vmovdqa	%xmm0, %xmm14
	vmovdqa64	%xmm16, %xmm17
.L7:
	vmovdqu	(%rsi,%rcx), %xmm0
	vpxor	%xmm2, %xmm1, %xmm1
	addq	$16, %rcx
	vmovdqa	%xmm11, 48(%rdi)
	vmovdqa	%xmm10, 64(%rdi)
	vmovdqa	%xmm9, 80(%rdi)
	vmovdqa	%xmm8, 96(%rdi)
	vmovdqa	%xmm7, 112(%rdi)
	vmovdqa	%xmm6, 128(%rdi)
	vmovdqa	%xmm5, 144(%rdi)
	vmovdqa	%xmm4, 160(%rdi)
	vmovdqa	%xmm3, 208(%rdi)
	vmovdqa	%xmm2, (%rdi)
	vmovdqa64	%xmm17, 16(%rdi)
	vmovdqa	%xmm14, 176(%rdi)
	vmovdqa	%xmm13, 224(%rdi)
	vaesenc	%xmm0, %xmm1, %xmm1
	vpxorq	%xmm0, %xmm18, %xmm16
	vpxor	%xmm0, %xmm12, %xmm0
	vmovdqa64	%xmm11, %xmm18
	vaesenc	%xmm1, %xmm12, %xmm15
	vmovdqa	%xmm10, %xmm11
	vmovdqa	%xmm3, %xmm12
	vmovdqa	%xmm9, %xmm10
	vmovdqa64	%xmm16, 32(%rdi)
	vmovdqa	%xmm8, %xmm9
	vmovdqa	%xmm0, 192(%rdi)
	vmovdqa	%xmm7, %xmm8
	vmovdqa	%xmm15, 240(%rdi)
	vmovdqa	%xmm6, %xmm7
	vmovdqa	%xmm2, %xmm1
	vmovdqa	%xmm5, %xmm6
	vmovdqa	%xmm13, %xmm3
	vmovdqa	%xmm4, %xmm5
	vmovdqa	%xmm14, %xmm4
	cmpq	%rcx, %rdx
	ja	.L10
.L12:
	ret
	.p2align 4
	.p2align 3
.L9:
	xorl	%ecx, %ecx
	jmp	.L4
	.cfi_endproc
.LFE5525:
	.size	HiAE_stream_proc_ad, .-HiAE_stream_proc_ad
	.p2align 4
	.globl	HiAE_stream_finalize
	.type	HiAE_stream_finalize, @function
HiAE_stream_finalize:
.LFB5526:
	.cfi_startproc
	endbr64
	vmovq	%rsi, %xmm6
	vmovdqa	16(%rdi), %xmm7
	vmovdqa	224(%rdi), %xmm14
	vpinsrq	$1, %rdx, %xmm6, %xmm1
	vmovdqa	32(%rdi), %xmm6
	vpxor	(%rdi), %xmm7, %xmm0
	vmovdqa	96(%rdi), %xmm3
	vpxor	48(%rdi), %xmm6, %xmm12
	vmovdqa	112(%rdi), %xmm4
	vmovdqa	208(%rdi), %xmm15
	vmovdqa	240(%rdi), %xmm13
	vpxor	%xmm7, %xmm6, %xmm2
	vmovdqa	80(%rdi), %xmm6
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm2, %xmm2
	vpxor	%xmm1, %xmm12, %xmm12
	vaesenc	%xmm2, %xmm14, %xmm7
	vpxor	%xmm3, %xmm4, %xmm8
	vmovdqa	176(%rdi), %xmm2
	vaesenc	%xmm0, %xmm15, %xmm0
	vaesenc	%xmm1, %xmm8, %xmm8
	vaesenc	%xmm1, %xmm12, %xmm12
	vmovdqa64	%xmm7, %xmm17
	vmovdqa	64(%rdi), %xmm7
	vpxor	48(%rdi), %xmm7, %xmm11
	vaesenc	%xmm12, %xmm13, %xmm12
	vpxor	%xmm6, %xmm3, %xmm9
	vmovdqa	144(%rdi), %xmm3
	vaesenc	%xmm1, %xmm9, %xmm9
	vaesenc	%xmm9, %xmm12, %xmm9
	vpxor	%xmm7, %xmm6, %xmm10
	vmovdqa	128(%rdi), %xmm6
	vmovdqa64	%xmm17, %xmm7
	vaesenc	%xmm1, %xmm10, %xmm10
	vaesenc	%xmm1, %xmm11, %xmm11
	vaesenc	%xmm10, %xmm7, %xmm10
	vaesenc	%xmm11, %xmm0, %xmm11
	vaesenc	%xmm8, %xmm11, %xmm8
	vpxor	%xmm4, %xmm6, %xmm7
	vmovdqa	160(%rdi), %xmm4
	vpxor	%xmm6, %xmm3, %xmm6
	vaesenc	%xmm1, %xmm7, %xmm7
	vaesenc	%xmm1, %xmm6, %xmm6
	vaesenc	%xmm7, %xmm10, %xmm7
	vaesenc	%xmm6, %xmm9, %xmm6
	vpxor	%xmm3, %xmm4, %xmm5
	vmovdqa	192(%rdi), %xmm3
	vpxor	%xmm4, %xmm2, %xmm4
	vaesenc	%xmm1, %xmm4, %xmm4
	vaesenc	%xmm1, %xmm5, %xmm5
	vaesenc	%xmm4, %xmm7, %xmm4
	vaesenc	%xmm5, %xmm8, %xmm5
	vpxor	%xmm2, %xmm3, %xmm3
	vpxor	192(%rdi), %xmm15, %xmm2
	vpxor	%xmm15, %xmm14, %xmm15
	vpxor	%xmm14, %xmm13, %xmm14
	vaesenc	%xmm1, %xmm15, %xmm15
	vaesenc	%xmm1, %xmm3, %xmm3
	vpxor	%xmm13, %xmm0, %xmm13
	vaesenc	%xmm15, %xmm4, %xmm15
	vaesenc	%xmm1, %xmm13, %xmm13
	vmovdqa64	%xmm15, %xmm16
	vaesenc	%xmm3, %xmm6, %xmm3
	vaesenc	%xmm1, %xmm14, %xmm14
	vpxorq	%xmm0, %xmm17, %xmm15
	vaesenc	%xmm1, %xmm15, %xmm15
	vmovdqa64	%xmm16, %xmm0
	vaesenc	%xmm14, %xmm3, %xmm14
	vaesenc	%xmm15, %xmm0, %xmm15
	vpxorq	%xmm17, %xmm12, %xmm0
	vpxor	%xmm12, %xmm11, %xmm12
	vpxor	%xmm11, %xmm10, %xmm11
	vaesenc	%xmm1, %xmm12, %xmm12
	vpxor	%xmm10, %xmm9, %xmm10
	vpxor	%xmm9, %xmm8, %xmm9
	vmovdqa	%xmm15, (%rdi)
	vaesenc	%xmm1, %xmm9, %xmm9
	vaesenc	%xmm1, %xmm11, %xmm11
	vpxor	%xmm1, %xmm2, %xmm2
	vaesenc	%xmm11, %xmm15, %xmm11
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm2, %xmm2
	vaesenc	%xmm0, %xmm14, %xmm0
	vaesenc	%xmm2, %xmm5, %xmm2
	vaesenc	%xmm1, %xmm10, %xmm10
	vmovdqa	%xmm0, 16(%rdi)
	vaesenc	%xmm13, %xmm2, %xmm13
	vaesenc	%xmm10, %xmm0, %xmm10
	vpxor	%xmm15, %xmm0, %xmm0
	vaesenc	%xmm12, %xmm13, %xmm12
	vaesenc	%xmm9, %xmm12, %xmm9
	vpxor	%xmm12, %xmm0, %xmm0
	vmovdqa64	%xmm9, %xmm17
	vpxor	%xmm8, %xmm7, %xmm9
	vpxor	%xmm1, %xmm11, %xmm8
	vaesenc	%xmm1, %xmm9, %xmm9
	vpxor	%xmm8, %xmm0, %xmm0
	vmovdqa	%xmm8, 48(%rdi)
	vaesenc	%xmm9, %xmm11, %xmm9
	vpxor	%xmm7, %xmm6, %xmm11
	vpxor	%xmm1, %xmm10, %xmm7
	vaesenc	%xmm1, %xmm11, %xmm11
	vpxor	%xmm7, %xmm0, %xmm0
	vmovdqa	%xmm7, 64(%rdi)
	vaesenc	%xmm11, %xmm10, %xmm11
	vpxor	%xmm6, %xmm5, %xmm10
	vmovdqa64	%xmm17, %xmm6
	vpxor	%xmm5, %xmm4, %xmm5
	vaesenc	%xmm1, %xmm10, %xmm10
	vaesenc	%xmm1, %xmm5, %xmm5
	vpxor	%xmm4, %xmm3, %xmm4
	vpxor	%xmm3, %xmm2, %xmm3
	vaesenc	%xmm10, %xmm6, %xmm10
	vpxorq	%xmm1, %xmm17, %xmm6
	vaesenc	%xmm5, %xmm9, %xmm5
	vpxorq	%xmm2, %xmm16, %xmm2
	vpxor	%xmm1, %xmm9, %xmm9
	vaesenc	%xmm1, %xmm4, %xmm4
	vpxor	%xmm6, %xmm0, %xmm0
	vpxorq	%xmm1, %xmm5, %xmm17
	vaesenc	%xmm4, %xmm11, %xmm4
	vaesenc	%xmm1, %xmm3, %xmm3
	vpxor	%xmm1, %xmm11, %xmm11
	vpxor	%xmm9, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm2, %xmm2
	vaesenc	%xmm3, %xmm10, %xmm3
	vpxor	%xmm11, %xmm0, %xmm0
	vpxor	%xmm1, %xmm10, %xmm10
	vaesenc	%xmm2, %xmm5, %xmm2
	vpxorq	%xmm16, %xmm14, %xmm5
	vpxor	%xmm10, %xmm0, %xmm0
	vpxor	%xmm14, %xmm13, %xmm14
	vaesenc	%xmm1, %xmm5, %xmm5
	vaesenc	%xmm1, %xmm14, %xmm14
	vpxorq	%xmm17, %xmm0, %xmm0
	vpxor	%xmm13, %xmm15, %xmm13
	vaesenc	%xmm5, %xmm4, %xmm5
	vpxor	%xmm1, %xmm4, %xmm4
	vaesenc	%xmm14, %xmm3, %xmm14
	vpxor	%xmm1, %xmm3, %xmm3
	vpxor	%xmm4, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm13, %xmm13
	vpxor	%xmm1, %xmm2, %xmm1
	vmovdqa	%xmm6, 80(%rdi)
	vpxor	%xmm3, %xmm0, %xmm0
	vaesenc	%xmm13, %xmm2, %xmm13
	vmovdqa	%xmm9, 96(%rdi)
	vmovdqa	%xmm11, 112(%rdi)
	vpxor	%xmm1, %xmm0, %xmm0
	vmovdqa	%xmm10, 128(%rdi)
	vmovdqa64	%xmm17, 144(%rdi)
	vmovdqa	%xmm5, 208(%rdi)
	vpxor	%xmm5, %xmm0, %xmm0
	vmovdqa	%xmm4, 160(%rdi)
	vmovdqa	%xmm14, 224(%rdi)
	vmovdqa	%xmm3, 176(%rdi)
	vpxor	%xmm14, %xmm0, %xmm0
	vmovdqa	%xmm13, 240(%rdi)
	vmovdqa	%xmm12, 32(%rdi)
	vmovdqa	%xmm1, 192(%rdi)
	vpxor	%xmm13, %xmm0, %xmm0
	vmovdqu	%xmm0, (%rcx)
	ret
	.cfi_endproc
.LFE5526:
	.size	HiAE_stream_finalize, .-HiAE_stream_finalize
	.p2align 4
	.globl	HiAE_stream_encrypt
	.type	HiAE_stream_encrypt, @function
HiAE_stream_encrypt:
.LFB5527:
	.cfi_startproc
	endbr64
	movzbl	%cl, %r8d
	xorb	%cl, %cl
#APP
# 378 "HiAE.c" 1
	vmovdqa64 (%rdi), %xmm0;vmovdqa64 16(%rdi), %xmm1;vmovdqa64 32(%rdi), %xmm2;vmovdqa64 48(%rdi), %xmm3;vmovdqa64 64(%rdi), %xmm4;vmovdqa64 80(%rdi), %xmm5;vmovdqa64 96(%rdi), %xmm6;vmovdqa64 112(%rdi), %xmm7;vmovdqa64 128(%rdi), %xmm8;vmovdqa64 144(%rdi), %xmm9;vmovdqa64 160(%rdi), %xmm10;vmovdqa64 176(%rdi), %xmm11;vmovdqa64 192(%rdi), %xmm12;vmovdqa64 208(%rdi), %xmm13;vmovdqa64 224(%rdi), %xmm14;vmovdqa64 240(%rdi), %xmm15;movq $0, %rax;1:;cmpq %rcx, %rax;jge 2f;vmovdqu64 0(%rdx, %rax), %xmm16;vpxorq %xmm0, %xmm1, %xmm24;vaesenc %xmm16, %xmm24, %xmm24;vaesenc %xmm24, %xmm13, %xmm0;vpxorq %xmm24, %xmm9, %xmm24;vpxorq %xmm3, %xmm16, %xmm3;vpxorq %xmm13, %xmm16, %xmm13;vmovdqu64 %xmm24, 0(%rsi, %rax);vmovdqu64 16(%rdx, %rax), %xmm17;vpxorq %xmm1, %xmm2, %xmm25;vaesenc %xmm17, %xmm25, %xmm25;vaesenc %xmm25, %xmm14, %xmm1;vpxorq %xmm25, %xmm10, %xmm25;vpxorq %xmm4, %xmm17, %xmm4;vpxorq %xmm14, %xmm17, %xmm14;vmovdqu64 %xmm25, 16(%rsi, %rax);vmovdqu64 32(%rdx, %rax), %xmm18;vpxorq %xmm2, %xmm3, %xmm26;vaesenc %xmm18, %xmm26, %xmm26;vaesenc %xmm26, %xmm15, %xmm2;vpxorq %xmm26, %xmm11, %xmm26;vpxorq %xmm5, %xmm18, %xmm5;vpxorq %xmm15, %xmm18, %xmm15;vmovdqu64 %xmm26, 32(%rsi, %rax);vmovdqu64 48(%rdx, %rax), %xmm19;vpxorq %xmm3, %xmm4, %xmm27;vaesenc %xmm19, %xmm27, %xmm27;vaesenc %xmm27, %xmm0, %xmm3;vpxorq %xmm27, %xmm12, %xmm27;vpxorq %xmm6, %xmm19, %xmm6;vpxorq %xmm0, %xmm19, %xmm0;vmovdqu64 %xmm27, 48(%rsi, %rax);vmovdqu64 64(%rdx, %rax), %xmm20;vpxorq %xmm4, %xmm5, %xmm28;vaesenc %xmm20, %xmm28, %xmm28;vaesenc %xmm28, %xmm1, %xmm4;vpxorq %xmm28, %xmm13, %xmm28;vpxorq %xmm7, %xmm20, %xmm7;vpxorq %xmm1, %xmm20, %xmm1;vmovdqu64 %xmm28, 64(%rsi, %rax);vmovdqu64 80(%rdx, %rax), %xmm21;vpxorq %xmm5, %xmm6, %xmm29;vaesenc %xmm21, %xmm29, %xmm29;vaesenc %xmm29, %xmm2, %xmm5;vpxorq %xmm29, %xmm14, %xmm29;vpxorq %xmm8, %xmm21, %xmm8;vpxorq %xmm2, %xmm21, %xmm2;vmovdqu64 %xmm29, 80(%rsi, %rax);vmovdqu64 96(%rdx, %rax), %xmm22;vpxorq %xmm6, %xmm7, %xmm30;vaesenc %xmm22, %xmm30, %xmm30;vaesenc %xmm30, %xmm3, %xmm6;vpxorq %xmm30, %xmm15, %xmm30;vpxorq %xmm9, %xmm22, %xmm9;vpxorq %xmm3, %xmm22, %xmm3;vmovdqu64 %xmm30, 96(%rsi, %rax);vmovdqu64 112(%rdx, %rax), %xmm23;vpxorq %xmm7, %xmm8, %xmm31;vaesenc %xmm23, %xmm31, %xmm31;vaesenc %xmm31, %xmm4, %xmm7;vpxorq %xmm31, %xmm0, %xmm31;vpxorq %xmm10, %xmm23, %xmm10;vpxorq %xmm4, %xmm23, %xmm4;vmovdqu64 %xmm31, 112(%rsi, %rax);vmovdqa64 128(%rdx, %rax), %xmm16;vpxorq %xmm8, %xmm9, %xmm24;vaesenc %xmm16, %xmm24, %xmm24;vaesenc %xmm24, %xmm5, %xmm8;vpxorq %xmm24, %xmm1, %xmm24;vpxorq %xmm11, %xmm16, %xmm11;vpxorq %xmm5, %xmm16, %xmm5;vmovdqa64 %xmm24, 128(%rsi, %rax);vmovdqa64 144(%rdx, %rax), %xmm17;vpxorq %xmm9, %xmm10, %xmm25;vaesenc %xmm17, %xmm25, %xmm25;vaesenc %xmm25, %xmm6, %xmm9;vpxorq %xmm25, %xmm2, %xmm25;vpxorq %xmm12, %xmm17, %xmm12;vpxorq %xmm6, %xmm17, %xmm6;vmovdqa64 %xmm25, 144(%rsi, %rax);vmovdqa64 160(%rdx, %rax), %xmm18;vpxorq %xmm10, %xmm11, %xmm26;vaesenc %xmm18, %xmm26, %xmm26;vaesenc %xmm26, %xmm7, %xmm10;vpxorq %xmm26, %xmm3, %xmm26;vpxorq %xmm13, %xmm18, %xmm13;vpxorq %xmm7, %xmm18, %xmm7;vmovdqa64 %xmm26, 160(%rsi, %rax);vmovdqa64 176(%rdx, %rax), %xmm19;vpxorq %xmm11, %xmm12, %xmm27;vaesenc %xmm19, %xmm27, %xmm27;vaesenc %xmm27, %xmm8, %xmm11;vpxorq %xmm27, %xmm4, %xmm27;vpxorq %xmm14, %xmm19, %xmm14;vpxorq %xmm8, %xmm19, %xmm8;vmovdqa64 %xmm27, 176(%rsi, %rax);vmovdqa64 192(%rdx, %rax), %xmm20;vpxorq %xmm12, %xmm13, %xmm28;vaesenc %xmm20, %xmm28, %xmm28;vaesenc %xmm28, %xmm9, %xmm12;vpxorq %xmm28, %xmm5, %xmm28;vpxorq %xmm15, %xmm20, %xmm15;vpxorq %xmm9, %xmm20, %xmm9;vmovdqa64 %xmm28, 192(%rsi, %rax);vmovdqa64 208(%rdx, %rax), %xmm21;vpxorq %xmm13, %xmm14, %xmm29;vaesenc %xmm21, %xmm29, %xmm29;vaesenc %xmm29, %xmm10, %xmm13;vpxorq %xmm29, %xmm6, %xmm29;vpxorq %xmm0, %xmm21, %xmm0;vpxorq %xmm10, %xmm21, %xmm10;vmovdqa64 %xmm29, 208(%rsi, %rax);vmovdqa64 224(%rdx, %rax), %xmm22;vpxorq %xmm14, %xmm15, %xmm30;vaesenc %xmm22, %xmm30, %xmm30;vaesenc %xmm30, %xmm11, %xmm14;vpxorq %xmm30, %xmm7, %xmm30;vpxorq %xmm1, %xmm22, %xmm1;vpxorq %xmm11, %xmm22, %xmm11;vmovdqa64 %xmm30, 224(%rsi, %rax);vmovdqa64 240(%rdx, %rax), %xmm23;vpxorq %xmm15, %xmm0, %xmm31;vaesenc %xmm23, %xmm31, %xmm31;vaesenc %xmm31, %xmm12, %xmm15;vpxorq %xmm31, %xmm8, %xmm31;vpxorq %xmm2, %xmm23, %xmm2;vpxorq %xmm12, %xmm23, %xmm12;vmovdqa64 %xmm31, 240(%rsi, %rax);addq $256, %rax;jmp 1b;2:;vmovdqa64 %xmm0, (%rdi);vmovdqa64 %xmm1, 16(%rdi);vmovdqa64 %xmm2, 32(%rdi);vmovdqa64 %xmm3, 48(%rdi);vmovdqa64 %xmm4, 64(%rdi);vmovdqa64 %xmm5, 80(%rdi);vmovdqa64 %xmm6, 96(%rdi);vmovdqa64 %xmm7, 112(%rdi);vmovdqa64 %xmm8, 128(%rdi);vmovdqa64 %xmm9, 144(%rdi);vmovdqa64 %xmm10, 160(%rdi);vmovdqa64 %xmm11, 176(%rdi);vmovdqa64 %xmm12, 192(%rdi);vmovdqa64 %xmm13, 208(%rdi);vmovdqa64 %xmm14, 224(%rdi);vmovdqa64 %xmm15, 240(%rdi);
# 0 "" 2
#NO_APP
	testq	%r8, %r8
	je	.L21
	leaq	(%rdx,%rcx), %r9
	xorl	%eax, %eax
	leaq	(%rsi,%rcx), %rdx
	.p2align 4
	.p2align 3
.L16:
	vmovdqu	(%r9,%rax), %xmm1
	vmovdqa	16(%rdi), %xmm3
	vpxor	48(%rdi), %xmm1, %xmm5
	vpxor	(%rdi), %xmm3, %xmm0
	vmovdqa	208(%rdi), %xmm6
	vmovdqa	32(%rdi), %xmm7
	vmovdqa	144(%rdi), %xmm2
	vmovdqa	%xmm3, (%rdi)
	vmovdqa	112(%rdi), %xmm3
	vmovdqa	%xmm5, 32(%rdi)
	vmovdqa	64(%rdi), %xmm5
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm0, %xmm6, %xmm4
	vpxor	208(%rdi), %xmm1, %xmm1
	vmovdqa	%xmm7, 16(%rdi)
	vmovdqa	80(%rdi), %xmm6
	vpxor	%xmm2, %xmm0, %xmm0
	vmovdqa	96(%rdi), %xmm7
	vmovdqa	%xmm3, 96(%rdi)
	vmovdqa	192(%rdi), %xmm3
	vmovdqa	%xmm5, 48(%rdi)
	vmovdqa	128(%rdi), %xmm5
	vmovdqa	%xmm2, 128(%rdi)
	vmovdqa	%xmm1, 192(%rdi)
	vmovdqa	%xmm6, 64(%rdi)
	vmovdqa	224(%rdi), %xmm1
	vmovdqa	160(%rdi), %xmm6
	vmovdqa	%xmm7, 80(%rdi)
	vmovdqa	176(%rdi), %xmm7
	vmovdqa	%xmm3, 176(%rdi)
	vmovdqa	%xmm5, 112(%rdi)
	vmovdqa	240(%rdi), %xmm5
	vmovdqa	%xmm1, 208(%rdi)
	vmovdqa	%xmm6, 144(%rdi)
	vmovdqa	%xmm7, 160(%rdi)
	vmovdqa	%xmm5, 224(%rdi)
	vmovdqa	%xmm4, 240(%rdi)
	vmovdqu	%xmm0, (%rdx,%rax)
	addq	$16, %rax
	cmpq	%rax, %r8
	ja	.L16
.L21:
	vzeroupper
	ret
	.cfi_endproc
.LFE5527:
	.size	HiAE_stream_encrypt, .-HiAE_stream_encrypt
	.p2align 4
	.globl	HiAE_stream_decrypt
	.type	HiAE_stream_decrypt, @function
HiAE_stream_decrypt:
.LFB5528:
	.cfi_startproc
	endbr64
	movzbl	%cl, %r8d
	xorb	%cl, %cl
#APP
# 625 "HiAE.c" 1
	vmovdqa64 (%rdi), %xmm0;vmovdqa64 16(%rdi), %xmm1;vmovdqa64 32(%rdi), %xmm2;vmovdqa64 48(%rdi), %xmm3;vmovdqa64 64(%rdi), %xmm4;vmovdqa64 80(%rdi), %xmm5;vmovdqa64 96(%rdi), %xmm6;vmovdqa64 112(%rdi), %xmm7;vmovdqa64 128(%rdi), %xmm8;vmovdqa64 144(%rdi), %xmm9;vmovdqa64 160(%rdi), %xmm10;vmovdqa64 176(%rdi), %xmm11;vmovdqa64 192(%rdi), %xmm12;vmovdqa64 208(%rdi), %xmm13;vmovdqa64 224(%rdi), %xmm14;vmovdqa64 240(%rdi), %xmm15;movq $0, %rax;1:;cmpq %rcx, %rax;jge 2f;vmovdqu64 0(%rdx, %rax), %xmm24;vpxorq %xmm0, %xmm1, %xmm16;vpxorq %xmm24, %xmm9, %xmm24;vaesenc %xmm24, %xmm13, %xmm0;vaesenc %xmm24, %xmm16, %xmm16;vpxorq %xmm3, %xmm16, %xmm3;vpxorq %xmm13, %xmm16, %xmm13;vmovdqu64 %xmm16, 0(%rsi, %rax);vmovdqu64 16(%rdx, %rax), %xmm25;vpxorq %xmm1, %xmm2, %xmm17;vpxorq %xmm25, %xmm10, %xmm25;vaesenc %xmm25, %xmm14, %xmm1;vaesenc %xmm25, %xmm17, %xmm17;vpxorq %xmm4, %xmm17, %xmm4;vpxorq %xmm14, %xmm17, %xmm14;vmovdqu64 %xmm17, 16(%rsi, %rax);vmovdqu64 32(%rdx, %rax), %xmm26;vpxorq %xmm2, %xmm3, %xmm18;vpxorq %xmm26, %xmm11, %xmm26;vaesenc %xmm26, %xmm15, %xmm2;vaesenc %xmm26, %xmm18, %xmm18;vpxorq %xmm5, %xmm18, %xmm5;vpxorq %xmm15, %xmm18, %xmm15;vmovdqu64 %xmm18, 32(%rsi, %rax);vmovdqu64 48(%rdx, %rax), %xmm27;vpxorq %xmm3, %xmm4, %xmm19;vpxorq %xmm27, %xmm12, %xmm27;vaesenc %xmm27, %xmm0, %xmm3;vaesenc %xmm27, %xmm19, %xmm19;vpxorq %xmm6, %xmm19, %xmm6;vpxorq %xmm0, %xmm19, %xmm0;vmovdqu64 %xmm19, 48(%rsi, %rax);vmovdqu64 64(%rdx, %rax), %xmm28;vpxorq %xmm4, %xmm5, %xmm20;vpxorq %xmm28, %xmm13, %xmm28;vaesenc %xmm28, %xmm1, %xmm4;vaesenc %xmm28, %xmm20, %xmm20;vpxorq %xmm7, %xmm20, %xmm7;vpxorq %xmm1, %xmm20, %xmm1;vmovdqu64 %xmm20, 64(%rsi, %rax);vmovdqu64 80(%rdx, %rax), %xmm29;vpxorq %xmm5, %xmm6, %xmm21;vpxorq %xmm29, %xmm14, %xmm29;vaesenc %xmm29, %xmm2, %xmm5;vaesenc %xmm29, %xmm21, %xmm21;vpxorq %xmm8, %xmm21, %xmm8;vpxorq %xmm2, %xmm21, %xmm2;vmovdqu64 %xmm21, 80(%rsi, %rax);vmovdqu64 96(%rdx, %rax), %xmm30;vpxorq %xmm6, %xmm7, %xmm22;vpxorq %xmm30, %xmm15, %xmm30;vaesenc %xmm30, %xmm3, %xmm6;vaesenc %xmm30, %xmm22, %xmm22;vpxorq %xmm9, %xmm22, %xmm9;vpxorq %xmm3, %xmm22, %xmm3;vmovdqu64 %xmm22, 96(%rsi, %rax);vmovdqu64 112(%rdx, %rax), %xmm31;vpxorq %xmm7, %xmm8, %xmm23;vpxorq %xmm31, %xmm0, %xmm31;vaesenc %xmm31, %xmm4, %xmm7;vaesenc %xmm31, %xmm23, %xmm23;vpxorq %xmm10, %xmm23, %xmm10;vpxorq %xmm4, %xmm23, %xmm4;vmovdqu64 %xmm23, 112(%rsi, %rax);vmovdqu64 128(%rdx, %rax), %xmm24;vpxorq %xmm8, %xmm9, %xmm16;vpxorq %xmm24, %xmm1, %xmm24;vaesenc %xmm24, %xmm5, %xmm8;vaesenc %xmm24, %xmm16, %xmm16;vpxorq %xmm11, %xmm16, %xmm11;vpxorq %xmm5, %xmm16, %xmm5;vmovdqu64 %xmm16, 128(%rsi, %rax);vmovdqu64 144(%rdx, %rax), %xmm25;vpxorq %xmm9, %xmm10, %xmm17;vpxorq %xmm25, %xmm2, %xmm25;vaesenc %xmm25, %xmm6, %xmm9;vaesenc %xmm25, %xmm17, %xmm17;vpxorq %xmm12, %xmm17, %xmm12;vpxorq %xmm6, %xmm17, %xmm6;vmovdqu64 %xmm17, 144(%rsi, %rax);vmovdqu64 160(%rdx, %rax), %xmm26;vpxorq %xmm10, %xmm11, %xmm18;vpxorq %xmm26, %xmm3, %xmm26;vaesenc %xmm26, %xmm7, %xmm10;vaesenc %xmm26, %xmm18, %xmm18;vpxorq %xmm13, %xmm18, %xmm13;vpxorq %xmm7, %xmm18, %xmm7;vmovdqu64 %xmm18, 160(%rsi, %rax);vmovdqu64 176(%rdx, %rax), %xmm27;vpxorq %xmm11, %xmm12, %xmm19;vpxorq %xmm27, %xmm4, %xmm27;vaesenc %xmm27, %xmm8, %xmm11;vaesenc %xmm27, %xmm19, %xmm19;vpxorq %xmm14, %xmm19, %xmm14;vpxorq %xmm8, %xmm19, %xmm8;vmovdqu64 %xmm19, 176(%rsi, %rax);vmovdqu64 192(%rdx, %rax), %xmm28;vpxorq %xmm12, %xmm13, %xmm20;vpxorq %xmm28, %xmm5, %xmm28;vaesenc %xmm28, %xmm9, %xmm12;vaesenc %xmm28, %xmm20, %xmm20;vpxorq %xmm15, %xmm20, %xmm15;vpxorq %xmm9, %xmm20, %xmm9;vmovdqu64 %xmm20, 192(%rsi, %rax);vmovdqu64 208(%rdx, %rax), %xmm29;vpxorq %xmm13, %xmm14, %xmm21;vpxorq %xmm29, %xmm6, %xmm29;vaesenc %xmm29, %xmm10, %xmm13;vaesenc %xmm29, %xmm21, %xmm21;vpxorq %xmm0, %xmm21, %xmm0;vpxorq %xmm10, %xmm21, %xmm10;vmovdqu64 %xmm21, 208(%rsi, %rax);vmovdqu64 224(%rdx, %rax), %xmm30;vpxorq %xmm14, %xmm15, %xmm22;vpxorq %xmm30, %xmm7, %xmm30;vaesenc %xmm30, %xmm11, %xmm14;vaesenc %xmm30, %xmm22, %xmm22;vpxorq %xmm1, %xmm22, %xmm1;vpxorq %xmm11, %xmm22, %xmm11;vmovdqu64 %xmm22, 224(%rsi, %rax);vmovdqu64 240(%rdx, %rax), %xmm31;vpxorq %xmm15, %xmm0, %xmm23;vpxorq %xmm31, %xmm8, %xmm31;vaesenc %xmm31, %xmm12, %xmm15;vaesenc %xmm31, %xmm23, %xmm23;vpxorq %xmm2, %xmm23, %xmm2;vpxorq %xmm12, %xmm23, %xmm12;vmovdqu64 %xmm23, 240(%rsi, %rax);addq $256, %rax;jmp 1b;2:;vmovdqa64 %xmm0, (%rdi);vmovdqa64 %xmm1, 16(%rdi);vmovdqa64 %xmm2, 32(%rdi);vmovdqa64 %xmm3, 48(%rdi);vmovdqa64 %xmm4, 64(%rdi);vmovdqa64 %xmm5, 80(%rdi);vmovdqa64 %xmm6, 96(%rdi);vmovdqa64 %xmm7, 112(%rdi);vmovdqa64 %xmm8, 128(%rdi);vmovdqa64 %xmm9, 144(%rdi);vmovdqa64 %xmm10, 160(%rdi);vmovdqa64 %xmm11, 176(%rdi);vmovdqa64 %xmm12, 192(%rdi);vmovdqa64 %xmm13, 208(%rdi);vmovdqa64 %xmm14, 224(%rdi);vmovdqa64 %xmm15, 240(%rdi);
# 0 "" 2
#NO_APP
	testq	%r8, %r8
	je	.L29
	leaq	(%rdx,%rcx), %r9
	xorl	%eax, %eax
	leaq	(%rsi,%rcx), %rdx
	.p2align 4
	.p2align 3
.L24:
	vmovdqa	16(%rdi), %xmm2
	vmovdqa	144(%rdi), %xmm1
	vpxor	(%r9,%rax), %xmm1, %xmm3
	vmovdqa	208(%rdi), %xmm5
	vpxor	(%rdi), %xmm2, %xmm0
	vmovdqa	32(%rdi), %xmm6
	vmovdqa	64(%rdi), %xmm7
	vmovdqa	%xmm2, (%rdi)
	vmovdqa	128(%rdi), %xmm2
	vmovdqa	%xmm1, 128(%rdi)
	vaesenc	%xmm3, %xmm5, %xmm4
	vaesenc	%xmm3, %xmm0, %xmm0
	vmovdqa	80(%rdi), %xmm5
	vpxor	208(%rdi), %xmm0, %xmm1
	vmovdqa	%xmm6, 16(%rdi)
	vpxor	48(%rdi), %xmm0, %xmm3
	vmovdqa	%xmm7, 48(%rdi)
	vmovdqa	96(%rdi), %xmm6
	vmovdqa	112(%rdi), %xmm7
	vmovdqa	%xmm2, 112(%rdi)
	vmovdqa	240(%rdi), %xmm2
	vmovdqa	%xmm5, 64(%rdi)
	vmovdqa	160(%rdi), %xmm5
	vmovdqa	%xmm3, 32(%rdi)
	vmovdqa	%xmm6, 80(%rdi)
	vmovdqa	176(%rdi), %xmm6
	vmovdqa	%xmm7, 96(%rdi)
	vmovdqa	192(%rdi), %xmm7
	vmovdqa	%xmm1, 192(%rdi)
	vmovdqa	224(%rdi), %xmm1
	vmovdqa	%xmm5, 144(%rdi)
	vmovdqa	%xmm6, 160(%rdi)
	vmovdqa	%xmm7, 176(%rdi)
	vmovdqa	%xmm1, 208(%rdi)
	vmovdqa	%xmm2, 224(%rdi)
	vmovdqa	%xmm4, 240(%rdi)
	vmovdqu	%xmm0, (%rdx,%rax)
	addq	$16, %rax
	cmpq	%rax, %r8
	ja	.L24
.L29:
	vzeroupper
	ret
	.cfi_endproc
.LFE5528:
	.size	HiAE_stream_decrypt, .-HiAE_stream_decrypt
	.p2align 4
	.globl	HiAE_AEAD_encrypt
	.type	HiAE_AEAD_encrypt, @function
HiAE_AEAD_encrypt:
.LFB5529:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %rdx
	movq	%rcx, %rbp
	movq	%rdi, %rsi
	subq	$312, %rsp
	.cfi_def_cfa_offset 352
	movq	%r8, %r11
	movq	352(%rsp), %r10
	leaq	32(%rsp), %r14
	movq	360(%rsp), %r12
	movq	%r14, %rdi
	movq	%fs:40, %rax
	movq	%rax, 296(%rsp)
	xorl	%eax, %eax
	call	HiAE_stream_init
	movq	%r10, %rcx
	andq	$-256, %rcx
	je	.L36
	vmovdqa	160(%rsp), %xmm5
	vmovdqa	48(%rsp), %xmm15
	movq	%r9, %rax
	xorl	%edx, %edx
	vmovdqa	32(%rsp), %xmm13
	vmovdqa64	240(%rsp), %xmm29
	vmovdqa	80(%rsp), %xmm12
	vmovdqa	64(%rsp), %xmm14
	vmovdqa64	256(%rsp), %xmm28
	vmovdqa	96(%rsp), %xmm11
	vmovdqa64	272(%rsp), %xmm27
	vmovdqa	112(%rsp), %xmm10
	vmovdqa	128(%rsp), %xmm7
	vmovdqa	144(%rsp), %xmm9
	vmovdqa	176(%rsp), %xmm8
	vmovdqa	208(%rsp), %xmm4
	vmovdqa	224(%rsp), %xmm3
	vmovdqa	%xmm5, (%rsp)
	vmovdqa	192(%rsp), %xmm5
	.p2align 4
	.p2align 3
.L32:
	vmovdqu	(%rax), %xmm2
	vpxor	%xmm15, %xmm13, %xmm13
	vpxor	%xmm14, %xmm15, %xmm15
	vmovdqa64	%xmm29, %xmm0
	vmovdqu	32(%rax), %xmm6
	vmovdqu	16(%rax), %xmm1
	addq	$256, %rdx
	addq	$256, %rax
	vmovdqu64	-208(%rax), %xmm17
	vmovdqu64	-192(%rax), %xmm16
	vmovdqu64	-176(%rax), %xmm30
	vmovdqu64	-160(%rax), %xmm26
	vmovdqu64	-144(%rax), %xmm25
	vmovdqu64	-128(%rax), %xmm24
	vmovdqu64	-112(%rax), %xmm23
	vmovdqu64	-96(%rax), %xmm22
	vmovdqu64	-80(%rax), %xmm21
	vmovdqu64	-64(%rax), %xmm20
	vmovdqu64	-48(%rax), %xmm19
	vmovdqu64	-32(%rax), %xmm18
	vaesenc	%xmm2, %xmm13, %xmm13
	vpxor	%xmm2, %xmm12, %xmm12
	vmovdqu64	-16(%rax), %xmm31
	vpxor	%xmm14, %xmm12, %xmm14
	vpxor	%xmm6, %xmm10, %xmm10
	vmovdqa	%xmm6, 16(%rsp)
	vaesenc	%xmm6, %xmm14, %xmm14
	vpxorq	(%rsp), %xmm30, %xmm6
	vaesenc	%xmm13, %xmm0, %xmm13
	vmovdqa64	%xmm28, %xmm0
	vaesenc	%xmm1, %xmm15, %xmm15
	vpxor	%xmm1, %xmm11, %xmm11
	vpxorq	%xmm17, %xmm7, %xmm7
	vaesenc	%xmm15, %xmm0, %xmm15
	vmovdqa64	%xmm27, %xmm0
	vpxor	%xmm11, %xmm12, %xmm12
	vpxor	%xmm10, %xmm11, %xmm11
	vaesenc	%xmm14, %xmm0, %xmm14
	vmovdqa64	%xmm17, %xmm0
	vpxorq	%xmm16, %xmm9, %xmm9
	vpxor	%xmm7, %xmm10, %xmm10
	vaesenc	%xmm0, %xmm12, %xmm12
	vmovdqa64	%xmm16, %xmm0
	vpxor	%xmm9, %xmm7, %xmm7
	vpxorq	%xmm26, %xmm8, %xmm8
	vaesenc	%xmm0, %xmm11, %xmm11
	vmovdqa64	%xmm30, %xmm0
	vpxorq	%xmm25, %xmm5, %xmm5
	vpxorq	%xmm24, %xmm4, %xmm4
	vaesenc	%xmm0, %xmm10, %xmm10
	vmovdqa64	%xmm26, %xmm0
	vpxorq	%xmm23, %xmm3, %xmm3
	vpxorq	%xmm22, %xmm2, %xmm2
	vaesenc	%xmm0, %xmm7, %xmm7
	vmovdqa64	%xmm25, %xmm0
	vaesenc	%xmm10, %xmm14, %xmm10
	vpxorq	%xmm29, %xmm2, %xmm2
	vpxor	%xmm6, %xmm9, %xmm9
	vpxor	%xmm8, %xmm6, %xmm6
	vpxor	%xmm5, %xmm8, %xmm8
	vpxor	%xmm4, %xmm5, %xmm5
	vaesenc	%xmm0, %xmm9, %xmm9
	vmovdqa64	%xmm24, %xmm0
	vpxor	%xmm3, %xmm4, %xmm4
	vpxor	%xmm2, %xmm3, %xmm3
	vaesenc	%xmm0, %xmm6, %xmm6
	vmovdqa64	%xmm23, %xmm0
	vpxorq	%xmm21, %xmm1, %xmm1
	vpxorq	%xmm19, %xmm17, %xmm17
	vaesenc	%xmm0, %xmm8, %xmm8
	vmovdqa64	%xmm22, %xmm0
	vaesenc	%xmm6, %xmm10, %xmm6
	vpxorq	%xmm28, %xmm1, %xmm1
	vaesenc	%xmm0, %xmm5, %xmm5
	vmovdqa64	%xmm21, %xmm0
	vaesenc	%xmm11, %xmm15, %xmm11
	vpxor	%xmm1, %xmm2, %xmm2
	vaesenc	%xmm0, %xmm4, %xmm4
	vpxorq	%xmm21, %xmm6, %xmm0
	vaesenc	%xmm9, %xmm11, %xmm9
	vpxorq	%xmm18, %xmm16, %xmm16
	vmovdqa	%xmm0, (%rsp)
	vmovdqa64	%xmm20, %xmm0
	vaesenc	%xmm4, %xmm6, %xmm4
	vmovdqa64	%xmm19, %xmm6
	vaesenc	%xmm0, %xmm3, %xmm3
	vpxorq	16(%rsp), %xmm20, %xmm0
	vaesenc	%xmm5, %xmm9, %xmm5
	vpxorq	%xmm31, %xmm30, %xmm30
	vaesenc	%xmm6, %xmm2, %xmm2
	vaesenc	%xmm12, %xmm13, %xmm12
	vpxorq	%xmm13, %xmm17, %xmm13
	vaesenc	%xmm2, %xmm5, %xmm6
	vaesenc	%xmm7, %xmm12, %xmm7
	vpxorq	%xmm25, %xmm11, %xmm11
	vpxorq	%xmm26, %xmm12, %xmm12
	vmovdqa64	%xmm6, %xmm29
	vmovdqa64	%xmm18, %xmm6
	vaesenc	%xmm8, %xmm7, %xmm8
	vpxorq	%xmm24, %xmm10, %xmm10
	vaesenc	%xmm3, %xmm8, %xmm3
	vpxorq	%xmm23, %xmm7, %xmm7
	vpxorq	%xmm22, %xmm9, %xmm9
	vpxorq	%xmm20, %xmm8, %xmm8
	vpxorq	%xmm19, %xmm5, %xmm5
	vpxorq	%xmm15, %xmm16, %xmm15
	vpxorq	%xmm14, %xmm30, %xmm14
	vpxorq	%xmm27, %xmm0, %xmm0
	vpxor	%xmm0, %xmm1, %xmm1
	vpxor	%xmm13, %xmm0, %xmm0
	vaesenc	%xmm6, %xmm1, %xmm1
	vmovdqa64	%xmm31, %xmm6
	vaesenc	%xmm1, %xmm4, %xmm2
	vaesenc	%xmm6, %xmm0, %xmm0
	vpxorq	%xmm18, %xmm4, %xmm4
	vmovdqa64	%xmm2, %xmm28
	vaesenc	%xmm0, %xmm3, %xmm2
	vpxorq	%xmm31, %xmm3, %xmm3
	vmovdqa64	%xmm2, %xmm27
	cmpq	%rdx, %rcx
	ja	.L32
	vmovdqa	%xmm7, 128(%rsp)
	vmovdqa	(%rsp), %xmm7
	vmovdqa	%xmm12, 80(%rsp)
	vmovdqa	%xmm11, 96(%rsp)
	vmovdqa	%xmm10, 112(%rsp)
	vmovdqa	%xmm9, 144(%rsp)
	vmovdqa	%xmm8, 176(%rsp)
	vmovdqa64	%xmm29, 240(%rsp)
	vmovdqa	%xmm13, 32(%rsp)
	vmovdqa	%xmm5, 192(%rsp)
	vmovdqa64	%xmm28, 256(%rsp)
	vmovdqa	%xmm15, 48(%rsp)
	vmovdqa	%xmm4, 208(%rsp)
	vmovdqa	%xmm2, 272(%rsp)
	vmovdqa	%xmm14, 64(%rsp)
	vmovdqa	%xmm3, 224(%rsp)
	vmovdqa	%xmm7, 160(%rsp)
.L31:
	cmpq	%rdx, %r10
	jbe	.L33
	vmovdqa	48(%rsp), %xmm3
	vmovdqa	32(%rsp), %xmm0
	vmovdqa	240(%rsp), %xmm2
	vmovdqa	80(%rsp), %xmm4
	vmovdqa	64(%rsp), %xmm9
	vmovdqa	96(%rsp), %xmm8
	vmovdqa64	112(%rsp), %xmm18
	vmovdqa64	128(%rsp), %xmm17
	vmovdqa64	144(%rsp), %xmm16
	vmovdqa	160(%rsp), %xmm15
	vmovdqa	176(%rsp), %xmm14
	vmovdqa	192(%rsp), %xmm13
	vmovdqa	208(%rsp), %xmm12
	vmovdqa	224(%rsp), %xmm7
	vmovdqa	256(%rsp), %xmm6
	vmovdqa	272(%rsp), %xmm5
	jmp	.L34
	.p2align 4
	.p2align 3
.L37:
	vmovdqa64	%xmm18, %xmm8
	vmovdqa	%xmm10, %xmm5
	vmovdqa64	%xmm17, %xmm18
	vmovdqa64	%xmm19, %xmm6
	vmovdqa64	%xmm16, %xmm17
	vmovdqa	%xmm1, %xmm7
	vmovdqa64	%xmm15, %xmm16
	vmovdqa	%xmm11, %xmm9
	vmovdqa	%xmm14, %xmm15
	vmovdqa64	%xmm21, %xmm3
	vmovdqa	%xmm13, %xmm14
	vmovdqa	%xmm12, %xmm13
	vmovdqa64	%xmm20, %xmm12
.L34:
	vmovdqu	(%r9,%rdx), %xmm1
	vpxor	%xmm3, %xmm0, %xmm0
	addq	$16, %rdx
	vmovdqa64	%xmm9, %xmm21
	vmovdqa64	%xmm7, %xmm20
	vmovdqa64	%xmm5, %xmm19
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	%xmm1, %xmm4, %xmm11
	vpxor	%xmm1, %xmm2, %xmm1
	vmovdqa	%xmm8, %xmm4
	vaesenc	%xmm0, %xmm2, %xmm10
	vmovdqa	%xmm3, %xmm0
	vmovdqa	%xmm6, %xmm2
	cmpq	%rdx, %r10
	ja	.L37
	vmovdqa	%xmm3, 32(%rsp)
	vmovdqa	%xmm9, 48(%rsp)
	vmovdqa	%xmm11, 64(%rsp)
	vmovdqa	%xmm8, 80(%rsp)
	vmovdqa64	%xmm18, 96(%rsp)
	vmovdqa64	%xmm17, 112(%rsp)
	vmovdqa64	%xmm16, 128(%rsp)
	vmovdqa	%xmm15, 144(%rsp)
	vmovdqa	%xmm14, 160(%rsp)
	vmovdqa	%xmm13, 176(%rsp)
	vmovdqa	%xmm12, 192(%rsp)
	vmovdqa	%xmm7, 208(%rsp)
	vmovdqa	%xmm1, 224(%rsp)
	vmovdqa	%xmm6, 240(%rsp)
	vmovdqa	%xmm5, 256(%rsp)
	vmovdqa	%xmm10, 272(%rsp)
.L33:
	movq	%r11, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rsi
	movq	%r14, %rdi
	call	HiAE_stream_encrypt
	movq	%r12, %rcx
	movq	%r11, %rdx
	movq	%r10, %rsi
	call	HiAE_stream_finalize
	movq	296(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L41
	addq	$312, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L36:
	.cfi_restore_state
	xorl	%edx, %edx
	jmp	.L31
.L41:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5529:
	.size	HiAE_AEAD_encrypt, .-HiAE_AEAD_encrypt
	.p2align 4
	.globl	HiAE_AEAD_decrypt
	.type	HiAE_AEAD_decrypt, @function
HiAE_AEAD_decrypt:
.LFB5530:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %rdx
	movq	%rcx, %rbp
	movq	%rdi, %rsi
	subq	$312, %rsp
	.cfi_def_cfa_offset 352
	movq	%r8, %r11
	movq	352(%rsp), %r10
	leaq	32(%rsp), %r14
	movq	360(%rsp), %r12
	movq	%r14, %rdi
	movq	%fs:40, %rax
	movq	%rax, 296(%rsp)
	xorl	%eax, %eax
	call	HiAE_stream_init
	movq	%r10, %rcx
	andq	$-256, %rcx
	je	.L48
	vmovdqa	160(%rsp), %xmm5
	vmovdqa	48(%rsp), %xmm15
	movq	%r9, %rax
	xorl	%edx, %edx
	vmovdqa	32(%rsp), %xmm13
	vmovdqa64	240(%rsp), %xmm29
	vmovdqa	80(%rsp), %xmm12
	vmovdqa	64(%rsp), %xmm14
	vmovdqa64	256(%rsp), %xmm28
	vmovdqa	96(%rsp), %xmm11
	vmovdqa64	272(%rsp), %xmm27
	vmovdqa	112(%rsp), %xmm10
	vmovdqa	128(%rsp), %xmm7
	vmovdqa	144(%rsp), %xmm9
	vmovdqa	176(%rsp), %xmm8
	vmovdqa	208(%rsp), %xmm4
	vmovdqa	224(%rsp), %xmm3
	vmovdqa	%xmm5, (%rsp)
	vmovdqa	192(%rsp), %xmm5
	.p2align 4
	.p2align 3
.L44:
	vmovdqu	(%rax), %xmm2
	vpxor	%xmm15, %xmm13, %xmm13
	vpxor	%xmm14, %xmm15, %xmm15
	vmovdqa64	%xmm29, %xmm0
	vmovdqu	32(%rax), %xmm6
	vmovdqu	16(%rax), %xmm1
	addq	$256, %rdx
	addq	$256, %rax
	vmovdqu64	-208(%rax), %xmm17
	vmovdqu64	-192(%rax), %xmm16
	vmovdqu64	-176(%rax), %xmm30
	vmovdqu64	-160(%rax), %xmm26
	vmovdqu64	-144(%rax), %xmm25
	vmovdqu64	-128(%rax), %xmm24
	vmovdqu64	-112(%rax), %xmm23
	vmovdqu64	-96(%rax), %xmm22
	vmovdqu64	-80(%rax), %xmm21
	vmovdqu64	-64(%rax), %xmm20
	vmovdqu64	-48(%rax), %xmm19
	vmovdqu64	-32(%rax), %xmm18
	vaesenc	%xmm2, %xmm13, %xmm13
	vpxor	%xmm2, %xmm12, %xmm12
	vmovdqu64	-16(%rax), %xmm31
	vpxor	%xmm14, %xmm12, %xmm14
	vpxor	%xmm6, %xmm10, %xmm10
	vmovdqa	%xmm6, 16(%rsp)
	vaesenc	%xmm6, %xmm14, %xmm14
	vpxorq	(%rsp), %xmm30, %xmm6
	vaesenc	%xmm13, %xmm0, %xmm13
	vmovdqa64	%xmm28, %xmm0
	vaesenc	%xmm1, %xmm15, %xmm15
	vpxor	%xmm1, %xmm11, %xmm11
	vpxorq	%xmm17, %xmm7, %xmm7
	vaesenc	%xmm15, %xmm0, %xmm15
	vmovdqa64	%xmm27, %xmm0
	vpxor	%xmm11, %xmm12, %xmm12
	vpxor	%xmm10, %xmm11, %xmm11
	vaesenc	%xmm14, %xmm0, %xmm14
	vmovdqa64	%xmm17, %xmm0
	vpxorq	%xmm16, %xmm9, %xmm9
	vpxor	%xmm7, %xmm10, %xmm10
	vaesenc	%xmm0, %xmm12, %xmm12
	vmovdqa64	%xmm16, %xmm0
	vpxor	%xmm9, %xmm7, %xmm7
	vpxorq	%xmm26, %xmm8, %xmm8
	vaesenc	%xmm0, %xmm11, %xmm11
	vmovdqa64	%xmm30, %xmm0
	vpxorq	%xmm25, %xmm5, %xmm5
	vpxorq	%xmm24, %xmm4, %xmm4
	vaesenc	%xmm0, %xmm10, %xmm10
	vmovdqa64	%xmm26, %xmm0
	vpxorq	%xmm23, %xmm3, %xmm3
	vpxorq	%xmm22, %xmm2, %xmm2
	vaesenc	%xmm0, %xmm7, %xmm7
	vmovdqa64	%xmm25, %xmm0
	vaesenc	%xmm10, %xmm14, %xmm10
	vpxorq	%xmm29, %xmm2, %xmm2
	vpxor	%xmm6, %xmm9, %xmm9
	vpxor	%xmm8, %xmm6, %xmm6
	vpxor	%xmm5, %xmm8, %xmm8
	vpxor	%xmm4, %xmm5, %xmm5
	vaesenc	%xmm0, %xmm9, %xmm9
	vmovdqa64	%xmm24, %xmm0
	vpxor	%xmm3, %xmm4, %xmm4
	vpxor	%xmm2, %xmm3, %xmm3
	vaesenc	%xmm0, %xmm6, %xmm6
	vmovdqa64	%xmm23, %xmm0
	vpxorq	%xmm21, %xmm1, %xmm1
	vpxorq	%xmm19, %xmm17, %xmm17
	vaesenc	%xmm0, %xmm8, %xmm8
	vmovdqa64	%xmm22, %xmm0
	vaesenc	%xmm6, %xmm10, %xmm6
	vpxorq	%xmm28, %xmm1, %xmm1
	vaesenc	%xmm0, %xmm5, %xmm5
	vmovdqa64	%xmm21, %xmm0
	vaesenc	%xmm11, %xmm15, %xmm11
	vpxor	%xmm1, %xmm2, %xmm2
	vaesenc	%xmm0, %xmm4, %xmm4
	vpxorq	%xmm21, %xmm6, %xmm0
	vaesenc	%xmm9, %xmm11, %xmm9
	vpxorq	%xmm18, %xmm16, %xmm16
	vmovdqa	%xmm0, (%rsp)
	vmovdqa64	%xmm20, %xmm0
	vaesenc	%xmm4, %xmm6, %xmm4
	vmovdqa64	%xmm19, %xmm6
	vaesenc	%xmm0, %xmm3, %xmm3
	vpxorq	16(%rsp), %xmm20, %xmm0
	vaesenc	%xmm5, %xmm9, %xmm5
	vpxorq	%xmm31, %xmm30, %xmm30
	vaesenc	%xmm6, %xmm2, %xmm2
	vaesenc	%xmm12, %xmm13, %xmm12
	vpxorq	%xmm13, %xmm17, %xmm13
	vaesenc	%xmm2, %xmm5, %xmm6
	vaesenc	%xmm7, %xmm12, %xmm7
	vpxorq	%xmm25, %xmm11, %xmm11
	vpxorq	%xmm26, %xmm12, %xmm12
	vmovdqa64	%xmm6, %xmm29
	vmovdqa64	%xmm18, %xmm6
	vaesenc	%xmm8, %xmm7, %xmm8
	vpxorq	%xmm24, %xmm10, %xmm10
	vaesenc	%xmm3, %xmm8, %xmm3
	vpxorq	%xmm23, %xmm7, %xmm7
	vpxorq	%xmm22, %xmm9, %xmm9
	vpxorq	%xmm20, %xmm8, %xmm8
	vpxorq	%xmm19, %xmm5, %xmm5
	vpxorq	%xmm15, %xmm16, %xmm15
	vpxorq	%xmm14, %xmm30, %xmm14
	vpxorq	%xmm27, %xmm0, %xmm0
	vpxor	%xmm0, %xmm1, %xmm1
	vpxor	%xmm13, %xmm0, %xmm0
	vaesenc	%xmm6, %xmm1, %xmm1
	vmovdqa64	%xmm31, %xmm6
	vaesenc	%xmm1, %xmm4, %xmm2
	vaesenc	%xmm6, %xmm0, %xmm0
	vpxorq	%xmm18, %xmm4, %xmm4
	vmovdqa64	%xmm2, %xmm28
	vaesenc	%xmm0, %xmm3, %xmm2
	vpxorq	%xmm31, %xmm3, %xmm3
	vmovdqa64	%xmm2, %xmm27
	cmpq	%rdx, %rcx
	ja	.L44
	vmovdqa	%xmm7, 128(%rsp)
	vmovdqa	(%rsp), %xmm7
	vmovdqa	%xmm12, 80(%rsp)
	vmovdqa	%xmm11, 96(%rsp)
	vmovdqa	%xmm10, 112(%rsp)
	vmovdqa	%xmm9, 144(%rsp)
	vmovdqa	%xmm8, 176(%rsp)
	vmovdqa64	%xmm29, 240(%rsp)
	vmovdqa	%xmm13, 32(%rsp)
	vmovdqa	%xmm5, 192(%rsp)
	vmovdqa64	%xmm28, 256(%rsp)
	vmovdqa	%xmm15, 48(%rsp)
	vmovdqa	%xmm4, 208(%rsp)
	vmovdqa	%xmm2, 272(%rsp)
	vmovdqa	%xmm14, 64(%rsp)
	vmovdqa	%xmm3, 224(%rsp)
	vmovdqa	%xmm7, 160(%rsp)
.L43:
	cmpq	%rdx, %r10
	jbe	.L45
	vmovdqa	48(%rsp), %xmm3
	vmovdqa	32(%rsp), %xmm0
	vmovdqa	240(%rsp), %xmm2
	vmovdqa	80(%rsp), %xmm4
	vmovdqa	64(%rsp), %xmm9
	vmovdqa	96(%rsp), %xmm8
	vmovdqa64	112(%rsp), %xmm18
	vmovdqa64	128(%rsp), %xmm17
	vmovdqa64	144(%rsp), %xmm16
	vmovdqa	160(%rsp), %xmm15
	vmovdqa	176(%rsp), %xmm14
	vmovdqa	192(%rsp), %xmm13
	vmovdqa	208(%rsp), %xmm12
	vmovdqa	224(%rsp), %xmm7
	vmovdqa	256(%rsp), %xmm6
	vmovdqa	272(%rsp), %xmm5
	jmp	.L46
	.p2align 4
	.p2align 3
.L49:
	vmovdqa64	%xmm18, %xmm8
	vmovdqa	%xmm10, %xmm5
	vmovdqa64	%xmm17, %xmm18
	vmovdqa64	%xmm19, %xmm6
	vmovdqa64	%xmm16, %xmm17
	vmovdqa	%xmm1, %xmm7
	vmovdqa64	%xmm15, %xmm16
	vmovdqa	%xmm11, %xmm9
	vmovdqa	%xmm14, %xmm15
	vmovdqa64	%xmm21, %xmm3
	vmovdqa	%xmm13, %xmm14
	vmovdqa	%xmm12, %xmm13
	vmovdqa64	%xmm20, %xmm12
.L46:
	vmovdqu	(%r9,%rdx), %xmm1
	vpxor	%xmm3, %xmm0, %xmm0
	addq	$16, %rdx
	vmovdqa64	%xmm9, %xmm21
	vmovdqa64	%xmm7, %xmm20
	vmovdqa64	%xmm5, %xmm19
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	%xmm1, %xmm4, %xmm11
	vpxor	%xmm1, %xmm2, %xmm1
	vmovdqa	%xmm8, %xmm4
	vaesenc	%xmm0, %xmm2, %xmm10
	vmovdqa	%xmm3, %xmm0
	vmovdqa	%xmm6, %xmm2
	cmpq	%rdx, %r10
	ja	.L49
	vmovdqa	%xmm3, 32(%rsp)
	vmovdqa	%xmm9, 48(%rsp)
	vmovdqa	%xmm11, 64(%rsp)
	vmovdqa	%xmm8, 80(%rsp)
	vmovdqa64	%xmm18, 96(%rsp)
	vmovdqa64	%xmm17, 112(%rsp)
	vmovdqa64	%xmm16, 128(%rsp)
	vmovdqa	%xmm15, 144(%rsp)
	vmovdqa	%xmm14, 160(%rsp)
	vmovdqa	%xmm13, 176(%rsp)
	vmovdqa	%xmm12, 192(%rsp)
	vmovdqa	%xmm7, 208(%rsp)
	vmovdqa	%xmm1, 224(%rsp)
	vmovdqa	%xmm6, 240(%rsp)
	vmovdqa	%xmm5, 256(%rsp)
	vmovdqa	%xmm10, 272(%rsp)
.L45:
	movq	%r11, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rsi
	movq	%r14, %rdi
	call	HiAE_stream_decrypt
	movq	%r12, %rcx
	movq	%r11, %rdx
	movq	%r10, %rsi
	call	HiAE_stream_finalize
	movq	296(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L53
	addq	$312, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L48:
	.cfi_restore_state
	xorl	%edx, %edx
	jmp	.L43
.L53:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5530:
	.size	HiAE_AEAD_decrypt, .-HiAE_AEAD_decrypt
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	-8273012972482837710
	.quad	3749026652749312305
	.align 16
.LC1:
	.quad	-8015347776166231176
	.quad	-224630852427467983
	.align 16
.LC2:
	.quad	2158237019939225674
	.quad	-3970269904465067520
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
