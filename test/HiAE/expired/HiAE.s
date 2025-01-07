	.file	"HiAE.c"
	.text
	.p2align 4
	.globl	HiAE_stream_init
	.type	HiAE_stream_init, @function
HiAE_stream_init:
.LFB5524:
	.cfi_startproc
	endbr64
	vmovdqu	(%rdx), %xmm0
	vmovdqu	(%rsi), %xmm3
	vpxor	%xmm4, %xmm4, %xmm4
	xorl	%eax, %eax
	vmovdqu	16(%rsi), %xmm2
	vmovdqa	.LC0(%rip), %xmm1
	vmovdqa	%xmm4, 64(%rdi)
	vmovdqa	%xmm4, 96(%rdi)
	vmovdqa	%xmm4, 144(%rdi)
	vmovdqa	%xmm4, 224(%rdi)
	vpxor	%xmm0, %xmm3, %xmm5
	vmovdqa	%xmm0, 32(%rdi)
	vpxor	%xmm2, %xmm0, %xmm0
	vmovdqa	%xmm5, 80(%rdi)
	vmovdqa	.LC1(%rip), %xmm5
	vmovdqa	%xmm1, (%rdi)
	vmovdqa	%xmm0, 128(%rdi)
	vmovdqa	%xmm2, 16(%rdi)
	vmovdqa	%xmm1, 48(%rdi)
	vmovdqa	%xmm2, 160(%rdi)
	vmovdqa	%xmm1, 176(%rdi)
	vmovdqa	%xmm2, 208(%rdi)
	vmovdqa	.LC2(%rip), %xmm0
	vmovdqa	%xmm5, 112(%rdi)
	vmovdqa	%xmm5, 192(%rdi)
	vmovdqa	%xmm0, 240(%rdi)
	vmovdqa	%xmm1, %xmm0
	jmp	.L3
	.p2align 4
	.p2align 3
.L5:
	vmovdqa	(%rcx), %xmm0
	movq	%r8, %rax
.L3:
	leaq	1(%rax), %r8
	leaq	13(%rax), %rdx
	movq	%rax, %rsi
	addq	$3, %rax
	movq	%r8, %rcx
	andl	$15, %edx
	andl	$15, %eax
	andl	$15, %esi
	andl	$15, %ecx
	salq	$4, %rdx
	salq	$4, %rax
	salq	$4, %rsi
	salq	$4, %rcx
	addq	%rdi, %rdx
	addq	%rdi, %rax
	addq	%rdi, %rcx
	vmovdqa	(%rdx), %xmm6
	vpxor	(%rcx), %xmm0, %xmm0
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm0, %xmm6, %xmm0
	vmovdqa	%xmm0, (%rdi,%rsi)
	vpxor	(%rax), %xmm1, %xmm0
	vmovdqa	%xmm0, (%rax)
	vpxor	(%rdx), %xmm1, %xmm0
	vmovdqa	%xmm0, (%rdx)
	cmpq	$32, %r8
	jne	.L5
	vpxor	(%rdi), %xmm3, %xmm3
	vpxor	112(%rdi), %xmm2, %xmm2
	vmovdqa	%xmm3, (%rdi)
	vmovdqa	%xmm2, 112(%rdi)
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
	je	.L12
	vmovdqa64	16(%rdi), %xmm18
	vmovdqa64	(%rdi), %xmm19
	movq	%rsi, %rax
	xorl	%ecx, %ecx
	vmovdqa	208(%rdi), %xmm4
	vmovdqa	48(%rdi), %xmm12
	vmovdqa	32(%rdi), %xmm2
	vmovdqa	224(%rdi), %xmm3
	vmovdqa	64(%rdi), %xmm11
	vmovdqa	240(%rdi), %xmm1
	vmovdqa	80(%rdi), %xmm10
	vmovdqa	96(%rdi), %xmm13
	vmovdqa	112(%rdi), %xmm9
	vmovdqa	128(%rdi), %xmm8
	vmovdqa	144(%rdi), %xmm7
	vmovdqa	160(%rdi), %xmm6
	vmovdqa	176(%rdi), %xmm5
	vmovdqa	192(%rdi), %xmm0
	.p2align 4
	.p2align 3
