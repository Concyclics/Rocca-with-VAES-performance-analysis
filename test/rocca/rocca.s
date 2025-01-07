	.file	"rocca.c"
	.text
	.p2align 4
	.type	stream_proc_ad.constprop.0.isra.0, @function
stream_proc_ad.constprop.0.isra.0:
.LFB5535:
	.cfi_startproc
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	vmovdqu	64(%rdi), %xmm2
	vmovdqu	32(%rdi), %xmm4
	vmovdqu	80(%rdi), %xmm1
	vmovdqu	(%rdi), %xmm0
	vmovdqu	48(%rdi), %xmm3
	vpxor	96(%rdi), %xmm0, %xmm7
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	vaesenc	16(%rdi), %xmm4, %xmm6
	vaesenc	48(%rdi), %xmm2, %xmm0
	vmovdqu	112(%rdi), %xmm4
	vmovdqu	16(%rdi), %xmm2
	vaesenc	64(%rdi), %xmm1, %xmm5
	vpxor	16(%rsi), %xmm3, %xmm1
	vmovdqu	(%rdi), %xmm3
	vmovdqa	%xmm0, 80(%rsp)
	vpxor	(%rsi), %xmm4, %xmm4
	vmovdqa	%xmm7, 112(%rsp)
	vmovdqa	%xmm5, 96(%rsp)
	vmovdqa	%xmm6, 48(%rsp)
	vmovdqu	%xmm6, 48(%rdi)
	vpxor	96(%rdi), %xmm2, %xmm2
	vaesenc	112(%rdi), %xmm3, %xmm3
	vmovdqa	%xmm1, 64(%rsp)
	vmovdqu	%xmm1, 64(%rdi)
	vmovdqa	%xmm3, 16(%rsp)
	vmovdqa	%xmm4, (%rsp)
	vmovdqu	%xmm4, (%rdi)
	vmovdqu	%xmm3, 16(%rdi)
	vmovdqa	%xmm2, 32(%rsp)
	vmovdqu	%xmm2, 32(%rdi)
	vmovdqu	%xmm0, 80(%rdi)
	addq	$32, 136(%rdi)
	vmovdqu	%xmm5, 96(%rdi)
	vmovdqu	%xmm7, 112(%rdi)
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L6
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L6:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5535:
	.size	stream_proc_ad.constprop.0.isra.0, .-stream_proc_ad.constprop.0.isra.0
	.p2align 4
	.globl	stream_init
	.type	stream_init, @function
stream_init:
.LFB5524:
	.cfi_startproc
	endbr64
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	vmovdqu	16(%rsi), %xmm1
	vmovdqu	(%rdx), %xmm0
	vpxor	%xmm8, %xmm8, %xmm8
	vmovdqa	.LC0(%rip), %xmm11
	vmovdqa	.LC1(%rip), %xmm10
	vmovdqa	%xmm8, %xmm6
	vmovdqu	(%rsi), %xmm7
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	movl	$20, %eax
	vpxor	%xmm0, %xmm1, %xmm2
	vmovdqa	%xmm11, %xmm9
	vmovdqa	%xmm10, %xmm3
	.p2align 4
	.p2align 3
