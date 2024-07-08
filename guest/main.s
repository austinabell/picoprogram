.section .text._start
.global _start
_start:
  # Init operations
  .option push;
  .option norelax
  la gp, __global_pointer$
  .option pop
  la sp, _stack_top

  add	 sp,sp,-4    # Allocate 4 bytes on the stack (increase if saving ra and s0/fp)

  # NOTE: don't actually care to save these, as this function will not return
  # sw	 ra,28(sp)    # Save the return address (ra) at offset 28 from the stack pointer (sp)
  # sw	 s0,24(sp)    # Save the frame pointer (s0) at offset 24 from the stack pointer (sp)

  add  s0,sp,4     # Set the frame pointer (s0) to the current stack pointer (sp) plus 4
  call init_sha256
  sw   a0,0(s0)   # Save the result of init_sha256 (returned in a0) from the frame pointer (s0)

  # env exit expects the sha256 pointer as a0 and the exit code in a1
  li 	 a1,0         # Load immediate value 0 into register a1
  lw	 a0,0(s0)   # Load the saved result of init_sha256 into register a0 from the frame pointer (s0)
  call env_exit
  # Not cleaning up stack and frame pointers, as env_exit will exit or issue an illegal instruction
