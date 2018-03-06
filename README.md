# Binar2Hex-Converter-
A Simple Bit Calculator 

The program is a simple bit calculator. It will set a specific bit of binary value zero to 1, or multiple bits at the same time and return a hexdecimal value.
For example, you have a 16-bit binary zero, and you want to set the 14th bit to 1 and the program will return (4 0 0 0); or you want set 15th, 14th, 9th, 7th 2nd bit to 1, it will return (C 2 8 4)

The program is implemented in scheme, so you will need a scheme interpreter to run it.

The program needs the following built-in procedures:  
  quotient
	remainder
	apply
	max
	set-difference
  
  Invoke "convert" procedure to do the calculation
  Convert procedure will either take in only a constant or a list of numbers
