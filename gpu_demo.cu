#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "config.cuh"

using namespace std;

/*
 * Mapping function to be run for each input. The input must be read from memory
 * and the the key/value output must be stored in memory at pairs. Multiple
 * pairs may be stored at the next postiion in pairs, but the maximum number of
 * key/value pairs stored must not exceed NUM_KEYS.
 */
__device__ void mapper(input_type *input, KeyValuePair *pairs) 
{
    // We set the key of each input to 0.
    pairs->key = 0;
    char ch = input->ch;	
	//pairs->key = ch;
    // We check if the input array has a space or a new line and set the value accordingly.
	//If so this will count the number of words in a file.
    if (ch == ' '||ch == '\n') 
	{ 
		pairs->value = 1;
	} 
     
	else 
	{
        pairs->value = 0;
    }
}

/*
 * Reducing function to be run for each set of key/value pairs that share the
 * same key. len key/value pairs may be read from memory, and the output
 * generated from these pairs must be stored at output in memory.
 */
__device__ void reducer(KeyValuePair *pairs, int len, output_type *output) 
{
    int wordCount = 0;
    for (KeyValuePair *pair = pairs; pair != pairs + len; pair++) 
	{
        if(pair->value == 1) 
		{
            wordCount++;
        }
    }
    // After calculating number of words in an input file, we will move the wordCount into the output variable.
    *output = wordCount;
}


/*
 * Main function that runs a map reduce job.
 */
int main(int argc, char const *argv[]) 
{
    printf("\n My first Program. I am here\n");
	
    // Allocate host memory
    size_t input_size = NUM_INPUT * sizeof(input_type);
    size_t output_size = NUM_OUTPUT * sizeof(output_type);
    input_type *input = (input_type *) malloc(input_size);
    output_type *output = (output_type *) malloc(output_size);

    
	
	//Reading an input file and copying it into an input array
	FILE *f;
    char c;
	//char input[1000000];
    f=fopen("test.txt","rt");
	
	int i=0;
    while((c=fgetc(f))!=EOF)
	{
        //printf("%c",c);
		input[i].ch = c;
		i++;
    }
	
	printf("\n The array is:  %s", input);
	 fclose(f);

    // Run the Map Reduce Job
    runMapReduce(input, output);

    // Iterate through the output array
    for (size_t i = 0; i < NUM_OUTPUT; i++) 
	{
        printf("The total number of words in the file are: %d\n", output[i]);
    }

    // Free host memory
    free(input);
    free(output);

    return 0;
}
