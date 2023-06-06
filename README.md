# elixir-calculator
An Elixir built calculator that can can evaluate "natural language" expressions and keep things in memory

The project aims at exploring Elixir's string manipulation and functional nature.

## Functionalities
### Evaluate expressions

The program can take an expression such as **"1 + 2 * 3"** and give its result as a floating point number.

 ![alt text](https://drive.google.com/uc?export=view&id=1Xb4dztH_FAXHCEPc9G-ie0Y8zuUq2Fbd)
 
 You could even do it with little caution, lets say **"1 ++++ 3 --6    \*(2^2)"**
 
 ![alt text](https://drive.google.com/uc?export=view&id=1uDJ918waDGzDeZBf31_ByB89WUY8pUIO)
 
 ### Save things to memory
 
 **You can save a word, or character, as a value**. The program will print it to the console so you can keep track of things you have saved before
 
 ![alt text](https://drive.google.com/uc?export=view&id=1k30Gaa_95hJEv7-4xCVPJyuolYu93aJT)
 
 There's also the possibility to **update a saved value and reference other saved values**
 
 ![alt text](https://drive.google.com/uc?export=view&id=1MSnJyzlDMIHOwuCcpgg-x-eh5zc3vT1w)
 
 Would it not be nice to be able to **save expressions' results** itself. It is possible, see:
 
 ![alt text](https://drive.google.com/uc?export=view&id=1W0qRLh8zGhns6nFWCGVHXMETk5nIRZ-d)
 
 ### Supported commands
 
 The program can interpret a few commands, bellow's the list of all the supported commands and what they do
 - **/help**: this command prints to the console helpful information, such as syntax rules and the calculators functionalities list
 - **/exit**: allows exiting the program loop. Notice that it will erase all saved values from the calculator's memory

## Next steps
- [ ] save and load saved values to/from file
    - [ ] **/load**: loads saved values from given file
    - [ ] **/save**: saves current saved values to given file
- [x] command **"/clear"**: cleans terminal view
- [x] command **"/erase"**: delete all saved values from memory
- [x] allow expressions with redundant parantheses, such as: 1 - (-1)
- [ ] enhance terminal looks: input field for usage, memory section and a result section