.L8:
	vmovdqu	(%rax), %xmm14
	vpxorq	%xmm18, %xmm19, %xmm15
	addq	$256, %rcx
	addq	$256, %rax
	vaesenc	%xmm14, %xmm15, %xmm15
	vpxorq	%xmm14, %xmm12, %xmm16
	vpxorq	%xmm18, %xmm2, %xmm12
	vaesenc	%xmm15, %xmm4, %xmm15
	vpxor	%xmm14, %xmm4, %xmm4
	vmovdqa64	%xmm16, 48(%rdi)
	vpxorq	%xmm16, %xmm2, %xmm2
	vmovdqa	%xmm15, (%rdi)
	vmovdqa	%xmm4, 208(%rdi)
	vmovdqu	-240(%rax), %xmm14
	vaesenc	%xmm14, %xmm12, %xmm12
	vpxor	%xmm14, %xmm11, %xmm11
	vaesenc	%xmm12, %xmm3, %xmm12
	vpxor	%xmm14, %xmm3, %xmm3
	vmovdqa	%xmm11, 64(%rdi)
	vmovdqa	%xmm12, 16(%rdi)
	vmovdqa	%xmm3, 224(%rdi)
	vmovdqu	-224(%rax), %xmm14
	vmovdqa64	%xmm12, %xmm18
	vpxorq	%xmm16, %xmm11, %xmm12
	vaesenc	%xmm14, %xmm2, %xmm2
	vpxor	%xmm14, %xmm10, %xmm10
	vpxorq	%xmm14, %xmm1, %xmm20
	vaesenc	%xmm2, %xmm1, %xmm2
	vmovdqa	%xmm10, 80(%rdi)
	vmovdqa64	%xmm20, 240(%rdi)
	vpxor	%xmm11, %xmm10, %xmm11
	vmovdqa	%xmm2, 32(%rdi)
	vmovdqa64	%xmm18, %xmm1
	vmovdqu	-208(%rax), %xmm14
	vaesenc	%xmm14, %xmm12, %xmm12
	vpxor	%xmm14, %xmm13, %xmm13
	vaesenc	%xmm12, %xmm15, %xmm12
	vpxor	%xmm14, %xmm15, %xmm15
	vmovdqa	%xmm13, 96(%rdi)
	vpxor	%xmm10, %xmm13, %xmm10
	vmovdqa	%xmm12, 48(%rdi)
	vmovdqa	%xmm15, (%rdi)
	vmovdqu	-192(%rax), %xmm14
	vaesenc	%xmm14, %xmm11, %xmm11
	vpxor	%xmm14, %xmm9, %xmm9
	vpxorq	%xmm14, %xmm18, %xmm14
	vaesenc	%xmm11, %xmm1, %xmm11
	vmovdqa	%xmm9, 112(%rdi)
	vmovdqa	%xmm14, 16(%rdi)
	vpxor	%xmm13, %xmm9, %xmm13
	vmovdqa	%xmm11, 64(%rdi)
	vmovdqa64	%xmm11, %xmm16
	vmovdqu	-176(%rax), %xmm11
	vaesenc	%xmm11, %xmm10, %xmm10
	vpxor	%xmm11, %xmm8, %xmm8
	vaesenc	%xmm10, %xmm2, %xmm1
	vpxor	%xmm11, %xmm2, %xmm2
	vmovdqa	%xmm8, 128(%rdi)
	vpxor	%xmm9, %xmm8, %xmm9
	vmovdqa	%xmm1, 80(%rdi)
	vmovdqa	%xmm2, 32(%rdi)
	vmovdqu	-160(%rax), %xmm10
	vmovdqa64	%xmm1, %xmm18
	vmovdqa64	%xmm16, %xmm1
	vaesenc	%xmm10, %xmm13, %xmm13
	vpxor	%xmm10, %xmm7, %xmm7
	vaesenc	%xmm13, %xmm12, %xmm13
	vpxor	%xmm10, %xmm12, %xmm12
	vmovdqa	%xmm7, 144(%rdi)
	vpxor	%xmm8, %xmm7, %xmm8
	vmovdqa	%xmm13, 96(%rdi)
	vmovdqa	%xmm12, 48(%rdi)
	vmovdqu	-144(%rax), %xmm11
	vaesenc	%xmm11, %xmm9, %xmm9
	vpxor	%xmm11, %xmm6, %xmm6
	vpxorq	%xmm11, %xmm16, %xmm11
	vaesenc	%xmm9, %xmm1, %xmm1
	vmovdqa	%xmm6, 160(%rdi)
	vmovdqa	%xmm11, 64(%rdi)
	vpxor	%xmm7, %xmm6, %xmm7
	vmovdqa	%xmm1, 112(%rdi)
	vmovdqa64	%xmm1, %xmm17
	vmovdqa64	%xmm18, %xmm1
	vmovdqu	-128(%rax), %xmm10
	vaesenc	%xmm10, %xmm8, %xmm8
	vpxor	%xmm10, %xmm5, %xmm5
	vpxorq	%xmm10, %xmm18, %xmm10
	vaesenc	%xmm8, %xmm1, %xmm1
	vmovdqa	%xmm5, 176(%rdi)
	vmovdqa	%xmm10, 80(%rdi)
	vpxor	%xmm6, %xmm5, %xmm6
	vmovdqa	%xmm1, 128(%rdi)
	vmovdqu	-112(%rax), %xmm8
	vaesenc	%xmm8, %xmm7, %xmm7
	vpxor	%xmm8, %xmm0, %xmm0
	vaesenc	%xmm7, %xmm13, %xmm7
	vpxor	%xmm8, %xmm13, %xmm13
	vmovdqa	%xmm0, 192(%rdi)
	vpxor	%xmm5, %xmm0, %xmm5
	vmovdqa	%xmm7, 144(%rdi)
	vmovdqa	%xmm13, 96(%rdi)
	vmovdqu	-96(%rax), %xmm9
	vmovdqa64	%xmm7, %xmm19
	vmovdqa64	%xmm17, %xmm7
	vaesenc	%xmm9, %xmm6, %xmm6
	vpxor	%xmm4, %xmm9, %xmm4
	vpxorq	%xmm9, %xmm17, %xmm9
	vaesenc	%xmm6, %xmm7, %xmm6
	vmovdqa	%xmm4, 208(%rdi)
	vmovdqa	%xmm9, 112(%rdi)
	vpxor	%xmm4, %xmm0, %xmm0
	vmovdqa	%xmm6, 160(%rdi)
	vmovdqa64	%xmm6, %xmm18
	vmovdqu	-80(%rax), %xmm8
	vaesenc	%xmm8, %xmm5, %xmm5
	vpxor	%xmm3, %xmm8, %xmm3
	vpxor	%xmm8, %xmm1, %xmm8
	vaesenc	%xmm5, %xmm1, %xmm5
	vmovdqa	%xmm3, 224(%rdi)
	vmovdqa	%xmm8, 128(%rdi)
	vpxor	%xmm3, %xmm4, %xmm4
	vmovdqa	%xmm5, 176(%rdi)
	vmovdqa64	%xmm5, %xmm17
	vmovdqa64	%xmm19, %xmm5
	vmovdqu	-64(%rax), %xmm7
	vaesenc	%xmm7, %xmm0, %xmm0
	vpxorq	%xmm20, %xmm7, %xmm1
	vpxorq	%xmm7, %xmm19, %xmm7
	vaesenc	%xmm0, %xmm5, %xmm5
	vmovdqa	%xmm1, 240(%rdi)
	vmovdqa	%xmm7, 144(%rdi)
	vmovdqa64	%xmm18, %xmm0
	vmovdqa	%xmm5, 192(%rdi)
	vmovdqa64	%xmm5, %xmm16
	vpxor	%xmm1, %xmm3, %xmm3
	vmovdqu	-48(%rax), %xmm6
	vaesenc	%xmm6, %xmm4, %xmm4
	vpxorq	%xmm15, %xmm6, %xmm19
	vpxorq	%xmm6, %xmm18, %xmm6
	vmovdqa64	%xmm16, %xmm15
	vaesenc	%xmm4, %xmm0, %xmm4
	vmovdqa64	%xmm19, (%rdi)
	vmovdqa	%xmm6, 160(%rdi)
	vmovdqa64	%xmm17, %xmm0
	vmovdqa	%xmm4, 208(%rdi)
	vpxorq	%xmm19, %xmm1, %xmm1
	vmovdqu	-32(%rax), %xmm5
	vaesenc	%xmm5, %xmm3, %xmm3
	vpxorq	%xmm14, %xmm5, %xmm18
	vpxorq	%xmm5, %xmm17, %xmm5
	vaesenc	%xmm3, %xmm0, %xmm3
	vmovdqa64	%xmm18, 16(%rdi)
	vmovdqa	%xmm5, 176(%rdi)
	vmovdqa	%xmm3, 224(%rdi)
	vmovdqu	-16(%rax), %xmm0
	vaesenc	%xmm0, %xmm1, %xmm1
	vpxor	%xmm2, %xmm0, %xmm2
	vpxorq	%xmm0, %xmm16, %xmm0
	vaesenc	%xmm1, %xmm15, %xmm1
	vmovdqa	%xmm2, 32(%rdi)
	vmovdqa	%xmm0, 192(%rdi)
	vmovdqa	%xmm1, 240(%rdi)
	cmpq	%rcx, %r8
	ja	.L8
