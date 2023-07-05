set print array on
set print array-indexes on

set logging file gdb_output.txt
set logging on

## BREAKS ##
break go_sort
b .for_i_to_count
b 87
b .for_go_sort


###################################

run sort.input sort.output
display *(int*)($rbp - 4)

define array
  set $num_elements = $arg0
  set $ptr = $arg1

  set $i = 0
  while $i < $num_elements
    printf "[%d]: %x\n", $i, *(int*)($ptr + $i)
    set $i = $i + 1
  end
end

########### hooks ###########
define hook-next
  refresh
end