.L8:
	vmovdqa	%xmm6, %xmm4
	vmovdqa	%xmm7, %xmm5
	decq	%rax
	vpxor	%xmm7, %xmm1, %xmm6
	vaesenc	%xmm2, %xmm8, %xmm7
	vaesenc	%xmm3, %xmm2, %xmm8
	vpxor	%xmm10, %xmm3, %xmm2
	vaesenc	%xmm0, %xmm9, %xmm3
	vpxor	%xmm5, %xmm0, %xmm9
	vaesenc	%xmm4, %xmm1, %xmm0
	vpxor	%xmm11, %xmm4, %xmm1
	jne	.L8
	vmovdqa	%xmm0, 16(%rsp)
	vmovdqu	%xmm0, 16(%rdi)
	vpxor	%xmm0, %xmm0, %xmm0
	vmovdqa	%xmm6, 112(%rsp)
	vmovdqa	%xmm7, 96(%rsp)
	vmovdqa	%xmm8, 80(%rsp)
	vmovdqa	%xmm2, 64(%rsp)
	vmovdqa	%xmm3, 48(%rsp)
	vmovdqa	%xmm9, 32(%rsp)
	vmovdqa	%xmm1, (%rsp)
	vmovdqu	%xmm1, (%rdi)
	vmovdqu	%xmm9, 32(%rdi)
	vmovdqu	%xmm3, 48(%rdi)
	vmovdqu	%xmm2, 64(%rdi)
	vmovdqu	%xmm8, 80(%rdi)
	vmovdqu	%xmm7, 96(%rdi)
	vmovdqu	%xmm6, 112(%rdi)
	vmovdqa	%xmm0, 128(%rdi)
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L13
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L13:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5524:
	.size	stream_init, .-stream_init
	.p2align 4
	.globl	stream_proc_ad
	.type	stream_proc_ad, @function
stream_proc_ad:
.LFB5525:
	.cfi_startproc
	endbr64
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	vmovdqu	(%rdi), %xmm6
	vmovdqu	16(%rdi), %xmm7
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	andq	$-32, %rdx
	vmovdqu	(%rdi), %xmm0
	vmovdqa	%xmm6, (%rsp)
	vmovdqa	%xmm7, 16(%rsp)
	vmovdqu	32(%rdi), %xmm6
	vmovdqu	48(%rdi), %xmm7
	vmovdqa	%xmm6, 32(%rsp)
	vmovdqa	%xmm7, 48(%rsp)
	vmovdqu	64(%rdi), %xmm6
	vmovdqu	80(%rdi), %xmm7
	vmovdqa	%xmm6, 64(%rsp)
	vmovdqa	%xmm7, 80(%rsp)
	vmovdqu	96(%rdi), %xmm6
	vmovdqu	112(%rdi), %xmm7
	vmovdqa	%xmm6, 96(%rsp)
	vmovdqa	%xmm7, 112(%rsp)
	je	.L18
	vmovdqa	112(%rsp), %xmm9
	vmovdqa	96(%rsp), %xmm8
	vmovdqa	64(%rsp), %xmm3
	vmovdqa	80(%rsp), %xmm7
	vmovdqa	48(%rsp), %xmm2
	vmovdqa	16(%rsp), %xmm1
	vmovdqa	32(%rsp), %xmm6
	.p2align 4
	.p2align 3
.L16:
	vmovdqa	%xmm9, %xmm4
	vmovdqa	%xmm8, %xmm5
	vpxor	%xmm8, %xmm0, %xmm9
	vaesenc	%xmm3, %xmm7, %xmm8
	vaesenc	%xmm2, %xmm3, %xmm7
	vpxor	16(%rsi,%rax), %xmm2, %xmm3
	vaesenc	%xmm1, %xmm6, %xmm2
	vpxor	%xmm5, %xmm1, %xmm6
	vaesenc	%xmm4, %xmm0, %xmm1
	vpxor	(%rsi,%rax), %xmm4, %xmm0
	addq	$32, %rax
	cmpq	%rax, %rdx
	ja	.L16
	vmovdqa	%xmm9, 112(%rsp)
	vmovdqa	%xmm8, 96(%rsp)
	vmovdqa	%xmm7, 80(%rsp)
	vmovdqa	%xmm3, 64(%rsp)
	vmovdqa	%xmm2, 48(%rsp)
	vmovdqa	%xmm6, 32(%rsp)
	vmovdqa	%xmm1, 16(%rsp)
	vmovdqa	%xmm0, (%rsp)
