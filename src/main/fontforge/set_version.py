from sys import argv; 
import fontforge
from datetime import datetime

font = fontforge.open(argv[1])

print("existing:")
print(f"\tfontname: {font.fontname}")
print(f"\tfullname: {font.fullname}")
print(f"\tcopyright: {font.copyright}")
print(f"\tversion: {font.version}")

font.copyright = f"© copyright {datetime.today().strftime('%Y')} Terrence Curran http://www.grilledcheese.com"
font.version = datetime.today().strftime('%Y.%m.%d')

print("new:")
print(f"\fontname: {font.fontname}")
print(f"\fullname: {font.fullname}")
print(f"\tcopyright: {font.copyright}")
print(f"\tversion: {font.version}")

font.save()