.global main
.func main
.thumb_func

.data
delay:  .word 1000
x:      .word 5
y:      .word 10
lcv:    .word 10
msg1:   .asciz  "x:%d\n"
msg2:   .asciz  "x:%d, y:%d\n"
msg3:   .asciz  "T minus %d\n"
msg4:   .asciz  "Blastoff!"


.text
main:
    bl stdio_init_all
loop:
    ldr r0, =delay
    ldr r0, [r0]
    bl sleep_ms

    ldr r1, =x
    ldr r1, [r1]
    ldr r2, =y
    ldr r2, [r2]
    cmp r1, r2
    bgt after_cond
    add r1, r1, #2
    ldr r3, =x
    str r1, [r3]
    ldr r0, =msg1
    bl printf
after_cond:
    ldr r1, =x
    ldr r1, [r1]
    ldr r2, =y
    ldr r2, [r2]
    ldr r0, =msg2
    bl printf

    @ for (int i=10; i>0; i--)
    @ lcv already initialized
forcond:
    @ check
    ldr r1, =lcv
    ldr r1, [r1]
    mov r2, #0
    cmp r1, r2
    ble endfor
    @ block
    ldr r0, =msg3
    bl  printf
    ldr r0, =delay
    ldr r0, [r0]
    bl sleep_ms
    ldr r0, =lcv
    ldr r0, [r0]
    sub r0, r0, #1
    ldr r1, =lcv
    str r0, [r1]
    @ go to the check
    b forcond

endfor:
    ldr r0, =msg4
    bl puts

    b loop
