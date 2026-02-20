.global main
.func main
.thumb_func

.data
.balign 4
delay:  .word   1000
x:  .word   3
y:  .word   15
lcv:    .word   10
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
    bge aftercond
    add r1, r1, #2
    ldr r3, =x
    str r1, [r3]
    ldr r0, =msg1
    bl printf
aftercond:
    ldr r0, =msg2
    ldr r1, =x
    ldr r1, [r1]
    ldr r2, =y
    ldr r2, [r2]
    bl printf

    @ for (int i=10; i>0; i--) print msg3, sleep 1 sec
    @ initialize is done
forcond:
    @ check condition
    ldr r1, =lcv
    ldr r1, [r1]
    mov r0, #0
    cmp r1, r0
    ble endfor
    @ body 
    ldr r0, =msg3
    bl printf
    ldr r0, =delay
    ldr r0, [r0]
    bl sleep_ms
    @ update
    ldr r1, =lcv
    ldr r1, [r1]
    ldr r0, =lcv
    sub r1, r1, #1
    str r1, [r0]
    b forcond
endfor:
    ldr r0, =msg4
    bl puts

    b loop