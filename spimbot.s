# This is the only file that will be considered for grading

.data
# syscall constants
PRINT_STRING            = 4
PRINT_CHAR              = 11
PRINT_INT               = 1

# memory-mapped I/O
VELOCITY                = 0xffff0010
ANGLE                   = 0xffff0014
ANGLE_CONTROL           = 0xffff0018

BOT_X                   = 0xffff0020
BOT_Y                   = 0xffff0024

OTHER_BOT_X             = 0xffff00a0
OTHER_BOT_Y             = 0xffff00a4

TIMER                   = 0xffff001c
ARENA_MAP               = 0xffff00dc

REQUEST_PUZZLE          = 0xffff00d0  ## Puzzle
SUBMIT_SOLUTION         = 0xffff00d4  ## Puzzle

BONK_INT_MASK           = 0x1000
BONK_ACK                = 0xffff0060

TIMER_INT_MASK          = 0x8000
TIMER_ACK               = 0xffff006c

REQUEST_PUZZLE_INT_MASK = 0x800       ## Puzzle
REQUEST_PUZZLE_ACK      = 0xffff00d8  ## Puzzle

GET_PAINT_BUCKETS       = 0xffff00e4
SWITCH_MODE             = 0xffff00f0

OPPONENT_POWERUP_ACK    = 0xffff00c8
POWERUP_MAP             = 0xffff00e0
GET_INVENTORY           = 0xffff00e8
GET_OPPONENT_POWERUP    = 0xffff00c4
PICKUP_POWERUP          = 0xffff00f4
USE_POWERUP             = 0xffff00ec

SCORES_REQUEST          = 0xffff1018

SPIMBOT_PRINT_INT       = 0xffff0080


### Puzzle
GRIDSIZE = 8

target_x:    .half 0:1
target_y:    .half 0:1
### Put these in your data segment
inventory:   .half 0:30
powerup:     .half 0:200
puzzle:      .half 0:164
heap: 		 .half 0:4160
arenamap:    .word 0:900
offpath:     .half 0:35

vertices:
.half: 3, 3
.half: 11, 3
.half: 18, 3
.half: 25, 3
.half: 3, 8
.half: 11, 8
.half: 18, 8
.half: 25, 8
.half: 3, 12
.half: 8, 12
.half: 21, 12
.half: 25, 12
.half: 3, 17
.half: 8, 17
.half: 21, 17
.half: 25, 17
.half: 3, 21
.half: 11, 21
.half: 18, 21
.half: 25, 21
.half: 3, 26
.half: 11, 26
.half: 18, 26
.half: 25, 26

