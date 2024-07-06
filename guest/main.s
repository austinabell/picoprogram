.section .text._start
.global _start
_start:
  .option push;
  .option norelax
  la gp, __global_pointer$
  .option pop
  la sp, _stack_top
  call main
main:
  # ECALL halt
  li t0, 0
  # Clear a0 register as HALT_TERMINATE is 0. Likely defaults to 0?
  sll	a0,a0,0x8
  # Load out state into a1
  la a1, hash
  ecall
  # This shouldn't be needed
  unimp

hash:
  # Sha256 digest of empty commit and assumption
  .word 0x5C176F83, 0x53F3C062, 0x42651683, 0x340B8B7E, 0x19D2D1F6, 0xAE4D7602, 0xB8C606B4, 0xB075B53D
