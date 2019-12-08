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

### Put these in your data segment
inventory:   .half 0:30
powerup:     .half 0:200
puzzle:      .half 0:164
heap:        .half 0:65536
# 900 x 900 array filled with distances between cells
# cells labelled in row major order
distance:    .word 0:820000
# 900 x 900 array
# next[u][v] = next vertex you must visit in shortest path from u to v
next:        .word 0:820000
arenamap:    .word 0:900
target_x:    .half 0:1
target_y:    .half 0:1

.text
main:
	# Construct interrupt mask
	li      $t4, 0
	or      $t4, $t4, TIMER_INT_MASK # request timer
	or      $t4, $t4, BONK_INT_MASK # request bonk
	or      $t4, $t4, REQUEST_PUZZLE_INT_MASK	        # puzzle interrupt bit
	or      $t4, $t4, 1 # global enable
	mtc0    $t4, $12

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

    # sw 		$s2, SPIMBOT_PRINT_INT($0)

	lw 		$v0, TIMER($0)
	add 	$v0, $v0, 50
	sw 		$v0, TIMER($0)

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

	mul 	$s5, $s2, 30 			# $s5 = uy * 30
	add 	$s5, $s5, $s1 			# $s5 = ux + s5

	mul 	$s6, $s4, 30 			# $s6 = vy * 30
	add 	$s6, $s6, $s3 			# $s6 = vx + s6
	mul 	$s7, $s6, 900			# $s7 = 900 * s6

	add 	$s7, $s5, $s7			# $s7 = u stuff + v stuff
	add 	$s0, $s0, $s7			# s0 = next[u][v]
	li 		$s6, 123456
	sw 		$s6, SPIMBOT_PRINT_INT($0)
	sw 		$s0, SPIMBOT_PRINT_INT($0)

	sub		$s6, $s0, $s5 			# $s6 = next[u][v] - u




set_timer:
	lw 		$v0, TIMER($0)
	add 	$v0, $v0, 10000
	sw 		$v0, TIMER($0)


    j        interrupt_dispatch    # see if other interrupts are waiting


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

# Floyd Warshall ###################################################
#
# argument $a0: pointer to arena map
#
# Initialize distance array dist[900][900] with MAXINT
# Initialize next array next[900][900] with -1
#
# for row in range(num_rows)
# 	for column in range(num_columns)
# 		curr_cell =  map[row][column]
# 		distance[curr_cell][curr_cell] = 0
# 		next[curr_cell][curr_cell] = curr_cell
#
# 		for adjacent_cell to current cell:
# 			if cell is a valid cell (not an obstacle or off the map):
# 				distance[curr_cell][adjacent_cell] = 1
# 				next[curr_cell][adjacent_cell] = adjacent_cell
#
# for k in range(30)
# 	for i in range(30)
# 		for j in range(30)
# 			if distance[i][j] > distance[i][k] + distance[k][j] then
#               distance[i][j] ← distance[i][k] + distance[k][j]
#                next[i][j] ← next[i][k]

floyd_warshall:
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
    li $s0, 0 # rows
    li $s2, 900 # |V|

init_floyd_warshall_loop_rows:
    beq $s0, $s2, start_floyd_warshall
    li $s1, 0 # columns

init_floyd_warshall_loop_columns:
    beq $s1, $s2, init_floyd_warshall_loop_rows_inc
    # find offset for $s0, $s1
    # offset = 900 * $s0 + $s1
    li $s3, 900
    mul $s3, $s3, $s0
    add $s3, $s3, $s1
    la $s4, distance
    # &distance[u][v]
    add $s4, $s4, $s3
    # Max int
    li $s5, 65536
    sw $s5, 0($s4) # distance[u][v] = infinity
    la $s4, next
    # &next[u][v]
    add $s4, $s4, $s3
    # None
    li $s5, -1
    sw $s5, 0($s4) # next[u][v] = None

init_floyd_warshall_loop_columns_inc:
    add $s1, $s1, 1
    j init_floyd_warshall_loop_columns

