
ns topic-tag.style.widget $ :require
  [] hsl.core :refer $ [] hsl

def textbox $ {} (:border |none)
  :width |100%
  :font-size |16px
  :line-height 2
  :padding "|0 8px"
  :box-shadow $ str "|0 0 1px "
    hsl 0 0 40
  :outline |none

def button $ {} (:border |none)
  :outline |none
  :background-color $ hsl 200 80 50
  :color |white
  :line-height 2
  :font-size |14px
  :padding "|0 8px"
  :cursor |pointer