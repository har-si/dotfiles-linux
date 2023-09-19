# Useful Vim Shortcuts 

## Navigations 
- 0 = Beginning of the line
- $ = End of line

- f + char = Find the specific character 
- F + char = Find backward 
- ; = repeat forward
- , = repeat backward

- A = Edit on the last line of the word 
- a = Edit after the selection 
- o = open a new line below and go to insert mode
- O = open a new line above and go to insert mode

- w = go forward to next word 
- W = go forward to next word separated with whitespace
- b = go back to next word
- B = go back to newt word separated with whitespace
- e = end of the next word
- ge = end of the before word

- } = go down a paragraph
- { = go up a paragraph

- G = last line of the file
- gg = last line of the file
- num + G = go to specific line number

- % = go to the pair (){}[]

- ctrl + f = forward one full screen
- ctrl + b = backward one full screen
- ctrl + d = forward half a screen
- ctrl + u = backward half a screen

- ctrl + e = scroll down without moving the cursor
- ctrl + y = scroll up without moving the cursor

## Search
- / = search
- n = next search results
- N = back search results
- * = search for current words where the cursor is
- :nohl = remove the search highlights

## deleting and editing
- d + movement = delete; movement can be {h j k l $ 0 e G g}
- dd = delete the whole line
- D = delete from cursor to the end of line (similar to d$)
- x = delete a single character

- c + movement = change (will delete and switch to insert mode)

- . = repeat last delete

- r + char = replace the current selected text with the char

## undo and redo
- u = undo
- ctrl + r = redo

## copy and paste
- y + movement = yank or copy
- yy = copy whole line
- Y = copy from cursor to end of line
note: when you delete you are also copying it
- p = paste

## others
- ~ = change the case of the highlighted character
- U = change the highlighted to uppercase
- gu = change the highlighted to lowercase

## text object (search this one)
- i = inside
- a = around

## Important settings
- set number
- set relativenumber
- set clipboard+=unnamedplus