init_floyd_warshall_loop_rows_inc:
    add $s0, $s0, 1
    j init_floyd_warshall_loop_rows

start_floyd_warshall:
    li $s0, 0 # row
    li $s2, 30 # max row & max column

start_floyd_warshall_loop_rows:
    beq $s0, $s2, floyd_warshall_part_2 # if row == 30, end loop
    li $s1, 0 # column

start_floyd_warshall_loop_columns:
    beq $s1, $s2, start_floyd_warshall_loop_rows_inc # if col == 30, increment rows
    li $s3, 30
    mul $s3, $s3, $s0 # row * 30
    add $s3, $s3, $s1 # cell number = row * 30 + column

    # offset = 900 * $s3 + $s3
    li $s4, 900
    mul $s4, $s4, $s3
    add $s4, $s4, $s3

    la $s5, distance
    add $s5, $s4, $s5 # &distance[u][u]
    sw $0, 0($s5) # distance[u][u] = 0

    la $s5, next # &next
    add $s5, $s4, $s5 # &next[u][u]
    sw $s3, 0($s5) # next[u][u] = u

#   if cell is a valid cell (not an obstacle or off the map):
# 		distance[curr_cell][adjacent_cell] = 1
# 		next[curr_cell][adjacent_cell] = adjacent_cell

check_left:
    sub $s6, $s3, 1
    blt $s6, $0, check_right

    move $a0, $s6
    jal get_tile_type_at_loc
    beq $v0, $0, check_right # if obstacle, continue

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    li $a2, 1 # $a2 = 1
    jal store_to_distance # distance[u][v] = 1

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    move $a2, $s6 # $a2 = v
    jal store_to_next # next[u][v] = v

check_right:
    add $s6, $s3, 1
    li $t0, 900
    bge $s6, $t0, check_up

    move $a0, $s6
    jal get_tile_type_at_loc
    beq $v0, $0, check_right # if obstacle, continue

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    li $a2, 1 # $a2 = 1
    jal store_to_distance # distance[u][v] = 1

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    move $a2, $s6 # $a2 = v
    jal store_to_next # next[u][v] = v

check_up:
    sub $s6, $s3, 30
    blt $s6, $0, check_down

    move $a0, $s6
    jal get_tile_type_at_loc
    beq $v0, $0, check_right # if obstacle, continue

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    li $a2, 1 # $a2 = 1
    jal store_to_distance # distance[u][v] = 1

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    move $a2, $s6 # $a2 = v
    jal store_to_next # next[u][v] = v

check_down:
    add $s6, $s3, 30
    li $t0, 900
    bge $s6, $t0, start_floyd_warshall_loop_columns_inc

    move $a0, $s6
    jal get_tile_type_at_loc
    beq $v0, $0, check_right # if obstacle, continue

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    li $a2, 1 # $a2 = 1
    jal store_to_distance # distance[u][v] = 1

    move $a0, $s3 # $a0 = u
    move $a1, $s6 # $a1 = v
    move $a2, $s6 # $a2 = v
    jal store_to_next # next[u][v] = v

start_floyd_warshall_loop_columns_inc:
    add $s1, $s1, 1
    j start_floyd_warshall_loop_columns

start_floyd_warshall_loop_rows_inc:
    add $s0, $s0, 1
    j start_floyd_warshall_loop_rows

# for k ($s0) in range(900)
# 	for i ($s1) in range(900)
# 		for j ($s2) in range(900)
# 			if distance[i][j] > distance[i][k] + distance[k][j] then
#               distance[i][j] ← distance[i][k] + distance[k][j]
#               next[i][j] ← next[i][k]
floyd_warshall_part_2:
    li $s0, 0 # k = 0

floyd_warshall_part_2_k_loop:
    li $s1, 0 # i = 0
    # check if k == 900
    li $t0, 900
    beq $s0, $t0, floyd_warshall_done