next:
.half: 0, 0, 0, 1, 0, 8, 1, 0, 8, 1, 0, 8, 4, 1, 5, 1, 0, 8, 1, 0, 8, 1, 0, 8, 4, 1, 5, 4, 1, 5, 1, 0, 8, 1, 0, 8, 4, 1, 5, 4, 1, 5, 1, 0, 8, 1, 0, 8, 4, 1, 5, 4, 1, 5, 4, 1, 5, 1, 0, 8, 4, 1, 5, 4, 1, 5, 4, 1, 5, 4, 1, 5
.half: 0, 3, 8, 1, 0, 0, 2, 0, 7, 2, 0, 7, 0, 3, 8, 5, 1, 5, 6, 0, 8, 2, 0, 7, 5, 1, 5, 5, 1, 5, 6, 0, 8, 6, 0, 8, 5, 1, 5, 5, 1, 5, 6, 0, 8, 6, 0, 8, 5, 1, 5, 5, 1, 5, 6, 0, 8, 6, 0, 8, 5, 1, 5, 5, 1, 5, 5, 1, 5, 6, 0, 8
.half: 0, 3, 15, 1, 3, 7, 2, 0, 0, 3, 0, 7, 1, 3, 7, 5, 2, 8, 6, 1, 5, 3, 0, 7, 5, 2, 8, 5, 2, 8, 6, 1, 5, 6, 1, 5, 5, 2, 8, 5, 2, 8, 6, 1, 5, 6, 1, 5, 5, 2, 8, 5, 2, 8, 6, 1, 5, 6, 1, 5, 5, 2, 8, 5, 2, 8, 6, 1, 5, 6, 1, 5
.half: 0, 3, 22, 1, 3, 14, 2, 3, 7, 3, 0, 0, 2, 3, 7, 2, 3, 7, 2, 3, 7, 7, 1, 5, 2, 3, 7, 2, 3, 7, 7, 1, 5, 7, 1, 5, 2, 3, 7, 2, 3, 7, 7, 1, 5, 7, 1, 5, 2, 3, 7, 7, 1, 5, 7, 1, 5, 7, 1, 5, 2, 3, 7, 7, 1, 5, 7, 1, 5, 7, 1, 5
.half: 0, -1, 5, 1, 0, 9, 2, 0, 15, 3, 0, 22, 4, 0, 0, 8, 1, 4, 1, 0, 9, 3, 0, 22, 8, 1, 4, 8, 1, 4, 1, 0, 9, 1, 0, 9, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4, 8, 1, 4
.half: 0, -2, 9, 1, -1, 5, 2, 0, 8, 3, 0, 14, 4, 3, 8, 5, 0, 0, 1, -1, 5, 3, 0, 14, 9, 2, 5, 9, 2, 5, 1, -1, 5, 1, -1, 5, 9, 2, 5, 9, 2, 5, 1, -1, 5, 1, -1, 5, 9, 2, 5, 9, 2, 5, 9, 2, 5, 1, -1, 5, 9, 2, 5, 9, 2, 5, 9, 2, 5, 9, 2, 5
.half: 0, -2, 15, 1, -2, 8, 2, -1, 5, 3, 0, 8, 0, -2, 15, 5, 3, 7, 6, 0, 0, 10, 0, 5, 5, 3, 7, 5, 3, 7, 10, 0, 5, 10, 0, 5, 5, 3, 7, 5, 3, 7, 10, 0, 5, 10, 0, 5, 5, 3, 7, 10, 0, 5, 10, 0, 5, 10, 0, 5, 10, 0, 5, 10, 0, 5, 10, 0, 5, 10, 0, 5
.half: 0, -2, 22, 1, -2, 14, 2, -2, 8, 3, -1, 5, 2, -2, 8, 2, -2, 8, 6, 3, 7, 7, 0, 0, 2, -2, 8, 2, -2, 8, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4, 11, 1, 4
.half: 0, -1, 9, 1, 0, 12, 2, 0, 17, 3, 0, 23, 4, -1, 4, 5, 0, 8, 1, 0, 12, 3, 0, 23, 8, 0, 0, 9, 0, 5, 9, 0, 5, 13, 0, 7, 12, 1, 5, 13, 0, 7, 13, 0, 7, 13, 0, 7, 12, 1, 5, 13, 0, 7, 13, 0, 7, 13, 0, 7, 12, 1, 5, 13, 0, 7, 13, 0, 7, 13, 0, 7
.half: 0, -2, 10, 1, -1, 9, 2, 0, 13, 3, 0, 19, 4, -2, 6, 5, 0, 5, 1, -1, 9, 3, 0, 19, 8, 3, 5, 9, 0, 0, 1, -1, 9, 1, -1, 9, 12, 2, 7, 13, 1, 5, 13, 1, 5, 13, 1, 5, 12, 2, 7, 13, 1, 5, 13, 1, 5, 13, 1, 5, 12, 2, 7, 13, 1, 5, 13, 1, 5, 13, 1, 5
.half: 0, -2, 20, 1, -2, 13, 2, -1, 9, 3, -1, 9, 0, -2, 20, 5, -2, 10, 6, -2, 5, 7, 0, 5, 8, 3, 18, 5, -2, 10, 10, 0, 0, 11, 0, 4, 14, 1, 5, 14, 1, 5, 14, 1, 5, 15, 0, 6, 14, 1, 5, 14, 1, 5, 14, 1, 5, 15, 0, 6, 14, 1, 5, 14, 1, 5, 14, 1, 5, 15, 0, 6
.half: 0, -2, 23, 1, -2, 16, 2, -2, 11, 3, -1, 9, 0, -2, 23, 5, -2, 14, 6, -2, 8, 7, -1, 4, 8, 3, 22, 5, -2, 14, 10, 3, 4, 11, 0, 0, 14, 2, 6, 14, 2, 6, 14, 2, 6, 15, 1, 5, 14, 2, 6, 14, 2, 6, 14, 2, 6, 15, 1, 5, 14, 2, 6, 14, 2, 6, 14, 2, 6, 15, 1, 5
.half: 0, -1, 14, 1, -1, 16, 2, 0, 20, 3, 0, 26, 4, -1, 9, 5, 0, 12, 1, -1, 16, 7, 0, 23, 8, -1, 5, 9, 0, 7, 10, 0, 18, 11, 0, 22, 12, 0, 0, 13, 0, 5, 13, 0, 5, 13, 0, 5, 16, 1, 4, 13, 0, 5, 13, 0, 5, 13, 0, 5, 16, 1, 4, 13, 0, 5, 13, 0, 5, 13, 0, 5
.half: 0, -1, 14, 1, -1, 14, 2, 0, 17, 3, 0, 22, 4, -2, 10, 5, -1, 9, 1, -1, 14, 7, 0, 19, 8, -2, 7, 9, -1, 5, 10, 0, 13, 11, 0, 17, 12, 3, 5, 13, 0, 0, 17, 0, 5, 17, 0, 5, 12, 3, 5, 17, 0, 5, 17, 0, 5, 17, 0, 5, 12, 3, 5, 17, 0, 5, 17, 0, 5, 17, 0, 5
.half: 0, -2, 22, 1, -2, 17, 2, -1, 14, 3, -1, 14, 4, -2, 20, 5, -2, 13, 6, -1, 9, 7, -1, 9, 8, -2, 18, 9, -2, 13, 10, -1, 5, 11, 0, 6, 12, 3, 18, 13, 3, 13, 14, 0, 0, 15, 0, 4, 18, 2, 5, 18, 2, 5, 18, 2, 5, 15, 0, 4, 18, 2, 5, 18, 2, 5, 18, 2, 5, 15, 0, 4
.half: 0, -2, 26, 1, -2, 19, 2, -2, 15, 3, -1, 14, 4, -2, 23, 5, -2, 16, 6, -2, 11, 7, -1, 9, 8, -2, 22, 9, -2, 17, 10, -2, 6, 11, -1, 5, 12, 3, 22, 13, 3, 17, 14, 3, 4, 15, 0, 0, 14, 3, 4, 14, 3, 4, 14, 3, 4, 19, 1, 4, 14, 3, 4, 14, 3, 4, 14, 3, 4, 19, 1, 4
.half: 0, -1, 18, 1, -1, 19, 2, 0, 23, 3, 0, 28, 4, -1, 13, 5, -1, 15, 1, -1, 19, 7, 0, 25, 8, -1, 9, 9, -1, 10, 10, 0, 20, 11, 0, 23, 12, -1, 4, 13, 0, 6, 14, 0, 18, 15, 0, 22, 16, 0, 0, 13, 0, 6, 13, 0, 6, 20, 1, 5, 20, 1, 5, 20, 1, 5, 20, 1, 5, 20, 1, 5
.half: 0, -1, 19, 1, -1, 18, 2, -1, 19, 3, 0, 22, 4, -2, 15, 5, -1, 13, 6, -1, 14, 7, 0, 19, 8, -2, 12, 9, -1, 9, 10, 0, 13, 11, 0, 16, 12, -2, 8, 13, -2, 5, 14, 0, 10, 15, 0, 14, 12, -2, 8, 17, 0, 0, 18, 0, 7, 18, 0, 7, 21, 1, 5, 21, 1, 5, 22, 0, 8, 22, 0, 8
.half: 0, -2, 23, 1, -1, 19, 2, -1, 18, 3, -1, 19, 4, -2, 19, 5, -2, 14, 6, -1, 13, 7, -1, 14, 8, -2, 17, 9, -2, 13, 10, -1, 9, 11, 0, 11, 12, -2, 15, 13, -2, 10, 14, 0, 5, 15, 0, 8, 12, -2, 15, 17, 3, 7, 18, 0, 0, 15, 0, 8, 21, 2, 8, 21, 2, 8, 22, 1, 5, 22, 1, 5
.half: 0, -2, 28, 1, -2, 22, 2, -1, 19, 3, -1, 18, 4, -2, 25, 5, -2, 19, 6, -2, 14, 7, -1, 13, 8, -2, 23, 9, -2, 19, 10, -1, 9, 11, -1, 9, 12, -2, 22, 13, -2, 17, 14, -2, 5, 15, -1, 4, 16, 3, 22, 17, 3, 14, 14, -2, 5, 19, 0, 0, 23, 1, 5, 23, 1, 5, 23, 1, 5, 23, 1, 5
.half: 0, -1, 23, 1, -1, 24, 2, 0, 27, 3, 0, 31, 4, -1, 18, 5, -1, 19, 6, 0, 23, 7, 0, 28, 8, -1, 14, 9, -1, 14, 10, 0, 22, 11, 0, 26, 12, -1, 9, 13, -1, 10, 14, 0, 20, 15, 0, 23, 16, -1, 5, 17, 0, 9, 18, 0, 15, 19, 0, 22, 20, 0, 0, 21, 0, 8, 21, 0, 8, 21, 0, 8
.half: 0, -1, 24, 1, -1, 23, 2, -1, 24, 3, -1, 26, 4, -1, 19, 5, -1, 18, 6, -1, 19, 7, 0, 22, 8, -2, 16, 9, -1, 14, 10, 0, 17, 11, 0, 19, 12, -2, 12, 13, -1, 9, 14, 0, 13, 15, 0, 16, 16, -2, 9, 17, -1, 5, 18, 0, 8, 19, 0, 14, 20, 3, 8, 21, 0, 0, 22, 0, 7, 22, 0, 7
.half: 0, -2, 27, 1, -1, 24, 2, -1, 23, 3, -1, 24, 4, -2, 23, 5, -1, 19, 6, -1, 18, 7, -1, 19, 8, -2, 20, 9, -2, 17, 10, -1, 14, 11, -1, 15, 12, -2, 17, 13, -2, 13, 14, -1, 9, 15, 0, 11, 16, -2, 15, 17, -2, 8, 18, -1, 5, 19, 0, 8, 20, 3, 15, 21, 3, 7, 22, 0, 0, 23, 0, 7
.half: 0, -2, 31, 1, -2, 26, 2, -1, 24, 3, -1, 23, 4, -2, 28, 5, -2, 22, 6, -1, 19, 7, -1, 18, 8, -2, 26, 9, -2, 22, 10, -1, 14, 11, -1, 14, 12, -2, 23, 13, -2, 19, 14, -1, 9, 15, -1, 9, 16, -2, 22, 17, -2, 14, 18, -2, 8, 19, -1, 5, 20, 3, 22, 21, 3, 14, 22, 3, 7, 23, 0, 0

