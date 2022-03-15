# instructs compiler to use output builtin
%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word


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

# recursively multiply all even indexed elements in an array 
func array_product(arr : felt*, size) -> (product):
    if size == 0:
        return (product=1)
    end
    let (product_of_rest) = array_product(arr=arr + 2, size=size - 2)
    return (product=[arr] * product_of_rest)
end



func main{output_ptr : felt*}():
    const ARRAY_SIZE = 4

    # Allocate an array.
    let (ptr) = alloc()

    # [...] dereferences to array value
    # assert is used because values in memory cells are immutable and 
    # the assert case will both assign the value to the memory cell and then
    # pass because the value in the cell and the assigned value are the same,
    # assert will fail otherwise. 
    assert [ptr] = 9999999
    assert [ptr + 1] = 16
    assert [ptr + 2] = 25777876566898
    assert [ptr + 3] = 259999999

    # Call array_sum to compute the sum of the elements.
    # let (sum) = array_sum(arr=ptr, size=ARRAY_SIZE)

    let (product) = array_product(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    #serialize_word(sum)

    serialize_word(product)

    return ()
end



