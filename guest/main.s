.section .text._start
.global _start
_start:
  # ECALL halt (register defaults to 0, so no need to explicitly set)
  # li t0, 0
  # Clear a0 register as HALT_TERMINATE is 0.
  # sll	a0,a0,0x8
  # Load out state into a1
  # la a1, hash
  
  # This is to reduce the la instruction from 2 to 1, given the linker script puts the hash address
  # statically at 0x408 which is within the 12 bit immediate value and doesn't require relative
  # addressing.
  addi a1,zero,0x408
  ecall
  # Assumes that the `sys_halt` ecall will stop execution, and not continuing executing. Should
  # put an `unimp` instruction after here to be safe against a malicious host in practice.

.section .rodata
hash:
  # Sha256 digest of empty commit and assumption
  .word 0x5C176F83, 0x53F3C062, 0x42651683, 0x340B8B7E, 0x19D2D1F6, 0xAE4D7602, 0xB8C606B4, 0xB075B53D