heap:        .half 0:4160

.text
main:
	# Construct interrupt mask
	li      $t4, 0
	or      $t4, $t4, TIMER_INT_MASK # request timer
	or      $t4, $t4, BONK_INT_MASK # request bonk
	or      $t4, $t4, REQUEST_PUZZLE_INT_MASK	        # puzzle interrupt bit
	or      $t4, $t4, 1 # global enable
	mtc0    $t4, $12

    # allocate on the dynamic heap
    li $a0,1620000   # $a0 contains the number of bytes you need.
                  # This must be a multiple of four.
    li $v0,9 # code 9 == allocate memory
    syscall # call the service.
    la $t0, distance
    sd $v0, 0($t0)  # $v0 <-- the address of the first byte
                    # of the dynamically allocated block

    # allocate on the dynamic heap
    li      $a0,1620000   # $a0 contains the number of bytes you need.
                  # This must be a multiple of four.
    li      $v0,9     # code 9 == allocate memory
    syscall           # call the service.
    la $t0, next
    sd $v0, 0($t0)  # $v0 <-- the address of the first byte
                    # of the dynamically allocated block

	#Fill in your code here
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    sw  $s2, 12($sp)
    sw  $s3, 16($sp)
    sw  $s4, 20($sp)
    sw  $s5, 24($sp)
    sw  $s6, 28($sp)
    sw  $s7, 32($sp)
    sub $sp, $sp, 36

    la $t0, puzzle
    sw $t0, REQUEST_PUZZLE($0)
    li $t1, 1
    sw $t1, SWITCH_MODE($0)
    li $t1, 10
    sw $t1, VELOCITY($0)

    la $t2, powerup
    sw $t2, POWERUP_MAP($0)

    # powerup 1's x location
    lh 		$s0, 4($t2)
	la		$s1, target_x
	sh 		$s0, 0($s1) 			# target_x = powerup 1's x location

    # sw 		$s0, SPIMBOT_PRINT_INT($0)

	# powerup 1's y location
    lh 		$s2, 6($t2)
	la		$s3, target_y
	sh 		$s2, 0($s3) 			# target_y = powerup 1's y location

    sw 		$s2, SPIMBOT_PRINT_INT($0)

    la $t0, arenamap
    sw $t0, ARENA_MAP($0)

    jal floyd_warshall

	# lw 		$v0, TIMER($0)
	# add 	$v0, $v0, 50
	# sw 		$v0, TIMER($0)

    j 		loop

    lw  $ra, 0($sp)
    lw  $s0, 4($sp)
    lw  $s1, 8($sp)
    lw  $s2, 12($sp)
    lw  $s3, 16($sp)
    lw  $s4, 20($sp)
    lw  $s5, 24($sp)
    lw  $s6, 28($sp)
    lw  $s7, 32($sp)
    add $sp, $sp, 36

	jr $ra

loop:
    j loop


.kdata
chunkIH:    .space 32
non_intrpt_str:    .asciiz "Non-interrupt exception\n"
unhandled_str:    .asciiz "Unhandled interrupt type\n"
.ktext 0x80000180
interrupt_handler:
.set noat
        move      $k1, $at        # Save $at
.set at
        la        $k0, chunkIH
        sw        $a0, 0($k0)        # Get some free registers
        sw        $v0, 4($k0)        # by storing them to a global variable
        sw        $t0, 8($k0)
        sw        $t1, 12($k0)
        sw        $t2, 16($k0)
        sw        $t3, 20($k0)
		sw 		  $t4, 24($k0)
		sw 		  $t5, 28($k0)

        mfc0      $k0, $13             # Get Cause register
        srl       $a0, $k0, 2
        and       $a0, $a0, 0xf        # ExcCode field
        bne       $a0, 0, non_intrpt



interrupt_dispatch:            # Interrupt:
    mfc0       $k0, $13        # Get Cause register, again
    beq        $k0, 0, done        # handled all outstanding interrupts

    and        $a0, $k0, BONK_INT_MASK    # is there a bonk interrupt?
    bne        $a0, 0, bonk_interrupt

    and        $a0, $k0, TIMER_INT_MASK    # is there a timer interrupt?
    bne        $a0, 0, timer_interrupt

	and 	$a0, $k0, REQUEST_PUZZLE_INT_MASK
  	bne 	$a0, 0, request_puzzle_interrupt

    li        $v0, PRINT_STRING    # Unhandled interrupt types
    la        $a0, unhandled_str
    syscall
    j    done

bonk_interrupt:
	sw 		$0, BONK_ACK
    #Fill in your code here
    la 		$t0, puzzle
    sw 		$t0, REQUEST_PUZZLE($0)
    li 		$t1, 1
    sw 		$t1, ANGLE_CONTROL($0)
    lw 		$t1, ANGLE($0)
    lw 		$t3, TIMER($0)
	rem 	$t3, $t3, 360
	add 	$t1, $t1, $t3
    li 		$t2, 360
    rem 	$t1, $t1, $t2
    sw 		$t1, ANGLE($0)
    li 		$t1, 10
    sw 		$t1, VELOCITY($0)

    j       interrupt_dispatch    # see if other interrupts are waiting

