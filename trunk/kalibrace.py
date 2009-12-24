from PIL import Image,ImageDraw

def kobr(x,y, r=10, w=800, h=600):
  i = Image.new('RGB', (w,h))
  d = ImageDraw.Draw(i)
  d.rectangle((x-r/2, y-r/2, x+r/2, y+r/2), fill=(255, 0, 0))
  return i