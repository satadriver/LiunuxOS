.386p


Kernel32 Segment public para use32
assume cs:Kernel32


__k8259SlaveEntry proc
pushad

mov ebp,esp
add ebp,32
push dword ptr ICW2_MASTER_INT_NO + 2
push dword ptr 0
push dword ptr [ebp]
push dword ptr [ebp + 4]
push dword ptr [ebp + 8]

test dword ptr [ebp+4],3
jz _kSlaveFriverKernelModeInt
push dword ptr [ebp + 12]
push dword ptr [ebp + 16]
jmp _kSlaveFriverShowExpInfo
_kSlaveFriverKernelModeInt:
push dword ptr 0
push dword ptr 0
_kSlaveFriverShowExpInfo:
call  __exceptionInfo
add esp,28

mov al,20h
out 20h,al
out 0a0h,al

popad
iretd
__k8259SlaveEntry endp

Kernel32 ends