request_puzzle_interrupt:
	sw 		$0, REQUEST_PUZZLE_ACK

	#Fill in your code here
    la      $a0, puzzle
    la      $a1, heap
    jal     copy_board    # Copy board to heap
    la 		$a0, heap
    li 		$a1, 0
    li 		$a2, 0
    la 		$a3, puzzle
    jal 	solve
    la 		$t0, puzzle
    sw 		$t0, SUBMIT_SOLUTION($0)
    li 		$t1, 1
    sw 		$t1, SWITCH_MODE($0)
    sw 		$0, USE_POWERUP($0)

	j		interrupt_dispatch


timer_interrupt:
	sw 		$0, TIMER_ACK
	sw  	$ra, 0($sp)
	sw  	$s0, 4($sp)
	sw  	$s1, 8($sp)
	sw  	$s2, 12($sp)
	sw  	$s3, 16($sp)
	sw  	$s4, 20($sp)
	sw  	$s5, 24($sp)
	sw  	$s6, 28($sp)
	sw  	$s7, 32($sp)
	sub 	$sp, $sp, 36

	la 		$s0, next
	lw 		$s0, 0($s0)

	lw 		$s1, BOT_X($0)
	div 	$s1, $s1, 10
	# sw 		$s1, SPIMBOT_PRINT_INT($0)

	lw 		$s2, BOT_Y($0)
	div 	$s2, $s2, 10
	# sw 		$s2, SPIMBOT_PRINT_INT($0)

	move 	$a0, $s1
	move 	$a1, $s2
	jal 	find_closest_node
	move 	$s5, $v0

	la 		$s3, target_x
	lh 		$s3, 0($s3)
	# sw 		$s3, SPIMBOT_PRINT_INT($0)

	la 		$s4, target_y
	lh 		$s4, 0($s4)
	# sw 		$s4, SPIMBOT_PRINT_INT($0)


	beq 	$s1, $s3, check_y

get_direction:
	# load target_x and target_y again, in case new target
	la 		$s3, target_x
	lh 		$s3, 0($s3)
	la 		$s4, target_y
	lh 		$s4, 0($s4)

	# sw 		$s1, SPIMBOT_PRINT_INT($0)
	# sw 		$s2, SPIMBOT_PRINT_INT($0)

    # s2 is bot y
    # s1 is bot x
	mul 	$s5, $s2, 30 			# $s5 = uy * 30
	add 	$s5, $s5, $s1 			# $s5 = ux + s5

	mul 	$s6, $s4, 30 			# $s6 = vy * 30
	add 	$s6, $s6, $s3 			# $s6 = vx + s6
	mul 	$s7, $s6, 900			# $s7 = 900 * s6

	add 	$s7, $s5, $s7			# $s7 = u stuff + v stuff
	add 	$s0, $s0, $s7			# s0 = next[u][v]
	# sw 		$s0, SPIMBOT_PRINT_INT($0)

	sub		$s6, $s0, $s5 			# $s6 = next[u][v] - u
	# li 		$s7, 1234
	# sw 		$s7, SPIMBOT_PRINT_INT($0)
	# sw 		$s6, SPIMBOT_PRINT_INT($0)

	beq 	$s6, 30, turn_down
	beq 	$s6, -30, turn_up
	beq 	$s6, 1, turn_left
	beq 	$s6, -1, turn_right
	j 		set_timer

set_angle:
	sw 		$s7, ANGLE($0)
	li 		$s5, 1
	sw 		$s5, ANGLE_CONTROL($0)

set_timer:
	lw 		$v0, TIMER($0)
	add 	$v0, $v0, 10000
	sw 		$v0, TIMER($0)

    j        interrupt_dispatch    # see if other interrupts are waiting

# +x = 0 --> right
turn_right:
	li 		$s7, 0
	j 		set_angle

# +y = 90 --> down
turn_down:
	li 		$s7, 90
	j 		set_angle

# -x = 180 --> left
turn_left:
	li 		$s7, 180
	j 		set_angle

# -y = 270 --> up
turn_up:
	li 		$s7, 270
	j 		set_angle

check_y:
    beq 	$s2, $s4, pickup
    j 		get_direction

pickup:
    li 		$s5, 1
	sw 		$s5, PICKUP_POWERUP($0)
	# li 		$s6, 1234
	# sw 		$s6, SPIMBOT_PRINT_INT($0)

	# set new target as 1st powerup
	la 		$t2, powerup
    sw 		$t2, POWERUP_MAP($0)

    # powerup 1's x location
    lh 		$s5, 4($t2)
	la		$s6, target_x
	sh 		$s5, 0($s6) 			# target_x = powerup 1's x location

	# powerup 1's y location
    lh 		$s5, 6($t2)
	la		$s6, target_y
	sh 		$s5, 0($s6) 			# target_y = powerup 1's y location

    j 		get_direction

# find_closest_node #####################################################
#
# argument $a0: x
# argument $a1: y
find_closest_node:
	sw  	$ra, 0($sp)
	sw  	$s0, 4($sp)
	sw  	$s1, 8($sp)
	sw  	$s2, 12($sp)
	sw  	$s3, 16($sp)
	sw  	$s4, 20($sp)
	sw  	$s5, 24($sp)
	sw  	$s6, 28($sp)
	sw  	$s7, 32($sp)
	sub 	$sp, $sp, 36

	la 		$s0, vertices
	lw 		$s0, 0($s0)



non_intrpt:                # was some non-interrupt
    li        $v0, PRINT_STRING
    la        $a0, non_intrpt_str
    syscall                # print out an error message
    # fall through to done

done:
    la      $k0, chunkIH
    lw      $a0, 0($k0)        # Restore saved registers
    lw      $v0, 4($k0)
	lw      $t0, 8($k0)
    lw      $t1, 12($k0)
    lw      $t2, 16($k0)
    lw      $t3, 20($k0)
	lw $t4, 24($k0)
	lw $t5, 28($k0)
.set noat
    move    $at, $k1        # Restore $at
.set at
    eret

solve:
    sw $0, VELOCITY($0)
    sub     $sp, $sp, 36
    sw      $ra, 0($sp)
    sw      $s0, 4($sp)
    sw      $s1, 8($sp)
    sw      $s2, 12($sp)
    sw      $s3, 16($sp)
    sw      $s4, 20($sp)
    sw      $s5, 24($sp)
    sw      $s6, 28($sp)
    sw      $s7, 32($sp)
    li   $s7, GRIDSIZE
    move $s0, $a1     # row
    move $s1, $a2     # col

    move $s2, $a0     # current_board
    move $s3, $a3     # puzzle

    bge  $s0, $s7, solve_done_check  # row >= GRIDSIZE
    bge  $s1, $s7, solve_done_check  # col >= GRIDSIZE
    j solve_not_done