.L15:
	vmovdqa	(%rsp), %xmm4
	vmovdqa	16(%rsp), %xmm5
	vmovdqa	32(%rsp), %xmm6
	vmovdqa	48(%rsp), %xmm7
	vmovdqa	64(%rsp), %xmm1
	vmovdqa	80(%rsp), %xmm2
	vmovdqa	96(%rsp), %xmm3
	vmovdqa	112(%rsp), %xmm0
	addq	%rax, 136(%rdi)
	vmovdqu	%xmm4, (%rdi)
	vmovdqu	%xmm5, 16(%rdi)
	vmovdqu	%xmm6, 32(%rdi)
	vmovdqu	%xmm7, 48(%rdi)
	vmovdqu	%xmm1, 64(%rdi)
	vmovdqu	%xmm2, 80(%rdi)
	vmovdqu	%xmm3, 96(%rdi)
	vmovdqu	%xmm0, 112(%rdi)
	movq	136(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L21
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L18:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L15
.L21:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5525:
	.size	stream_proc_ad, .-stream_proc_ad
	.p2align 4
	.globl	stream_enc
	.type	stream_enc, @function
stream_enc:
.LFB5526:
	.cfi_startproc
	endbr64
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	vmovdqu	(%rdi), %xmm5
	vmovdqu	16(%rdi), %xmm6
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	vmovdqu	32(%rdi), %xmm7
	andq	$-32, %rcx
	vmovdqu	(%rdi), %xmm1
	vmovdqa	%xmm5, (%rsp)
	vmovdqa	%xmm6, 16(%rsp)
	vmovdqu	48(%rdi), %xmm5
	vmovdqu	64(%rdi), %xmm6
	vmovdqa	%xmm7, 32(%rsp)
	vmovdqu	80(%rdi), %xmm7
	vmovdqa	%xmm5, 48(%rsp)
	vmovdqa	%xmm6, 64(%rsp)
	vmovdqu	96(%rdi), %xmm5
	vmovdqu	112(%rdi), %xmm6
	vmovdqa	%xmm7, 80(%rsp)
	vmovdqa	%xmm5, 96(%rsp)
	vmovdqa	%xmm6, 112(%rsp)
	je	.L26
	vmovdqa	80(%rsp), %xmm7
	vmovdqa	16(%rsp), %xmm2
	vmovdqa	32(%rsp), %xmm5
	vmovdqa	64(%rsp), %xmm3
	vmovdqa	112(%rsp), %xmm11
	vmovdqa	96(%rsp), %xmm10
	vmovdqa	48(%rsp), %xmm6
	.p2align 4
	.p2align 3
.L24:
	vmovdqu	(%rdx,%rax), %xmm8
	vmovdqu	16(%rdx,%rax), %xmm9
	vpxor	%xmm1, %xmm3, %xmm0
	vaesenc	%xmm7, %xmm2, %xmm4
	vaesenc	%xmm5, %xmm0, %xmm0
	vpxor	%xmm8, %xmm4, %xmm4
	vpxor	%xmm9, %xmm0, %xmm0
	vmovdqu	%xmm4, (%rsi,%rax)
	vmovdqu	%xmm0, 16(%rsi,%rax)
	vmovdqa	%xmm10, %xmm4
	vmovdqa	%xmm11, %xmm0
	addq	$32, %rax
	vpxor	%xmm1, %xmm10, %xmm11
	vaesenc	%xmm3, %xmm7, %xmm10
	vaesenc	%xmm6, %xmm3, %xmm7
	vpxor	%xmm9, %xmm6, %xmm3
	vaesenc	%xmm2, %xmm5, %xmm6
	vpxor	%xmm4, %xmm2, %xmm5
	vaesenc	%xmm0, %xmm1, %xmm2
	vpxor	%xmm8, %xmm0, %xmm1
	cmpq	%rax, %rcx
	ja	.L24
	vmovdqa	%xmm11, 112(%rsp)
	vmovdqa	%xmm10, 96(%rsp)
	vmovdqa	%xmm7, 80(%rsp)
	vmovdqa	%xmm3, 64(%rsp)
	vmovdqa	%xmm6, 48(%rsp)
	vmovdqa	%xmm5, 32(%rsp)
	vmovdqa	%xmm2, 16(%rsp)
	vmovdqa	%xmm1, (%rsp)
.L23:
	vmovdqa	(%rsp), %xmm7
	vmovdqa	16(%rsp), %xmm5
	vmovdqa	32(%rsp), %xmm6
	vmovdqa	112(%rsp), %xmm2
	addq	%rax, 128(%rdi)
	vmovdqu	%xmm7, (%rdi)
	vmovdqa	48(%rsp), %xmm7
	vmovdqu	%xmm5, 16(%rdi)
	vmovdqa	64(%rsp), %xmm5
	vmovdqu	%xmm6, 32(%rdi)
	vmovdqu	%xmm2, 112(%rdi)
	vmovdqa	80(%rsp), %xmm6
	vmovdqu	%xmm7, 48(%rdi)
	vmovdqa	96(%rsp), %xmm7
	vmovdqu	%xmm5, 64(%rdi)
	vmovdqu	%xmm6, 80(%rdi)
	vmovdqu	%xmm7, 96(%rdi)
	movq	136(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L29
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L26:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L23
.L29:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5526:
	.size	stream_enc, .-stream_enc
	.p2align 4
	.globl	stream_dec
	.type	stream_dec, @function
stream_dec:
.LFB5527:
	.cfi_startproc
	endbr64
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	vmovdqu	(%rdi), %xmm5
	vmovdqu	16(%rdi), %xmm6
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	vmovdqu	32(%rdi), %xmm7
	andq	$-32, %rcx
	vmovdqu	(%rdi), %xmm2
	vmovdqa	%xmm5, (%rsp)
	vmovdqa	%xmm6, 16(%rsp)
	vmovdqu	48(%rdi), %xmm5
	vmovdqu	64(%rdi), %xmm6
	vmovdqa	%xmm7, 32(%rsp)
	vmovdqu	80(%rdi), %xmm7
	vmovdqa	%xmm5, 48(%rsp)
	vmovdqa	%xmm6, 64(%rsp)
	vmovdqu	96(%rdi), %xmm5
	vmovdqu	112(%rdi), %xmm6
	vmovdqa	%xmm7, 80(%rsp)
	vmovdqa	%xmm5, 96(%rsp)
	vmovdqa	%xmm6, 112(%rsp)
	je	.L34
	vmovdqa	80(%rsp), %xmm7
	vmovdqa	16(%rsp), %xmm3
	vmovdqa	32(%rsp), %xmm5
	vmovdqa	64(%rsp), %xmm4
	vmovdqa	112(%rsp), %xmm11
	vmovdqa	96(%rsp), %xmm10
	vmovdqa	48(%rsp), %xmm6
	.p2align 4
	.p2align 3
.L32:
	vpxor	%xmm2, %xmm4, %xmm0
	vaesenc	%xmm7, %xmm3, %xmm1
	vpxor	(%rdx,%rax), %xmm1, %xmm1
	vmovdqa	%xmm11, %xmm8
	vaesenc	%xmm5, %xmm0, %xmm0
	vpxor	16(%rdx,%rax), %xmm0, %xmm0
	vmovdqa	%xmm10, %xmm9
	vpxor	%xmm2, %xmm10, %xmm11
	vaesenc	%xmm4, %xmm7, %xmm10
	vaesenc	%xmm6, %xmm4, %xmm7
	vmovdqu	%xmm1, (%rsi,%rax)
	vmovdqu	%xmm0, 16(%rsi,%rax)
	addq	$32, %rax
	vpxor	%xmm0, %xmm6, %xmm4
	vaesenc	%xmm3, %xmm5, %xmm6
	vpxor	%xmm9, %xmm3, %xmm5
	vaesenc	%xmm8, %xmm2, %xmm3
	vpxor	%xmm1, %xmm8, %xmm2
	cmpq	%rax, %rcx
	ja	.L32
	vmovdqa	%xmm11, 112(%rsp)
	vmovdqa	%xmm10, 96(%rsp)
	vmovdqa	%xmm7, 80(%rsp)
	vmovdqa	%xmm4, 64(%rsp)
	vmovdqa	%xmm6, 48(%rsp)
	vmovdqa	%xmm5, 32(%rsp)
	vmovdqa	%xmm3, 16(%rsp)
	vmovdqa	%xmm2, (%rsp)
.L31:
	vmovdqa	(%rsp), %xmm7
	vmovdqa	16(%rsp), %xmm5
	vmovdqa	32(%rsp), %xmm6
	vmovdqa	112(%rsp), %xmm3
	addq	%rax, 128(%rdi)
	vmovdqu	%xmm7, (%rdi)
	vmovdqa	48(%rsp), %xmm7
	vmovdqu	%xmm5, 16(%rdi)
	vmovdqa	64(%rsp), %xmm5
	vmovdqu	%xmm6, 32(%rdi)
	vmovdqu	%xmm3, 112(%rdi)
	vmovdqa	80(%rsp), %xmm6
	vmovdqu	%xmm7, 48(%rdi)
	vmovdqa	96(%rsp), %xmm7
	vmovdqu	%xmm5, 64(%rdi)
	vmovdqu	%xmm6, 80(%rdi)
	vmovdqu	%xmm7, 96(%rdi)
	movq	136(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L37
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L34:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L31
.L37:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5527:
	.size	stream_dec, .-stream_dec
	.p2align 4
	.globl	stream_finalize
	.type	stream_finalize, @function
stream_finalize:
.LFB5528:
	.cfi_startproc
	endbr64
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	movq	136(%rdi), %rdx
	vmovdqu	(%rdi), %xmm3
	vmovdqu	16(%rdi), %xmm0
	vmovdqu	32(%rdi), %xmm9
	vmovdqu	48(%rdi), %xmm2
	vmovdqu	64(%rdi), %xmm1
	vmovdqu	80(%rdi), %xmm8
	vmovdqu	96(%rdi), %xmm7
	vmovdqu	112(%rdi), %xmm6
	leal	0(,%rdx,8), %ecx
	salq	$3, %rdx
	movq	%fs:40, %rax
	movq	%rax, 136(%rsp)
	xorl	%eax, %eax
	movq	128(%rdi), %rax
	vmovd	%ecx, %xmm11
	shrq	$32, %rdx
	vpinsrd	$1, %edx, %xmm11, %xmm11
	vmovdqa	%xmm3, (%rsp)
	vmovq	%xmm11, %xmm11
	vmovdqa	%xmm0, 16(%rsp)
	vmovdqa	%xmm9, 32(%rsp)
	leal	0(,%rax,8), %ecx
	salq	$3, %rax
	vmovdqa	%xmm2, 48(%rsp)
	vmovdqa	%xmm1, 64(%rsp)
	shrq	$32, %rax
	vmovd	%ecx, %xmm10
	vmovdqa	%xmm8, 80(%rsp)
	vmovdqa	%xmm7, 96(%rsp)
	vpinsrd	$1, %eax, %xmm10, %xmm10
	vmovdqa	%xmm6, 112(%rsp)
	movl	$20, %eax
	vmovq	%xmm10, %xmm10
	.p2align 4
	.p2align 3
.L39:
	vmovdqa	%xmm6, %xmm4
	vmovdqa	%xmm7, %xmm5
	decq	%rax
	vpxor	%xmm7, %xmm3, %xmm6
	vaesenc	%xmm1, %xmm8, %xmm7
	vaesenc	%xmm2, %xmm1, %xmm8
	vpxor	%xmm10, %xmm2, %xmm1
	vaesenc	%xmm0, %xmm9, %xmm2
	vpxor	%xmm5, %xmm0, %xmm9
	vaesenc	%xmm4, %xmm3, %xmm0
	vpxor	%xmm11, %xmm4, %xmm3
	jne	.L39
	vpxor	%xmm3, %xmm0, %xmm0
	vpxor	%xmm9, %xmm0, %xmm0
	vpxor	%xmm2, %xmm0, %xmm0
	vpxor	%xmm1, %xmm0, %xmm0
	vpxor	%xmm8, %xmm0, %xmm0
	vpxor	%xmm7, %xmm0, %xmm0
	vpxor	%xmm6, %xmm0, %xmm0
	vmovdqa	%xmm0, (%rsi)
	movq	136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L44
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L44:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5528:
	.size	stream_finalize, .-stream_finalize
	.p2align 4
	.globl	speed_test_encode_work
	.type	speed_test_encode_work, @function
speed_test_encode_work:
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
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	movslq	%ebx, %r15
	movl	%esi, 12(%rsp)
	movq	%rdi, 40(%rsp)
	movl	$32, %edi
	leaq	48(%rsp), %rbx
	movq	%fs:40, %rax
	movq	%rax, 200(%rsp)
	xorl	%eax, %eax
	call	malloc@PLT
	movl	$16, %edi
	movq	%rax, %rbp
	call	malloc@PLT
	movl	$32, %edi
	movq	%rax, %r12
	call	malloc@PLT
	movq	%r15, %rdi
	movq	%rax, 16(%rsp)
	call	malloc@PLT
	movq	%r15, %rdi
	movq	%rax, %r14
	call	malloc@PLT
	movl	$16, %edi
	movq	%rax, %r13
	call	malloc@PLT
	vmovdqa	.LC6(%rip), %xmm0
	movq	%r15, %rdx
	movq	%rax, 24(%rsp)
	movq	16(%rsp), %rax
	movl	$1, %esi
	movq	%r14, %rdi
	vmovdqu	%xmm0, 0(%rbp)
	vmovdqu	%xmm0, 16(%rbp)
	vmovdqa	.LC7(%rip), %xmm0
	vmovdqu	%xmm0, (%rax)
	vmovdqu	%xmm0, 16(%rax)
	vmovdqu	%xmm0, (%r12)
	call	memset@PLT
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	stream_init
	movq	16(%rsp), %rsi
	movq	%rbx, %rdi
	call	stream_proc_ad.constprop.0.isra.0
	cmpl	$1, 12(%rsp)
	je	.L55
	call	clock@PLT
	movl	$65536, 12(%rsp)
	movq	%rax, 32(%rsp)
	.p2align 4
	.p2align 3
.L49:
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	stream_init
	movq	%r15, %rcx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	stream_enc
	decl	12(%rsp)
	jne	.L49
.L54:
	call	clock@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	movzbl	-1(%r13,%r15), %eax
	xorb	res(%rip), %al
	movb	%al, res(%rip)
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	16(%rsp), %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	24(%rsp), %rdi
	call	free@PLT
	subq	32(%rsp), %rbx
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtsi2sdl	40(%rsp), %xmm1, %xmm0
	vmulsd	.LC2(%rip), %xmm0, %xmm0
	movq	200(%rsp), %rax
	subq	%fs:40, %rax
	vmulsd	.LC3(%rip), %xmm0, %xmm0
	vcvtsi2ssq	%rbx, %xmm1, %xmm1
	vdivss	.LC4(%rip), %xmm1, %xmm1
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vdivsd	.LC5(%rip), %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	jne	.L56
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
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
.L55:
	.cfi_restore_state
	call	clock@PLT
	movl	$65536, 12(%rsp)
	movq	%rax, 32(%rsp)
	.p2align 4
	.p2align 3
.L47:
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	stream_init
	movq	16(%rsp), %rsi
	movq	%rbx, %rdi
	call	stream_proc_ad.constprop.0.isra.0
	movq	%r15, %rcx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	stream_enc
	movq	24(%rsp), %rsi
	movq	%rbx, %rdi
	call	stream_finalize
	decl	12(%rsp)
	jne	.L47
	jmp	.L54
.L56:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5529:
	.size	speed_test_encode_work, .-speed_test_encode_work
	.p2align 4
	.globl	speed_test_decode_work
	.type	speed_test_decode_work, @function
speed_test_decode_work:
.LFB5530:
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
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	movslq	%ebx, %r15
	movl	%esi, 12(%rsp)
	movq	%rdi, 40(%rsp)
	movl	$32, %edi
	leaq	48(%rsp), %rbx
	movq	%fs:40, %rax
	movq	%rax, 200(%rsp)
	xorl	%eax, %eax
	call	malloc@PLT
	movl	$16, %edi
	movq	%rax, %rbp
	call	malloc@PLT
	movl	$32, %edi
	movq	%rax, %r12
	call	malloc@PLT
	movq	%r15, %rdi
	movq	%rax, 16(%rsp)
	call	malloc@PLT
	movq	%r15, %rdi
	movq	%rax, %r14
	call	malloc@PLT
	movl	$16, %edi
	movq	%rax, %r13
	call	malloc@PLT
	vmovdqa	.LC6(%rip), %xmm0
	movq	%r15, %rdx
	movq	%rax, 24(%rsp)
	movq	16(%rsp), %rax
	movl	$1, %esi
	movq	%r14, %rdi
	vmovdqu	%xmm0, 0(%rbp)
	vmovdqu	%xmm0, 16(%rbp)
	vmovdqa	.LC7(%rip), %xmm0
	vmovdqu	%xmm0, (%rax)
	vmovdqu	%xmm0, 16(%rax)
	vmovdqu	%xmm0, (%r12)
	call	memset@PLT
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	stream_init
	movq	16(%rsp), %rsi
	movq	%rbx, %rdi
	call	stream_proc_ad.constprop.0.isra.0
	cmpl	$1, 12(%rsp)
	je	.L67
	call	clock@PLT
	movl	$65536, 12(%rsp)
	movq	%rax, 32(%rsp)
	.p2align 4
	.p2align 3
.L61:
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	stream_init
	movq	%r15, %rcx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	stream_dec
	decl	12(%rsp)
	jne	.L61
.L66:
	call	clock@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	movzbl	-1(%r13,%r15), %eax
	xorb	res(%rip), %al
	movb	%al, res(%rip)
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	16(%rsp), %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	24(%rsp), %rdi
	call	free@PLT
	subq	32(%rsp), %rbx
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtsi2sdl	40(%rsp), %xmm1, %xmm0
	vmulsd	.LC2(%rip), %xmm0, %xmm0
	movq	200(%rsp), %rax
	subq	%fs:40, %rax
	vmulsd	.LC3(%rip), %xmm0, %xmm0
	vcvtsi2ssq	%rbx, %xmm1, %xmm1
	vdivss	.LC4(%rip), %xmm1, %xmm1
	vcvtss2sd	%xmm1, %xmm1, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vdivsd	.LC5(%rip), %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	jne	.L68
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
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
.L67:
	.cfi_restore_state
	call	clock@PLT
	movl	$65536, 12(%rsp)
	movq	%rax, 32(%rsp)
	.p2align 4
	.p2align 3
.L59:
	movq	%r12, %rdx
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	stream_init
	movq	16(%rsp), %rsi
	movq	%rbx, %rdi
	call	stream_proc_ad.constprop.0.isra.0
	movq	%r15, %rcx
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	stream_dec
	movq	24(%rsp), %rsi
	movq	%rbx, %rdi
	call	stream_finalize
	decl	12(%rsp)
	jne	.L59
	jmp	.L66
.L68:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5530:
	.size	speed_test_decode_work, .-speed_test_decode_work
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC11:
	.string	"--------speed test Encryption Only(Gbps)----------"
	.align 8
.LC12:
	.string	"length: %d, encrypt: %.2f, decrypt: %.2f\n"
	.text
	.p2align 4
	.globl	speed_test
	.type	speed_test, @function
speed_test:
.LFB5531:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	leaq	.LC11(%rip), %rdi
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	pushq	%rbx
	subq	$200, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	vmovdqa64	.LC10(%rip), %zmm0
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	movq	$16384, -112(%rbp)
	vmovdqa64	%zmm0, -176(%rbp)
	vzeroupper
	leaq	.LC12(%rip), %r13
	call	puts@PLT
	leaq	-176(%rbp), %rbx
	leaq	-104(%rbp), %r14
	.p2align 4
	.p2align 3
.L70:
	movq	(%rbx), %r12
	xorl	%esi, %esi
	addq	$8, %rbx
	movq	%r12, %rdi
	call	speed_test_encode_work
	xorl	%esi, %esi
	movq	%r12, %rdi
	vmovsd	%xmm0, -184(%rbp)
	call	speed_test_decode_work
	vmovsd	-184(%rbp), %xmm2
	movq	%r12, %rdx
	vmovsd	%xmm0, %xmm0, %xmm1
	movq	%r13, %rsi
	movl	$1, %edi
	movl	$2, %eax
	vmovsd	%xmm2, %xmm2, %xmm0
	call	__printf_chk@PLT
	cmpq	%rbx, %r14
	jne	.L70
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L75
	addq	$200, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L75:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5531:
	.size	speed_test, .-speed_test
	.section	.rodata.str1.8
	.align 8
.LC13:
	.string	"--------speed test AEAD(Gbps)----------"
	.text
	.p2align 4
	.globl	speed_test_AEAD
	.type	speed_test_AEAD, @function
speed_test_AEAD:
.LFB5532:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	leaq	.LC13(%rip), %rdi
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	pushq	%rbx
	subq	$200, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	vmovdqa64	.LC10(%rip), %zmm0
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	movq	$16384, -112(%rbp)
	vmovdqa64	%zmm0, -176(%rbp)
	vzeroupper
	leaq	.LC12(%rip), %r13
	call	puts@PLT
	leaq	-176(%rbp), %rbx
	leaq	-104(%rbp), %r14
	.p2align 4
	.p2align 3
.L77:
	movq	(%rbx), %r12
	movl	$1, %esi
	addq	$8, %rbx
	movq	%r12, %rdi
	call	speed_test_encode_work
	movl	$1, %esi
	movq	%r12, %rdi
	vmovsd	%xmm0, -184(%rbp)
	call	speed_test_decode_work
	vmovsd	-184(%rbp), %xmm2
	movq	%r12, %rdx
	vmovsd	%xmm0, %xmm0, %xmm1
	movq	%r13, %rsi
	movl	$1, %edi
	movl	$2, %eax
	vmovsd	%xmm2, %xmm2, %xmm0
	call	__printf_chk@PLT
	cmpq	%rbx, %r14
	jne	.L77
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L82
	addq	$200, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L82:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5532:
	.size	speed_test_AEAD, .-speed_test_AEAD
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC14:
	.string	"========Rocca========"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5533:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC14(%rip), %rdi
	call	puts@PLT
	xorl	%eax, %eax
	call	speed_test
	xorl	%eax, %eax
	call	speed_test_AEAD
	movzbl	res(%rip), %edi
	call	putchar@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5533:
	.size	main, .-main
	.globl	res
	.bss
	.type	res, @object
	.size	res, 1
res:
	.zero	1
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	8158064640168781261
	.quad	4794697086780616226
	.align 16
.LC1:
	.quad	-1606136188198331460
	.quad	-5349999486874862801
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	1089470464
	.align 8
.LC3:
	.long	0
	.long	1075838976
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC4:
	.long	1232348160
	.section	.rodata.cst8
	.align 8
.LC5:
	.long	0
	.long	1104006501
	.section	.rodata.cst16
	.align 16
.LC6:
	.quad	506381209866536711
	.quad	506381209866536711
	.align 16
.LC7:
	.quad	72340172838076673
	.quad	72340172838076673
	.section	.rodata
	.align 64
.LC10:
	.quad	16
	.quad	64
	.quad	256
	.quad	512
	.quad	1024
	.quad	2048
	.quad	4096
	.quad	8192
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