.L7:
	cmpq	%rcx, %rdx
	jbe	.L15
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
	jmp	.L10
	.p2align 4
	.p2align 3
.L13:
	vmovdqa64	%xmm17, %xmm2
	vmovdqa	%xmm15, %xmm13
	vmovdqa	%xmm0, %xmm14
	vmovdqa64	%xmm16, %xmm17
.L10:
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
	ja	.L13
.L15:
	ret
	.p2align 4
	.p2align 3
.L12:
	xorl	%ecx, %ecx
	jmp	.L7
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
	vmovdqa	16(%rdi), %xmm4
	vmovq	%rsi, %xmm3
	vmovdqa	224(%rdi), %xmm13
	vpinsrq	$1, %rdx, %xmm3, %xmm1
	vpxor	32(%rdi), %xmm4, %xmm2
	vmovdqa	64(%rdi), %xmm3
	vpxor	80(%rdi), %xmm3, %xmm10
	vpxor	48(%rdi), %xmm1, %xmm15
	vmovdqa	48(%rdi), %xmm7
	vmovdqa	80(%rdi), %xmm5
	vpxor	(%rdi), %xmm4, %xmm0
	vpxor	32(%rdi), %xmm15, %xmm15
	vmovdqa	208(%rdi), %xmm14
	vmovdqa	240(%rdi), %xmm12
	vpxor	64(%rdi), %xmm7, %xmm11
	vpxor	96(%rdi), %xmm5, %xmm9
	vmovdqa	112(%rdi), %xmm7
	vmovdqa	144(%rdi), %xmm3
	vpxor	128(%rdi), %xmm7, %xmm7
	vmovdqa	160(%rdi), %xmm4
	vaesenc	%xmm1, %xmm2, %xmm2
	vpxor	160(%rdi), %xmm3, %xmm5
	vpxor	176(%rdi), %xmm4, %xmm4
	vaesenc	%xmm2, %xmm13, %xmm6
	vmovdqa	128(%rdi), %xmm2
	vaesenc	%xmm1, %xmm10, %xmm10
	vmovdqa64	%xmm6, %xmm16
	vaesenc	%xmm10, %xmm6, %xmm10
	vmovdqa	96(%rdi), %xmm6
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	112(%rdi), %xmm6, %xmm8
	vpxor	144(%rdi), %xmm2, %xmm6
	vaesenc	%xmm1, %xmm15, %xmm15
	vaesenc	%xmm0, %xmm14, %xmm0
	vmovdqa	176(%rdi), %xmm2
	vaesenc	%xmm15, %xmm12, %xmm15
	vpxor	192(%rdi), %xmm2, %xmm3
	vaesenc	%xmm1, %xmm11, %xmm11
	vaesenc	%xmm1, %xmm9, %xmm9
	vaesenc	%xmm11, %xmm0, %xmm11
	vaesenc	%xmm9, %xmm15, %xmm9
	vaesenc	%xmm1, %xmm7, %xmm7
	vaesenc	%xmm1, %xmm5, %xmm5
	vaesenc	%xmm7, %xmm10, %xmm7
	vaesenc	%xmm1, %xmm4, %xmm4
	vpxor	%xmm1, %xmm10, %xmm10
	vaesenc	%xmm4, %xmm7, %xmm4
	vpxor	%xmm1, %xmm7, %xmm7
	vmovdqa	%xmm10, 64(%rdi)
	vmovdqa	%xmm7, 112(%rdi)
	vaesenc	%xmm1, %xmm8, %xmm8
	vaesenc	%xmm1, %xmm6, %xmm6
	vaesenc	%xmm8, %xmm11, %xmm8
	vaesenc	%xmm6, %xmm9, %xmm6
	vpxor	%xmm1, %xmm11, %xmm11
	vpxor	%xmm1, %xmm9, %xmm9
	vaesenc	%xmm1, %xmm3, %xmm3
	vaesenc	%xmm5, %xmm8, %xmm5
	vpxor	%xmm1, %xmm8, %xmm8
	vmovdqa	%xmm11, 48(%rdi)
	vaesenc	%xmm3, %xmm6, %xmm3
	vpxor	%xmm1, %xmm6, %xmm6
	vmovdqa	%xmm9, 80(%rdi)
	vmovdqa	%xmm8, 96(%rdi)
	vmovdqa	%xmm6, 128(%rdi)
	vpxor	192(%rdi), %xmm1, %xmm2
	vmovdqa	%xmm0, (%rdi)
	vmovdqa64	%xmm16, 16(%rdi)
	vmovdqa	%xmm15, 32(%rdi)
	vpxor	%xmm14, %xmm2, %xmm2
	vpxor	%xmm13, %xmm14, %xmm14
	vpxor	%xmm12, %xmm13, %xmm13
	vpxor	%xmm0, %xmm12, %xmm12
	vpxorq	%xmm16, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm2, %xmm2
	vaesenc	%xmm1, %xmm14, %xmm14
	vpxor	%xmm15, %xmm0, %xmm0
	vaesenc	%xmm2, %xmm5, %xmm2
	vaesenc	%xmm14, %xmm4, %xmm14
	vpxor	%xmm1, %xmm5, %xmm5
	vpxor	%xmm11, %xmm0, %xmm0
	vpxor	%xmm1, %xmm4, %xmm4
	vaesenc	%xmm1, %xmm13, %xmm13
	vmovdqa	%xmm5, 144(%rdi)
	vpxor	%xmm10, %xmm0, %xmm0
	vaesenc	%xmm13, %xmm3, %xmm13
	vpxor	%xmm1, %xmm3, %xmm3
	vmovdqa	%xmm14, 208(%rdi)
	vpxor	%xmm9, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm12, %xmm12
	vpxor	%xmm1, %xmm2, %xmm1
	vmovdqa	%xmm4, 160(%rdi)
	vpxor	%xmm8, %xmm0, %xmm0
	vaesenc	%xmm12, %xmm2, %xmm12
	vmovdqa	%xmm13, 224(%rdi)
	vmovdqa	%xmm3, 176(%rdi)
	vpxor	%xmm7, %xmm0, %xmm0
	vmovdqa	%xmm12, 240(%rdi)
	vmovdqa	%xmm1, 192(%rdi)
	vpxor	%xmm6, %xmm0, %xmm0
	vpxor	%xmm5, %xmm0, %xmm0
	vpxor	%xmm4, %xmm0, %xmm0
	vpxor	%xmm3, %xmm0, %xmm0
	vpxor	%xmm1, %xmm0, %xmm0
	vpxor	%xmm14, %xmm0, %xmm0
	vpxor	%xmm13, %xmm0, %xmm0
	vpxor	%xmm12, %xmm0, %xmm0
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
# 227 "HiAE.c" 1
	vmovdqa64 (%rdi), %xmm0;vmovdqa64 16(%rdi), %xmm1;vmovdqa64 32(%rdi), %xmm2;vmovdqa64 48(%rdi), %xmm3;vmovdqa64 64(%rdi), %xmm4;vmovdqa64 80(%rdi), %xmm5;vmovdqa64 96(%rdi), %xmm6;vmovdqa64 112(%rdi), %xmm7;vmovdqa64 128(%rdi), %xmm8;vmovdqa64 144(%rdi), %xmm9;vmovdqa64 160(%rdi), %xmm10;vmovdqa64 176(%rdi), %xmm11;vmovdqa64 192(%rdi), %xmm12;vmovdqa64 208(%rdi), %xmm13;vmovdqa64 224(%rdi), %xmm14;vmovdqa64 240(%rdi), %xmm15;movq $0, %rax;1:;cmpq %rcx, %rax;jge 2f;vmovdqu64 0(%rdx, %rax), %xmm16;vpxorq %xmm0, %xmm1, %xmm24;vaesenc %xmm16, %xmm24, %xmm24;vaesenc %xmm24, %xmm13, %xmm0;vpxorq %xmm24, %xmm9, %xmm24;vpxorq %xmm3, %xmm16, %xmm3;vpxorq %xmm13, %xmm16, %xmm13;vmovdqu64 %xmm24, 0(%rsi, %rax);vmovdqu64 16(%rdx, %rax), %xmm17;vpxorq %xmm1, %xmm2, %xmm25;vaesenc %xmm17, %xmm25, %xmm25;vaesenc %xmm25, %xmm14, %xmm1;vpxorq %xmm25, %xmm10, %xmm25;vpxorq %xmm4, %xmm17, %xmm4;vpxorq %xmm14, %xmm17, %xmm14;vmovdqu64 %xmm25, 16(%rsi, %rax);vmovdqu64 32(%rdx, %rax), %xmm18;vpxorq %xmm2, %xmm3, %xmm26;vaesenc %xmm18, %xmm26, %xmm26;vaesenc %xmm26, %xmm15, %xmm2;vpxorq %xmm26, %xmm11, %xmm26;vpxorq %xmm5, %xmm18, %xmm5;vpxorq %xmm15, %xmm18, %xmm15;vmovdqu64 %xmm26, 32(%rsi, %rax);vmovdqu64 48(%rdx, %rax), %xmm19;vpxorq %xmm3, %xmm4, %xmm27;vaesenc %xmm19, %xmm27, %xmm27;vaesenc %xmm27, %xmm0, %xmm3;vpxorq %xmm27, %xmm12, %xmm27;vpxorq %xmm6, %xmm19, %xmm6;vpxorq %xmm0, %xmm19, %xmm0;vmovdqu64 %xmm27, 48(%rsi, %rax);vmovdqu64 64(%rdx, %rax), %xmm20;vpxorq %xmm4, %xmm5, %xmm28;vaesenc %xmm20, %xmm28, %xmm28;vaesenc %xmm28, %xmm1, %xmm4;vpxorq %xmm28, %xmm13, %xmm28;vpxorq %xmm7, %xmm20, %xmm7;vpxorq %xmm1, %xmm20, %xmm1;vmovdqu64 %xmm28, 64(%rsi, %rax);vmovdqu64 80(%rdx, %rax), %xmm21;vpxorq %xmm5, %xmm6, %xmm29;vaesenc %xmm21, %xmm29, %xmm29;vaesenc %xmm29, %xmm2, %xmm5;vpxorq %xmm29, %xmm14, %xmm29;vpxorq %xmm8, %xmm21, %xmm8;vpxorq %xmm2, %xmm21, %xmm2;vmovdqu64 %xmm29, 80(%rsi, %rax);vmovdqu64 96(%rdx, %rax), %xmm22;vpxorq %xmm6, %xmm7, %xmm30;vaesenc %xmm22, %xmm30, %xmm30;vaesenc %xmm30, %xmm3, %xmm6;vpxorq %xmm30, %xmm15, %xmm30;vpxorq %xmm9, %xmm22, %xmm9;vpxorq %xmm3, %xmm22, %xmm3;vmovdqu64 %xmm30, 96(%rsi, %rax);vmovdqu64 112(%rdx, %rax), %xmm23;vpxorq %xmm7, %xmm8, %xmm31;vaesenc %xmm23, %xmm31, %xmm31;vaesenc %xmm31, %xmm4, %xmm7;vpxorq %xmm31, %xmm0, %xmm31;vpxorq %xmm10, %xmm23, %xmm10;vpxorq %xmm4, %xmm23, %xmm4;vmovdqu64 %xmm31, 112(%rsi, %rax);vmovdqa64 128(%rdx, %rax), %xmm16;vpxorq %xmm8, %xmm9, %xmm24;vaesenc %xmm16, %xmm24, %xmm24;vaesenc %xmm24, %xmm5, %xmm8;vpxorq %xmm24, %xmm1, %xmm24;vpxorq %xmm11, %xmm16, %xmm11;vpxorq %xmm5, %xmm16, %xmm5;vmovdqa64 %xmm24, 128(%rsi, %rax);vmovdqa64 144(%rdx, %rax), %xmm17;vpxorq %xmm9, %xmm10, %xmm25;vaesenc %xmm17, %xmm25, %xmm25;vaesenc %xmm25, %xmm6, %xmm9;vpxorq %xmm25, %xmm2, %xmm25;vpxorq %xmm12, %xmm17, %xmm12;vpxorq %xmm6, %xmm17, %xmm6;vmovdqa64 %xmm25, 144(%rsi, %rax);vmovdqa64 160(%rdx, %rax), %xmm18;vpxorq %xmm10, %xmm11, %xmm26;vaesenc %xmm18, %xmm26, %xmm26;vaesenc %xmm26, %xmm7, %xmm10;vpxorq %xmm26, %xmm3, %xmm26;vpxorq %xmm13, %xmm18, %xmm13;vpxorq %xmm7, %xmm18, %xmm7;vmovdqa64 %xmm26, 160(%rsi, %rax);vmovdqa64 176(%rdx, %rax), %xmm19;vpxorq %xmm11, %xmm12, %xmm27;vaesenc %xmm19, %xmm27, %xmm27;vaesenc %xmm27, %xmm8, %xmm11;vpxorq %xmm27, %xmm4, %xmm27;vpxorq %xmm14, %xmm19, %xmm14;vpxorq %xmm8, %xmm19, %xmm8;vmovdqa64 %xmm27, 176(%rsi, %rax);vmovdqa64 192(%rdx, %rax), %xmm20;vpxorq %xmm12, %xmm13, %xmm28;vaesenc %xmm20, %xmm28, %xmm28;vaesenc %xmm28, %xmm9, %xmm12;vpxorq %xmm28, %xmm5, %xmm28;vpxorq %xmm15, %xmm20, %xmm15;vpxorq %xmm9, %xmm20, %xmm9;vmovdqa64 %xmm28, 192(%rsi, %rax);vmovdqa64 208(%rdx, %rax), %xmm21;vpxorq %xmm13, %xmm14, %xmm29;vaesenc %xmm21, %xmm29, %xmm29;vaesenc %xmm29, %xmm10, %xmm13;vpxorq %xmm29, %xmm6, %xmm29;vpxorq %xmm0, %xmm21, %xmm0;vpxorq %xmm10, %xmm21, %xmm10;vmovdqa64 %xmm29, 208(%rsi, %rax);vmovdqa64 224(%rdx, %rax), %xmm22;vpxorq %xmm14, %xmm15, %xmm30;vaesenc %xmm22, %xmm30, %xmm30;vaesenc %xmm30, %xmm11, %xmm14;vpxorq %xmm30, %xmm7, %xmm30;vpxorq %xmm1, %xmm22, %xmm1;vpxorq %xmm11, %xmm22, %xmm11;vmovdqa64 %xmm30, 224(%rsi, %rax);vmovdqa64 240(%rdx, %rax), %xmm23;vpxorq %xmm15, %xmm0, %xmm31;vaesenc %xmm23, %xmm31, %xmm31;vaesenc %xmm31, %xmm12, %xmm15;vpxorq %xmm31, %xmm8, %xmm31;vpxorq %xmm2, %xmm23, %xmm2;vpxorq %xmm12, %xmm23, %xmm12;vmovdqa64 %xmm31, 240(%rsi, %rax);addq $256, %rax;jmp 1b;2:;vmovdqa64 %xmm0, (%rdi);vmovdqa64 %xmm1, 16(%rdi);vmovdqa64 %xmm2, 32(%rdi);vmovdqa64 %xmm3, 48(%rdi);vmovdqa64 %xmm4, 64(%rdi);vmovdqa64 %xmm5, 80(%rdi);vmovdqa64 %xmm6, 96(%rdi);vmovdqa64 %xmm7, 112(%rdi);vmovdqa64 %xmm8, 128(%rdi);vmovdqa64 %xmm9, 144(%rdi);vmovdqa64 %xmm10, 160(%rdi);vmovdqa64 %xmm11, 176(%rdi);vmovdqa64 %xmm12, 192(%rdi);vmovdqa64 %xmm13, 208(%rdi);vmovdqa64 %xmm14, 224(%rdi);vmovdqa64 %xmm15, 240(%rdi);
