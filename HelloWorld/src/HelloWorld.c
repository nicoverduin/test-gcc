/**
 * @file    HelloWorld.c
 * @author  nico verduin
 * @brief   example program to get started (i.e. Hello World)
 * @version 1.0
 * @date    16-5-2023
 */

#include <stdio.h>

extern void myFunction();
/**
 * @brief  mainline of the program
 * @return 0
 */
int main(void) {
  // priknt our hello world
  printf("Hello World!!\n");
  // print from the function
  myFunction();

  return 0;
}