solve_done_check:
    move $a0, $s2     # current_board
    move $a1, $s3     # puzzle
    jal board_done

    beq $v0, $0, solve_done_false  # if (done)
    move $s7, $v0     # save done
    move $a0, $s2     # current_board
    move $a1, $s3     # puzzle // same as puzzle->board
    jal copy_board

    move $v0, $s7     # $v0: done

    j solve_done

solve_not_done:

    move $a0, $s2 # current_board
    jal increment_heap
    move $s2, $v0 # update current_board

    li  $v0, 0 # changed = false
solve_start_do:

    move $a0, $s2


    jal rule1          # changed = rule1(current_board);
    move $s6, $v0      # done

    # move $a0, $s2      # current_board
    # jal rule2
	#
    # or   $v0, $v0, $s6 # changed |= rule2(current_board);

    bne $v0, $0, solve_start_do # while (changed)

    move $a0, $s2     # current_board
    move $a1, $s3     # puzzle
    jal board_done

    beq $v0, $0, solve_board_not_done_after_dowhile  # if (done)
    move $s7, $v0     # save done
    move $a0, $s2     # current_board
    move $a1, $s3     # puzzle // same as puzzle->board
    jal copy_board

    move $v0, $s7     # $v0: done
    j   solve_done

solve_board_not_done_after_dowhile:


    mul $t0, $s0, $s7  # row*GRIDSIZE
    add $t0, $t0, $s1  # row*GRIDSIZE + col
    mul $t0, $t0, 2    # sizeof(unsigned short) * (row*GRIDSIZE + col)
    add $s4, $t0, $s2  # &current_board[row*GRIDSIZE + col]
    lhu $s6, 0($s4)    # possibles = current_board[row*GRIDSIZE + col]

    li $s5, 0 # char number = 0
solve_start_guess:
    bge $s5, $s7, solve_start_guess_end # number < GRIDSIZE
    li $t0, 1
    sll $t1, $t0, $s5 # (1 << number)
    and $t0, $t1, $s6 # (1 << number) & possibles
    beq $t0, $0, solve_start_guess_else
    sh  $t1, 0($s4)   # current_board[row*GRIDSIZE + col] = 1 << number;

    move $a0, $s2     # current_board
    move $a1, $s0     # next_row = row
    sub  $t0, $s7, 1  # GRIDSIZE-1
    bne  $s1, $t0, solve_start_guess_same_row # col < GRIDSIZE // col==GRIDSIZE-1
    addi $a1, $a1, 1  # row + 1
solve_start_guess_same_row:
    move $a2, $s1     # col
    addu $a2, $a2, 1  # col + 1
    divu $a2, $s7
    mfhi $a2          # (col + 1) % GRIDSIZE
    move $a3, $s3     # puzzle
    jal solve         # solve(current_board, next_row, (col + 1) % GRIDSIZE, puzzle)

    bne  $v0, $0, solve_done_true # if done {return true}
    sh   $s6, 0($s4)  # current_board[row*GRIDSIZE + col] = possibles;
solve_start_guess_else:
    addi $s5, $s5, 1
    j solve_start_guess

solve_done_false:
solve_start_guess_end:
    li  $v0, 0        # done = false

solve_done:
    li $s0, 10
    sw $s0, VELOCITY($0)
    lw  $ra, 0($sp)
    lw  $s0, 4($sp)
    lw  $s1, 8($sp)
    lw  $s2, 12($sp)
    lw  $s3, 16($sp)
    lw  $s4, 20($sp)
    lw  $s5, 24($sp)
    lw  $s6, 28($sp)
    lw  $s7, 32($sp)
    add $sp, $sp, 36
    jr      $ra

solve_done_true:
    li $v0, 1
    j solve_done

# // bool rule1(unsigned short* board) {
# //   bool changed = false;
# //   for (int y = 0 ; y < GRIDSIZE ; y++) {
# //     for (int x = 0 ; x < GRIDSIZE ; x++) {
# //       unsigned value = board[y*GRIDSIZE + x];
# //       if (has_single_bit_set(value)) {
# //         for (int k = 0 ; k < GRIDSIZE ; k++) {
# //           // eliminate from row
# //           if (k != x) {
# //             if (board[y*GRIDSIZE + k] & value) {
# //               board[y*GRIDSIZE + k] &= ~value;
# //               changed = true;
# //             }
# //           }
# //           // eliminate from column
# //           if (k != y) {
# //             if (board[k*GRIDSIZE + x] & value) {
# //               board[k*GRIDSIZE + x] &= ~value;
# //               changed = true;
# //             }
# //           }
# //         }
# //       }
# //     }
# //   }
# //   return changed;
# // }
#a0: board
rule1:
        sub     $sp, $sp, 36
        sw      $ra, 0($sp)
        sw      $s0, 4($sp)
        sw      $s1, 8($sp)
        sw      $s2, 12($sp)
        sw      $s3, 16($sp)
        sw      $s4, 20($sp)
        sw      $s5, 24($sp)
        sw      $s6, 28($sp)
        sw      $s7, 32($sp)
        li      $s0, GRIDSIZE                  # $s0: GRIDSIZE = 4
        move    $s1, $a0                # $s1: board
        li      $s2, 0                  # $s2: changed = false
        li      $s3, 0                  # $s3: y = 0
r1_for_y_start:
        bge     $s3, $s0, r1_for_y_end  # for: y < GRIDSIZE
        li      $s4, 0                  # $s4: x = 0
r1_for_x_start:
        bge     $s4, $s0, r1_for_x_end  # for: x < GRIDSIZE
        mul     $a0, $s3, $s0           # $a0: y*GRIDSIZE
        add     $a0, $a0, $s4           # $a0: y*GRIDSIZE + x
        sll     $a0, $a0, 1             # $a0: 2*(y*GRIDSIZE + x)
        add     $a0, $a0, $s1           # $a0: &board[y*GRIDSIZE+x]
        lhu     $a0, 0($a0)             # $a0: value = board[y*GRIDSIZE+x]
        move    $s6, $a0                # $s6: value
        jal     has_single_bit_set
        beq     $v0, 0, r1_for_x_inc    # if(has_single_bit_set(value))
        li      $s5, 0                  # $s5: k = 0
