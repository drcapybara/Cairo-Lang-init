# instructs compiler to use output builtin
%builtins output

from starkware.cairo.common.serialize import serialize_word


# main is the starting point for a cario program
# 
func main{output_ptr : felt*}():
    
    
    # serialize word takes value x and writes to memory cell pointed to by
    # output ptr, and returns output_ptr + 1
    serialize_word(6 / 3)
    
    # this next call implicitly writes to memory cell designated by previous
    # return value of output_ptr + 1

    # cairo math happens modulo P, so division will always produce an x s.t.
    # 3 * x = 7, which produces a valid integer solution under modulo P
    serialize_word(7 / 3)
    return ()
end



# function array_sum accepts array which is type felt (pointer), so arr points
# to arr with size number of elements
# returns sum, end keyword denotes scope
func array_sum(arr : felt*, size) -> (sum):
    if size == 0:
        #parenthesis required for return statement
        return (sum=0)
    end

    # recursive call to array_sum, arr = arr[0], 
    let (sum_of_rest) = array_sum(arr=arr + 1, size=size - 1)
    #[...] dereferences to value of memory address which is first element of arr
    # recurisvely calls array_sum with arr+1 which is next element in arr
    # recursion stops when size == 0
    return (sum=[arr] + sum_of_rest)
end