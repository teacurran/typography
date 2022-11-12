from sys import argv; 
import fontforge

font = fontforge.open(argv[1])
font.generate(argv[2])