r1_for_k_start:
        bge     $s5, $s0, r1_for_k_end  # for: k < GRIDSIZE
        beq     $s5, $s4, r1_if_kx_end  # if (k != x)
        mul     $t0, $s3, $s0           # $t0: y*GRIDSIZE
        add     $t0, $t0, $s5           # $t0: y*GRIDSIZE + k
        sll     $t0, $t0, 1             # $t0: 2*(y*GRIDSIZE + k)
        add     $t0, $t0, $s1           # $t0: &board[y*GRIDSIZE+k]
        lhu     $t1, 0($t0)             # $t1: board[y*GRIDSIZE + k]
        and     $t2, $t1, $s6           # $t2: board[y*GRIDSIZE + k] & value
        beq     $t2, 0, r1_if_kx_end    # if (board[y*GRIDSIZE + k] & value)
        not     $t3, $s6                # $t3: ~value
        and     $t1, $t1, $t3           # $t1:  board[y*GRIDSIZE + k] & ~value
        sh      $t1, 0($t0)             # board[y*GRIDSIZE + k] &= ~value
        li      $s2, 1                  # changed = true
r1_if_kx_end:
        beq     $s5, $s3, r1_if_ky_end  # if (k != y)
        mul     $t0, $s5, $s0           # $t0: k*GRIDSIZE
        add     $t0, $t0, $s4           # $t0: k*GRIDSIZE + x
        sll     $t0, $t0, 1             # $t0: 2*(k*GRIDSIZE + x)
        add     $t0, $t0, $s1           # $t0: &board[k*GRIDSIZE+x]
        lhu     $t1, 0($t0)             # $t1: board[k*GRIDSIZE + x]
        and     $t2, $t1, $s6           # $t2: board[k*GRIDSIZE + x] & value
        beq     $t2, 0, r1_if_ky_end    # if (board[k*GRIDSIZE + x] & value)
        not     $t3, $s6                # $t3: ~value
        and     $t1, $t1, $t3           # $t1:  board[k*GRIDSIZE + x] & ~value
        sh      $t1, 0($t0)             # board[k*GRIDSIZE + x] &= ~value
        li      $s2, 1                  # changed = true
r1_if_ky_end:
        add     $s5, $s5, 1             # for: k++
        j       r1_for_k_start
r1_for_k_end:
r1_for_x_inc:
        add     $s4, $s4, 1             # for: x++
        j       r1_for_x_start
r1_for_x_end:
r1_for_y_inc:
        add     $s3, $s3, 1             # for: y++
        j       r1_for_y_start
r1_for_y_end:
        move    $v0, $s2                # return changed
r1_return:
        lw      $ra, 0($sp)
        lw      $s0, 4($sp)
        lw      $s1, 8($sp)
        lw      $s2, 12($sp)
        lw      $s3, 16($sp)
        lw      $s4, 20($sp)
        lw      $s5, 24($sp)
        lw      $s6, 28($sp)
        lw      $s7, 32($sp)
        add     $sp, $sp, 36
        jr      $ra

# rule2 #####################################################
#
# argument $a0: pointer to current board
rule2:
    sub $sp, $sp, 4                       #Store ra onto stack and initialize GRIDSIZE
    sw $ra, 0($sp)
    li $t0, GRIDSIZE                               # GRIDSIZE
    li $t1, 1
    sll $t1, $t1, $t0
    subu $t1, $t1, 1                         #int ALL_VALUES = (1 << GRIDSIZE) - 1;
    li $v0, 0                               #bool changed = false
    li $t2, 0                               #i = 0

rule2iloopstart:
    bge $t2, $t0, rule2iloopend
    li $t3, 0                               #j = 0
    rule2jloopstart:
        bge $t3, $t0, rule2jloopend

        mul $t4, $t2, $t0
        add $t4, $t4, $t3
        mul $t4, $t4, 2                     #sizeof(unsigned short)*(i*GRIDSIZE + j)
        add $t4, $a0, $t4                   #address of board[i*GRIDSIZE+j]
        lhu $t4, 0($t4)                     #board[i*GRIDSIZE + j]

        sub $sp, $sp, 24                    # Allocate stack
        sw $a0, 0($sp)
        sw $t0, 4($sp)
        sw $t1, 8($sp)
        sw $t2, 12($sp)
        sw $t3, 16($sp)
        sw $v0, 20($sp)                     #Store all necessary variables on stack
        move $a0, $t4
        jal has_single_bit_set
        lw $a0, 0($sp)
        lw $t0, 4($sp)
        lw $t1, 8($sp)
        lw $t2, 12($sp)
        lw $t3, 16($sp)
        move $t4, $v0                       # Save $v0 into $t4
        lw $v0, 20($sp)                     # Restore variables
        add $sp, $sp, 24                    # Deallocate stack

        bne $t4, $0, rule2continuestatement #if (has_single_bit_set(value)) continue;

        li $t5, 0                           #isum = 0
        li $t6, 0                           #jsum = 0
        li $t4, 0                           #k = 0, t2 = i, t3 = j, t4 = k
        rule2kloopstart:
            bge $t4, $t0, rule2kloopend
            beq $t4, $t3, rule2kequalsj
                mul $t7, $t2, $t0           #i*GRIDSIZE
                add $t7, $t7, $t4           #i*GRIDSIZE+k
                mul $t7, $t7, 2
                add $t7, $a0, $t7           #&board[i*GRIDSIZE + k]
                lhu $t7, 0($t7)
                or $t6, $t6, $t7            #jsum |= board[i*GRIDSIZE + k];
        rule2kequalsj:
            beq $t4, $t2, rule2kequalsi
                mul $t7, $t4, $t0           #k*GRIDSIZE
                add $t7, $t7, $t3           #k*GRIDSIZE+j
                mul $t7, $t7, 2
                add $t7, $a0, $t7           #&board[k*GRIDSIZE + j]
                lhu $t7, 0($t7)
                or $t5, $t5, $t7            #isum |= board[k*GRIDSIZE + j];
        rule2kequalsi:
            add $t4, $t4, 1
            j rule2kloopstart
        rule2kloopend:
        beq $t1, $t6, rule2allvalequalsjsum
            not $t6, $t6                    # ~jsum
            and $t6, $t1, $t6               #ALL_VALUES & ~jsum
            mul $t7, $t0, $t2               # i*GRIDSIZE
            add $t7, $t7, $t3               #[i*GRIDSIZE+j]
            mul $t7, $t7, 2                 #(i*GRIDSIZE+j)*sizeof(unsigned short)
            add $t7, $a0, $t7
            sh $t6, 0($t7)                  #board[i*GRIDSIZE + j] = ALL_VALUES & ~jsum;
            li $v0, 1
            j rule2continuestatement
        rule2allvalequalsjsum:
        beq $t1, $t5, rule2continuestatement
            not $t5, $t5                    # ~isum
            and $t5, $t1, $t5               #ALL_VALUES & ~isum;
            mul $t7, $t0, $t2               # i*GRIDSIZE
            add $t7, $t7, $t3               #[i*GRIDSIZE+j]
            mul $t7, $t7, 2                 #(i*GRIDSIZE+j)*sizeof(unsigned short)
            add $t7, $a0, $t7
            sh $t5, 0($t7)                  #board[i*GRIDSIZE + j] = ALL_VALUES & ~isum;
            li $v0, 1
    rule2continuestatement:
        add $t3, $t3, 1
        j rule2jloopstart                   #continue; iterates to next index of jloop
    rule2jloopend:
    add $t2, $t2, 1
    j rule2iloopstart
