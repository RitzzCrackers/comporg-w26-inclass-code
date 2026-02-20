.global main
.func main
.thumb_func

.data
.balign 4
v1:     .word   3
v2:     .word   15
delay:  .word   1000
msg1:   .asciz  "Condition true"
msg2:   .asciz  "Condition false"


.text
main:
    bl stdio_init_all
loop:
    ldr r0, =delay
    ldr r0, [r0]
    bl sleep_ms

    ldr r1, =v1
    ldr r1, [r1]
    ldr r2, =v2
    ldr r2, [r2]
    cmp r1, r2
    bgt ctrue
    b cfalse
ctrue:
    ldr r0, =msg1
    bl puts
    b aftercond
cfalse:
    ldr r0, =msg2
    bl puts
aftercond:
    b loop