# 0 "" 2
#NO_APP
	testq	%r8, %r8
	je	.L24
	leaq	(%rdx,%rcx), %r9
	xorl	%eax, %eax
	leaq	(%rsi,%rcx), %rdx
	.p2align 4
	.p2align 3
.L19:
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
	ja	.L19
.L24:
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
	movzbl	%cl, %r10d
	andq	$-256, %rcx
	movq	%rdi, %rax
	je	.L26
	movq	%rdx, %r8
	movq	%rsi, %rdi
	xorl	%r9d, %r9d
	.p2align 4
	.p2align 3
.L27:
	vmovdqu	(%r8), %xmm6
	vmovdqa	(%rax), %xmm5
	addq	$256, %r9
	addq	$256, %r8
	vpxor	144(%rax), %xmm6, %xmm1
	vmovdqa	208(%rax), %xmm7
	addq	$256, %rdi
	vpxor	16(%rax), %xmm5, %xmm0
	vaesenc	%xmm1, %xmm7, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	48(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, (%rax)
	vmovdqa	%xmm1, 48(%rax)
	vpxor	%xmm7, %xmm0, %xmm1
	vmovdqa	%xmm1, 208(%rax)
	vmovdqu	%xmm0, -256(%rdi)
	vmovdqu	-240(%r8), %xmm5
	vmovdqa	16(%rax), %xmm4
	vpxor	160(%rax), %xmm5, %xmm1
	vmovdqa	224(%rax), %xmm6
	vpxor	32(%rax), %xmm4, %xmm0
	vaesenc	%xmm1, %xmm6, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	64(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 16(%rax)
	vmovdqa	%xmm1, 64(%rax)
	vpxor	%xmm6, %xmm0, %xmm1
	vmovdqa	%xmm1, 224(%rax)
	vmovdqu	%xmm0, -240(%rdi)
	vmovdqu	-224(%r8), %xmm4
	vmovdqa	32(%rax), %xmm7
	vpxor	176(%rax), %xmm4, %xmm1
	vmovdqa	240(%rax), %xmm5
	vpxor	48(%rax), %xmm7, %xmm0
	vaesenc	%xmm1, %xmm5, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	80(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 32(%rax)
	vmovdqa	%xmm1, 80(%rax)
	vpxor	%xmm5, %xmm0, %xmm1
	vmovdqa	%xmm1, 240(%rax)
	vmovdqu	%xmm0, -224(%rdi)
	vmovdqa	48(%rax), %xmm6
	vpxor	64(%rax), %xmm6, %xmm0
	vmovdqu	-208(%r8), %xmm7
	vpxor	192(%rax), %xmm7, %xmm1
	vmovdqa	(%rax), %xmm3
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm3, %xmm2
	vpxor	96(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 48(%rax)
	vmovdqa	%xmm1, 96(%rax)
	vpxor	%xmm3, %xmm0, %xmm1
	vmovdqa	%xmm1, (%rax)
	vmovdqu	%xmm0, -208(%rdi)
	vmovdqu	-192(%r8), %xmm5
	vmovdqa	64(%rax), %xmm4
	vpxor	208(%rax), %xmm5, %xmm1
	vmovdqa	16(%rax), %xmm6
	vpxor	80(%rax), %xmm4, %xmm0
	vaesenc	%xmm1, %xmm6, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	112(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 64(%rax)
	vmovdqa	%xmm1, 112(%rax)
	vpxor	%xmm6, %xmm0, %xmm1
	vmovdqa	%xmm1, 16(%rax)
	vmovdqu	%xmm0, -192(%rdi)
	vmovdqu	-176(%r8), %xmm3
	vmovdqa	80(%rax), %xmm7
	vpxor	224(%rax), %xmm3, %xmm1
	vmovdqa	32(%rax), %xmm4
	vpxor	96(%rax), %xmm7, %xmm0
	vaesenc	%xmm1, %xmm4, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	128(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 80(%rax)
	vmovdqa	%xmm1, 128(%rax)
	vpxor	%xmm4, %xmm0, %xmm1
	vmovdqa	%xmm1, 32(%rax)
	vmovdqu	%xmm0, -176(%rdi)
	vmovdqu	-160(%r8), %xmm6
	vmovdqa	96(%rax), %xmm5
	vpxor	240(%rax), %xmm6, %xmm1
	vpxor	112(%rax), %xmm5, %xmm0
	vmovdqa	48(%rax), %xmm7
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm7, %xmm2
	vpxor	144(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 96(%rax)
	vmovdqa	%xmm1, 144(%rax)
	vpxor	%xmm7, %xmm0, %xmm1
	vmovdqa	%xmm1, 48(%rax)
	vmovdqu	%xmm0, -160(%rdi)
	vmovdqu	-144(%r8), %xmm4
	vmovdqa	112(%rax), %xmm3
	vpxor	(%rax), %xmm4, %xmm1
	vmovdqa	64(%rax), %xmm5
	vpxor	128(%rax), %xmm3, %xmm0
	vaesenc	%xmm1, %xmm5, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	160(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 112(%rax)
	vmovdqa	%xmm1, 160(%rax)
	vpxor	%xmm5, %xmm0, %xmm1
	vmovdqa	%xmm1, 64(%rax)
	vmovdqu	%xmm0, -144(%rdi)
	vmovdqu	-128(%r8), %xmm7
	vmovdqa	128(%rax), %xmm6
	vpxor	16(%rax), %xmm7, %xmm1
	vmovdqa	80(%rax), %xmm3
	vpxor	144(%rax), %xmm6, %xmm0
	vaesenc	%xmm1, %xmm3, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	176(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 128(%rax)
	vmovdqa	%xmm1, 176(%rax)
	vpxor	%xmm3, %xmm0, %xmm1
	vmovdqa	%xmm1, 80(%rax)
	vmovdqu	%xmm0, -128(%rdi)
	vmovdqu	-112(%r8), %xmm5
	vmovdqa	144(%rax), %xmm4
	vpxor	32(%rax), %xmm5, %xmm1
	vmovdqa	96(%rax), %xmm6
	vpxor	160(%rax), %xmm4, %xmm0
	vaesenc	%xmm1, %xmm6, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vmovdqa	%xmm2, 144(%rax)
	vpxor	192(%rax), %xmm0, %xmm1
	vmovdqa	%xmm1, 192(%rax)
	vpxor	%xmm6, %xmm0, %xmm1
	vmovdqa	%xmm1, 96(%rax)
	vmovdqu	%xmm0, -112(%rdi)
	vmovdqu	-96(%r8), %xmm3
	vmovdqa	176(%rax), %xmm7
	vpxor	48(%rax), %xmm3, %xmm1
	vmovdqa	112(%rax), %xmm4
	vpxor	160(%rax), %xmm7, %xmm0
	vaesenc	%xmm1, %xmm4, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	208(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 160(%rax)
	vmovdqa	%xmm1, 208(%rax)
	vpxor	%xmm4, %xmm0, %xmm1
	vmovdqa	%xmm1, 112(%rax)
	vmovdqu	%xmm0, -96(%rdi)
	vmovdqu	-80(%r8), %xmm6
	vmovdqa	192(%rax), %xmm5
	vpxor	64(%rax), %xmm6, %xmm1
	vmovdqa	128(%rax), %xmm7
	vpxor	176(%rax), %xmm5, %xmm0
	vaesenc	%xmm1, %xmm7, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	224(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 176(%rax)
	vmovdqa	%xmm1, 224(%rax)
	vpxor	%xmm7, %xmm0, %xmm1
	vmovdqa	%xmm1, 128(%rax)
	vmovdqu	%xmm0, -80(%rdi)
	vmovdqu	-64(%r8), %xmm4
	vmovdqa	208(%rax), %xmm3
	vpxor	80(%rax), %xmm4, %xmm1
	vpxor	192(%rax), %xmm3, %xmm0
	vmovdqa	144(%rax), %xmm5
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm5, %xmm2
	vpxor	240(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 192(%rax)
	vmovdqa	%xmm1, 240(%rax)
	vpxor	%xmm5, %xmm0, %xmm1
	vmovdqa	%xmm1, 144(%rax)
	vmovdqu	%xmm0, -64(%rdi)
	vmovdqu	-48(%r8), %xmm7
	vmovdqa	224(%rax), %xmm6
	vpxor	96(%rax), %xmm7, %xmm1
	vmovdqa	160(%rax), %xmm3
	vpxor	208(%rax), %xmm6, %xmm0
	vaesenc	%xmm1, %xmm3, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 208(%rax)
	vmovdqa	%xmm1, (%rax)
	vpxor	%xmm3, %xmm0, %xmm1
	vmovdqa	%xmm1, 160(%rax)
	vmovdqu	%xmm0, -48(%rdi)
	vmovdqu	-32(%r8), %xmm5
	vmovdqa	240(%rax), %xmm4
	vpxor	112(%rax), %xmm5, %xmm1
	vpxor	224(%rax), %xmm4, %xmm0
	vmovdqa	176(%rax), %xmm6
	vaesenc	%xmm1, %xmm0, %xmm0
	vaesenc	%xmm1, %xmm6, %xmm2
	vpxor	16(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 224(%rax)
	vmovdqa	%xmm1, 16(%rax)
	vpxor	%xmm6, %xmm0, %xmm1
	vmovdqa	%xmm1, 176(%rax)
	vmovdqu	%xmm0, -32(%rdi)
	vmovdqu	-16(%r8), %xmm3
	vmovdqa	(%rax), %xmm7
	vpxor	128(%rax), %xmm3, %xmm1
	vmovdqa	192(%rax), %xmm4
	vpxor	240(%rax), %xmm7, %xmm0
	vaesenc	%xmm1, %xmm4, %xmm2
	vaesenc	%xmm1, %xmm0, %xmm0
	vpxor	32(%rax), %xmm0, %xmm1
	vmovdqa	%xmm2, 240(%rax)
	vmovdqa	%xmm1, 32(%rax)
	vpxor	%xmm4, %xmm0, %xmm1
	vmovdqa	%xmm1, 192(%rax)
	vmovdqu	%xmm0, -16(%rdi)
	cmpq	%r9, %rcx
	ja	.L27
.L26:
	testq	%r10, %r10
	je	.L38
	leaq	(%rdx,%rcx), %r8
	xorl	%edi, %edi
	leaq	(%rsi,%rcx), %rdx
	.p2align 4
	.p2align 3
.L29:
	vmovdqa	144(%rax), %xmm1
	vmovdqa	16(%rax), %xmm2
	vpxor	(%r8,%rdi), %xmm1, %xmm3
	vmovdqa	208(%rax), %xmm5
	vpxor	(%rax), %xmm2, %xmm0
	vmovdqa	32(%rax), %xmm6
	vmovdqa	64(%rax), %xmm7
	vmovdqa	%xmm2, (%rax)
	vaesenc	%xmm3, %xmm5, %xmm4
	vmovdqa	96(%rax), %xmm5
	vaesenc	%xmm3, %xmm0, %xmm0
	vpxor	48(%rax), %xmm0, %xmm3
	vmovdqa	%xmm6, 16(%rax)
	vmovdqa	112(%rax), %xmm6
	vmovdqa	%xmm7, 48(%rax)
	vmovdqa	128(%rax), %xmm7
	vmovdqa	%xmm1, 128(%rax)
	vpxor	208(%rax), %xmm0, %xmm1
	vmovdqa	%xmm3, 32(%rax)
	vmovdqa	80(%rax), %xmm3
	vmovdqa	%xmm6, 96(%rax)
	vmovdqa	%xmm5, 80(%rax)
	vmovdqa	%xmm7, 112(%rax)
	vmovdqa	176(%rax), %xmm5
	vmovdqa	192(%rax), %xmm6
	vmovdqa	224(%rax), %xmm7
	vmovdqa	%xmm1, 192(%rax)
	vmovdqa	%xmm3, 64(%rax)
	vmovdqa	160(%rax), %xmm3
	vmovdqa	%xmm5, 160(%rax)
	vmovdqa	%xmm6, 176(%rax)
	vmovdqa	%xmm7, 208(%rax)
	vmovdqa	%xmm3, 144(%rax)
	vmovdqa	240(%rax), %xmm3
	vmovdqa	%xmm3, 224(%rax)
	vmovdqa	%xmm4, 240(%rax)
	vmovdqu	%xmm0, (%rdx,%rdi)
	addq	$16, %rdi
	cmpq	%rdi, %r10
	ja	.L29
.L38:
	ret
	.cfi_endproc
.LFE5528:
	.size	HiAE_stream_decrypt, .-HiAE_stream_decrypt
	.p2align 4
	.globl	HiAE
	.type	HiAE, @function
HiAE:
.LFB5529:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rcx, %r15
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdx, %r12
	movq	%r8, %rbp
	subq	$272, %rsp
	.cfi_def_cfa_offset 320
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	movq	%r9, %r14
	movq	%rsp, %r13
	movq	%r13, %rdi
	movq	%fs:40, %rax
	movq	%rax, 264(%rsp)
	xorl	%eax, %eax
	call	HiAE_stream_init
	movq	%rbp, %rdi
	call	strlen@PLT
	movq	%rbp, %rsi
	movq	%r13, %rdi
	movq	%rax, %rdx
	call	HiAE_stream_proc_ad
	movq	%r12, %rdi
	call	strlen@PLT
	movq	%r12, %rsi
	movq	%r15, %rdx
	movq	%r13, %rdi
	movq	%rax, %rcx
	call	HiAE_stream_encrypt
	movq	%r12, %rdi
	call	strlen@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	strlen@PLT
	movq	%r14, %rcx
	movq	%r13, %rdi
	movq	%rax, %rsi
	movq	%r12, %rdx
	call	HiAE_stream_finalize
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L43
	addq	$272, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L43:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5529:
	.size	HiAE, .-HiAE
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	2498979749673536066
	.quad	-3646245387246487695
	.align 16
.LC1:
	.quad	3403399622905544885
	.quad	-4838122184753039895
	.align 16
.LC2:
	.quad	978799799573957367
	.quad	8196101218714485400
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
