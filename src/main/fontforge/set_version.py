from sys import argv; 
import fontforge
from datetime import datetime

font = fontforge.open(argv[1])

print("existing:")
print(f"\tfontname: {font.fontname}")
print(f"\tfullname: {font.fullname}")
print(f"\tcopyright: {font.copyright}")
print(f"\tversion: {font.version}")
print(f"\sfnt_names: {font.sfnt_names}")

language = 'English (US)'
copyright_string = f"© copyright {datetime.today().strftime('%Y')} Terrence Curran grilledcheese.com "
version_string = datetime.today().strftime('%Y.%m.%d')

font.copyright = copyright_string
font.version = version_string
# font.appendSFNTName('English (US)', 'Copyright', unicode(copyright_string, 'utf-8').encode('utf-16-be'))

print(f'copyright_string: {isinstance(copyright_string, str)}')

# I don't know why the below line doesn't work, it appears very fussy for some reason
# font.appendSFNTName(language, 'Copyright', copyright_string)
font.appendSFNTName(language, 'Copyright', "© copyright 2022 Terrence Curran grilledcheese.com")
font.appendSFNTName(language, 'Version', version_string)

#for x in font.sfnt_names:
#    if x[1] == 'Copyright':
#        font.appendSFNTName(x[0], x[1], copyright_string)


print("new:")
print(f"\tfontname: {font.fontname}")
print(f"\tfullname: {font.fullname}")
print(f"\tcopyright: {font.copyright}")
print(f"\tversion: {font.version}")
print(f"\sfnt_names: {font.sfnt_names}")

font.save()