rule2iloopend:

    lw $ra, 0($sp)
    add $sp, $sp, 4
    jr $ra


# board done ##################################################
#
# argument $a0: pointer to current board to check
# argument $a1: pointer to puzzle struct
board_done:
    sub $sp, $sp, 36
    sw  $ra, 0($sp)
    sw  $s0, 4($sp)
    sw  $s1, 8($sp)
    sw  $s2, 12($sp)
    sw  $s3, 16($sp)
    sw  $s4, 20($sp)
    sw  $s5, 24($sp)
    sw  $s6, 28($sp)
    sw  $s7, 32($sp)

    move    $s0, $a0        # s0 = current_board
    move    $s1, $a1        # s1 = puzzle
    li  $s2, GRIDSIZE              # s2 = GRIDSIZE
    li  $t0, 1
    sll $t0, $t0, $s2       # 1 << GRIDSIZE
    sub $s3, $t0, 1     # s3 = ALL_VALUES = (1 << GRIDSIZE) - 1

    li  $s4, 0          # s4 = i = 0
bd_i1_loop_start:
    bge $s4, $s2, bd_i1_loop_end    # !(i < GRIDSIZE)
bd_i1_loop_body:
    li  $s5, 0          # s5 = acc = 0
    li  $s6, 0          # s6 = j = 0
bd_j1_loop_start:
    bge $s6, $s2, bd_j1_loop_end    # !(j < GRIDSIZE)
bd_j1_loop_body:
    mul $t0, $s4, $s2       # i*GRIDSIZE
    add $t0, $t0, $s6       # i*GRIDSIZE + j
    mul $t0, $t0, 2         # sizeof(unsigned short)*(i*GRIDSIZE + j)
    add $t0, $s0, $t0       # &current_board[i*GRIDSIZE + j]
    lhu $s7, 0($t0)         # s7 = value = current_board[i*GRIDSIZE + j]

    move    $a0, $s7
    jal has_single_bit_set
    beq $v0, $0, bd_j1_loop_increment   # if (!hsbs(value)) continue
    xor $s5, $s5, $s7

bd_j1_loop_increment:
    add $s6, $s6, 1     # ++ j
    j   bd_j1_loop_start
bd_j1_loop_end:
    bne $s5, $s3, bd_return_false   # if (acc != ALL_VALUES) return false

    li  $s5, 0          # s5 = acc = 0
    li  $s6, 0          # s6 = j = 0
bd_j2_loop_start:
    bge $s6, $s2, bd_j2_loop_end    # !(j < GRIDSIZE)
bd_j2_loop_body:
    mul $t0, $s6, $s2       # j*GRIDSIZE
    add $t0, $t0, $s4       # j*GRIDSIZE + i
    mul $t0, $t0, 2
    add $t0, $s0, $t0       # &current_board[j*GRIDSIZE + i]
    lhu $s7, 0($t0)     # s7 = value = current_board[j*GRIDSIZE + i]

    move    $a0, $s7
    jal has_single_bit_set
    beq $v0, $0, bd_j2_loop_increment   # if (!hsbs(value)) continue
    xor $s5, $s5, $s7

bd_j2_loop_increment:
    add $s6, $s6, 1     # ++ j
    j   bd_j2_loop_start
bd_j2_loop_end:
    bne $s5, $s3, bd_return_false   # if (acc != ALL_VALUES) return false

bd_i1_loop_increment:
    add $s4, $s4, 1     # ++ i
    j   bd_i1_loop_start
bd_i1_loop_end:
    li  $s4, 0          # s4 = i = 0
bd_i2_loop_start:
    bge $s4, $s2, bd_i2_loop_end    # !(i < GRIDSIZE)
bd_i2_loop_body:
    li  $t0, 2          # sizeof(short)
    mul $t0, $t0, $s2
    mul $t0, $t0, $s2       # sizeof(unsigned short board[GRIDSIZE*GRIDSIZE])
    add $s3, $s1, $t0       # s3 = &(puzzle->constraints)

    add $t0, $s4, 1     # i+1
    add $t1, $s2, 2     # GRIDSIZE+2
    mul $t0, $t0, $t1       # (i+1)*(GRIDSIZE+2)
    mul $t0, $t0, 2
    add $t0, $t0, $s3       # &puzzle->constraints[(i+1)*(GRIDSIZE+2) + 0]
    lhu $t9, 0($t0)     # t9 = left_constraint = puzzle->constraints[(i+1)*(GRIDSIZE+2) + 0]
    li  $s5, 0          # s5 = count = 0
    li  $s6, 0          # s6 = last = 0

    li  $s7, 0          # s7 = j = 0
bd_j3_loop_start:
    bge $s7, $s2, bd_j3_loop_end    # !(j < GRIDSIZE)
bd_j3_loop_body:
    mul $t0, $s4, $s2       # i*GRIDSIZE
    add $t0, $t0, $s7       # i*GRIDSIZE + j
    mul $t0, $t0, 2
    add $t0, $s0, $t0       # &current_board[i*GRIDSIZE + j]
    lhu $t0, 0($t0)     # t0 = current = current_board[i*GRIDSIZE + j]
    ble $t0, $s6, bd_j3_loop_increment  # !(current > last)
    add $s5, $s5, 1     # count += 1
    move    $s6, $t0        # last = current
bd_j3_loop_increment:
    add $s7, $s7, 1     # ++ j
    j   bd_j3_loop_start
bd_j3_loop_end:
    bne $s5, $t9, bd_return_false   # if (count != left_constraint) return false

    add $t0, $s4, 1     # i+1
    add $t1, $s2, 2     # GRIDSIZE+2
    mul $t0, $t0, $t1       # (i+1)*(GRIDSIZE+2)
    add $t0, $t0, $s2       # (i+1)*(GRIDSIZE+2) + GRIDSIZE
    add $t0, $t0, 1     # (i+1)*(GRIDSIZE+2) + GRIDSIZE + 1
    mul $t0, $t0, 2
    add $t0, $t0, $s3       # &puzzle->constraints[(i+1)*(GRIDSIZE+2) + GRIDSIZE + 1]
    lhu $t9, 0($t0)     # t9 = right_constraint = puzzle->constraints[(i+1)*(GRIDSIZE+2) + GRIDSIZE + 1]
    li  $s5, 0          # s5 = count = 0
    li  $s6, 0          # s6 = last = 0

    sub $s7, $s2, 1     # s7 = j = GRIDSIZE - 1
