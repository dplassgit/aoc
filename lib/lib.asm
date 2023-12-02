extern strstr
global ifind

section .text

; Find a string within another stirng, and return its index,
; or -1 if not found.
ifind:
  ; first string in rcx
  ; second string in rdx
  push rcx
  call strstr
  pop rcx
  ; result in rax
  cmp rax, 0
  je notfound
  ; rax = rax - rcx
  sub rax, rcx
  ret

notfound:
  mov rax, -1
  ret
