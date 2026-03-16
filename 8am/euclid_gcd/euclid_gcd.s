.syntax unified
.cpu cortex-m0plus
.thumb

.global main
.type main, %function

.extern stdio_init_all
.extern printf
.extern sleep_ms

.equ INITIAL_A, 73
.equ INITIAL_B, 70

.section .rodata
msg_a:   .asciz "Variable 1: %d\r\n"
msg_b:   .asciz "Variable 2: %d\r\n"
msg_gcd: .asciz "GCD: %d\r\n\r\n"

.section .text

main:
    push {r4, r5, lr}

    bl stdio_init_all
    ldr r0, =2000
    bl sleep_ms

loop_start:

    ldr r4, =INITIAL_A
    ldr r5, =INITIAL_B

    ldr r0, =msg_a
    mov r1, r4
    bl printf

    ldr r0, =msg_b
    mov r1, r5
    bl printf

gcd_loop:

    cmp r4, r5
    beq done

    bhi a_bigger

    subs r5, r5, r4
    b gcd_loop

a_bigger:

    subs r4, r4, r5
    b gcd_loop

done:

    ldr r0, =msg_gcd
    mov r1, r4
    bl printf

    ldr r0, =3000
    bl sleep_ms

    b loop_start