bd_j4_loop_start:
    blt $s7, $0, bd_j4_loop_end # !(j >= 0)
bd_j4_loop_body:
    mul $t0, $s4, $s2       # i*GRIDSIZE
    add $t0, $t0, $s7       # i*GRIDSIZE + j
    mul $t0, $t0, 2
    add $t0, $s0, $t0       # &current_board[i*GRIDSIZE + j]
    lhu $t0, 0($t0)     # t0 = current = current_board[i*GRIDSIZE + j]
    ble $t0, $s6, bd_j4_loop_increment  # !(current > last)
    add $s5, $s5, 1     # count += 1
    move    $s6, $t0        # last = current
bd_j4_loop_increment:
    sub $s7, $s7, 1     # -- j
    j   bd_j4_loop_start
bd_j4_loop_end:
    bne $s5, $t9, bd_return_false   # if (count != right_constraint) return false
    add $t0, $s4, 1     # i+1
    mul $t0, $t0, 2
    add $t0, $t0, $s3       # &puzzle->constraints[i + 1]
    lhu $t9, 0($t0)     # t9 = top_constraint = puzzle->constraints[i + 1]
    li  $s5, 0          # s5 = count = 0
    li  $s6, 0          # s6 = last = 0

    li  $s7, 0          # s7 = j = 0
bd_j5_loop_start:
    bge $s7, $s2, bd_j5_loop_end    # !(j < GRIDSIZE)
bd_j5_loop_body:
    mul $t0, $s7, $s2       # j*GRIDSIZE
    add $t0, $t0, $s4       # j*GRIDSIZE + i
    mul $t0, $t0, 2
    add $t0, $s0, $t0       # &current_board[j*GRIDSIZE + i]
    lhu $t0, 0($t0)     # t0 = current = current_board[j*GRIDSIZE + i]
    ble $t0, $s6, bd_j5_loop_increment  # !(current > last)
    add $s5, $s5, 1     # count += 1
    move    $s6, $t0        # last = current
bd_j5_loop_increment:
    add $s7, $s7, 1     # ++ j
    j   bd_j5_loop_start
bd_j5_loop_end:
    bne $s5, $t9, bd_return_false   # if (count != top_constraint) return false

    add $t0, $s2, 1     # GRIDSIZE+1
    add $t1, $s2, 2     # GRIDSIZE+2
    mul $t0, $t0, $t1       # (GRIDSIZE+1)*(GRIDSIZE+2)
    add $t0, $t0, $s4       # (GRIDSIZE+1)*(GRIDSIZE+2) + i
    add $t0, $t0, 1     # (GRIDSIZE+1)*(GRIDSIZE+2) + i + 1
    mul $t0, $t0, 2
    add $t0, $t0, $s3       # &puzzle->constraints[(GRIDSIZE+1)*(GRIDSIZE+2) + i + 1]
    lhu $t9, 0($t0)     # t9 = bottom_constraint = puzzle->constraints[(GRIDSIZE+1)*(GRIDSIZE+2) + i + 1]
    li  $s5, 0          # s5 = count = 0
    li  $s6, 0          # s6 = last = 0

    sub $s7, $s2, 1     # s7 = j = GRIDSIZE - 1
bd_j6_loop_start:
    blt $s7, $0, bd_j6_loop_end # !(j >= 0)
bd_j6_loop_body:
    mul $t0, $s7, $s2       # j*GRIDSIZE
    add $t0, $t0, $s4       # j*GRIDSIZE + i
    mul $t0, $t0, 2
    add $t0, $s0, $t0       # &current_board[j*GRIDSIZE + i]
    lhu $t0, 0($t0)     # t0 = current = current_board[j*GRIDSIZE + i]
    ble $t0, $s6, bd_j6_loop_increment  # !(current > last)
    add $s5, $s5, 1     # count += 1
    move    $s6, $t0        # last = current
bd_j6_loop_increment:
    sub $s7, $s7, 1     # -- j
    j   bd_j6_loop_start
bd_j6_loop_end:
    bne $s5, $t9, bd_return_false   # if (count != bottom_constraint) return false
bd_i2_loop_increment:
    add $s4, $s4, 1
    j   bd_i2_loop_start
bd_i2_loop_end:
    li  $v0, 1          # return true
    j   bd_return
bd_return_false:
    li  $v0, 0          # return false
bd_return:
    lw  $ra, 0($sp)
    lw  $s0, 4($sp)
    lw  $s1, 8($sp)
    lw  $s2, 12($sp)
    lw  $s3, 16($sp)
    lw  $s4, 20($sp)
    lw  $s5, 24($sp)
    lw  $s6, 28($sp)
    lw  $s7, 32($sp)
    add $sp, $sp, 36
    jr $ra

# has single bit set ###########################################
#
# argument $a0: bit mask
has_single_bit_set:
    beq     $a0, $0, has_single_bit_set_iszero
    sub     $v0, $a0, 1             # $v0: b-1
    and     $v0, $a0, $v0           # $v0: b & (b-1)
    not     $v0, $v0                # $v0: !(b & (b-1))
    # if $v0 is zero, return zero
    bne     $v0, -1, has_single_bit_set_iszero
    li      $v0, 1
    j       has_single_bit_set_done
has_single_bit_set_iszero:
    li      $v0, 0
has_single_bit_set_done:
    jr      $ra



# increment heap ###############################################
#
# argument $a0: pointer to current board to check
increment_heap:
    sub $sp, $sp, 4
    sw  $ra, 0($sp) # save $ra on stack

    li  $t0, GRIDSIZE
    mul $t0, $t0, $t0               # GRIDSIZE * GRIDSIZE
    mul $a1, $t0, 2
    add $a1, $a0, $a1               # new_board = old_board + GRIDSIZE*GRIDSIZE

    jal copy_board

    move $v0, $v0                   # // output the output of copy_board
    lw  $ra, 0($sp)
    add $sp, $sp, 4
    jr $ra


# copy board ###################################################
#
# argument $a0: pointer to old board
# argument $a1: pointer to new board
copy_board:
    li  $t0, GRIDSIZE
    mul $t0, $t0, $t0               # GRIDSIZE * GRIDSIZE
    li  $t1, 0                      # i = 0
ih_loop:
    bge $t1, $t0, ih_done           # i < GRIDSIZE*GRIDSIZE

    mul $t2, $t1, 2                 # i * sizeof(unsigned short)
    add $t3, $a0, $t2               # &old_board[i]
    lhu $t3, 0($t3)                 # old_board[i]

    add $t4, $a1, $t2               # &new_board[i]
    sh  $t3, 0($t4)                 # new_board[i] = old_board[i]

    addi $t1, $t1, 1                # i++
    j    ih_loop
ih_done:
    move $v0, $a1
    jr $ra