floyd_warshall_part_2_i_loop:
    li $s2, 0 # j = 0
    # check if i == 900
    li $t0, 900
    beq $s1, $t0, floyd_warshall_part_2_k_loop_inc

floyd_warshall_part_2_j_loop:
    # check if j == 900
    li $t0, 900
    beq $s2, $t0, floyd_warshall_part_2_i_loop_inc

floyd_warshall_part_2_inner_loop:
    # get distance[i][j]
    move $a0, $s1
    move $a1, $s2
    jal get_from_distance
    move $t0, $v0
    # get distance[i][k]
    move $a0, $s1
    move $a1, $s0
    jal get_from_distance
    move $t1, $v0
    # get distance[k][j]
    move $a0, $s2
    move $a1, $s0
    jal get_from_distance
    move $t2, $v0

    # get distance[i][k] + distance[k][j]
    add $t3, $t1, $t2

    # if distance[i][j] > distance[i][k] + distance[k][j] continue
    ble $t0, $t3, floyd_warshall_part_2_j_loop_inc

# distance[i][j] ← distance[i][k] + distance[k][j]
# next[i][j] ← next[i][k]
floyd_warshall_relax_edge:
    move $a0, $s1
    move $a1, $s2
    move $a2, $t3
    jal store_to_distance # distance[i][j] ← distance[i][k] + distance[k][j]

    move $a0, $s1
    move $a0, $s0
    jal get_from_next # next[i][k]
    move $t0, $v0

    move $a0, $s1
    move $a1, $s2
    move $a2, $t0
    jal store_to_next # next[i][j] ← next[i][k]

floyd_warshall_part_2_j_loop_inc:
    add $s2, $s2, 1 # j++
    j floyd_warshall_part_2_j_loop

floyd_warshall_part_2_i_loop_inc:
    add $s1, $s1, 1 # j++
    j floyd_warshall_part_2_i_loop

floyd_warshall_part_2_k_loop_inc:
    add $s0, $s0, 1 # k++
    j floyd_warshall_part_2_k_loop


# $a0 = u cell number (30*y + x)
# $a1 = v cell number (30*y + x)
# $a2 = value to store
store_to_distance:
    la $t0, distance # &distance

    li $t1, 900
    mul $t1, $t1, $a0
    add $t1, $t1, $a1
    mul $t1, $t1, 4 # word align
    add $t1, $t1, $t0

    sw $a2, 0($t1)

    jr $ra

# $a0 = u cell number (30*y + x)
# $a1 = v cell number (30*y + x)
# $a2 = value to store
store_to_next:
    la $t0, next # &distance

    li $t1, 900
    mul $t1, $t1, $a0
    add $t1, $t1, $a1
    mul $t1, $t1, 4 # word align
    add $t1, $t1, $t0

    sw $a2, 0($t1)

    jr $ra

# $a0 = u cell number (30*y + x)
# $a1 = v cell number (30*y + x)
get_from_distance:
    la $t0, distance # &distance

    li $t1, 900
    mul $t1, $t1, $a0
    add $t1, $t1, $a1
    mul $t1, $t1, 4 # word align
    add $t1, $t1, $t0

    lw $v0, 0($t1)

    jr $ra

# $a0 = u cell number (30*y + x)
# $a1 = v cell number (30*y + x)
get_from_next:
    la $t0, next # &distance

    li $t1, 900
    mul $t1, $t1, $a0
    add $t1, $t1, $a1
    mul $t1, $t1, 4 # word align
    add $t1, $t1, $t0

    lw $v0, 0($t1)

    jr $ra

# $a0 = cell number (30*y + x)
# $v0 = 0 if tile type is obstacle, not otherwise
get_tile_type_at_loc:
    la $t0, arenamap
    mul $t1, $a0, 4
    add $t1, $t1, $t0
    lh $t1, 2($t1)

    li $t2, 2 # OBSTACLE

    sub $v0, $t1, $t2

    jr $ra

floyd_warshall_done:
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
