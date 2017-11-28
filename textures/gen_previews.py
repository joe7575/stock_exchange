from PIL import Image
import glob, os

size = 128, 128

for infile in glob.glob("*.png"):
    if "preview" in infile:
        continue
    name, ext = os.path.splitext(infile)
    src = Image.open(infile)
    dst = Image.new("RGBA", (20, 36), (0,0,0,0))

    # (left,upper,right,lower)
    # head
    img = src.crop((8,8,16,16))
    dst.paste(img, (6,2,14,10))
    # mask
    img = src.crop((40,8,48,16))
    try:
        dst.paste(img, (6,2,14,10), img)
    except:
        pass
    # body
    img = src.crop((20,20,28,32))
    dst.paste(img, (6,10,14,22))
    # legs
    img = src.crop((4,20,8,32))
    dst.paste(img, (6,22,10,34))
    dst.paste(img, (10,22,14,34))
    #arms
    img = src.crop((44,20,48,32))
    dst.paste(img, (2,10,6,22))
    dst.paste(img, (14,10,18,22))
    
    dst.save(name + "_preview.png", "PNG")
