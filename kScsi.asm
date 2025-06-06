.386p



Kernel32 Segment public para use32
assume cs:Kernel32


__kScsiProc proc
pushad
push ds
push es
mov ax,rwData32Seg
mov ds,ax
mov es,ax

mov ebp,esp
add ebp,32
push dword ptr ICW2_SLAVE_INT_NO + 3
push dword ptr 0
push dword ptr [ebp]
push dword ptr [ebp + 4]
push dword ptr [ebp + 8]

test dword ptr [ebp + 4],3
jz _kScsiKernelModeInt
push dword ptr [ebp + 12]
push dword ptr [ebp + 16]
jmp _kScsiShowExpInfo
_kScsiKernelModeInt:
push dword ptr 0
push dword ptr 0
_kScsiShowExpInfo:
call  __exceptionInfo
add esp,28

mov al,20h
out 0a0h,al
out 20h,al

pop es
pop ds
popad
iretd
__kScsiProc endp

Kernel32 ends