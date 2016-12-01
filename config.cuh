#ifndef MAP_REDUCE_CUH
#define MAP_REDUCE_CUH

// Configure GPU parameters
#define GRID_SIZE 1024
#define BLOCK_SIZE 1024

// Set number of input elements, number of output elements, and number of keys
// per input element
#define NUM_INPUT 100000
#define NUM_OUTPUT 1
#define NUM_KEYS 1

// Example of custom input type
struct Word_Count {
    char ch;
};

// Setting input, output, key, and value types
typedef Word_Count input_type;  //you can either give wordCount or char
typedef int output_type;
typedef char key_type;
typedef int value_type;

// Do not edit below this line

struct KeyValuePair {
   key_type key;
   value_type value;
};

void runMapReduce(input_type *input, output_type *output);

#endif
