Num‿Pos‿SVG‿Ge‿Elt‿At‿Enc‿Rect‿Text‿TSize‿Path ← •Import "svg.bqn"

# Graph components
Background ← <"fill=white" Rect ⊢
Clip ← <"defs" Enc ("clipPath"At"id=clip") Enc Rect

Box ← "stroke-width=1.2|stroke=#111|fill="⊸∾ ⊸ Rect
Outline ← <"none" Box ⊢

Legend ← {
  outer‿place‿spacing‿pad‿width‿label‿Samples ← 𝕩
  y ← pad+spacing×0.5+↕n←≠label
  dim ← ⟨width,(2×pad)+spacing×n⟩
  pl ← (10‿6×¬⊸-place) + place×outer-dim
  ltr ← "transform=translate("∾")"∾˜∾⟜","⊸∾´Num pl
  back ⇐ ("white|"∾ltr) Box 0‿0≍dim
  main ⇐ (ltr∾"|text-anchor=start|font-size=13px") Ge ⟨
    "fill=white|opacity=0.6" Rect (1.3÷2‿¯1)+0‿0≍dim
    Samples y
    y (Pos 36⊸⋈)⊸Text¨ label
  ⟩
}

Tick ← {
  off‿dim‿orient‿tpos‿ttext ← 𝕩
  s ← 'h'=orient
  Lines ← {
    h ← 'h'=𝕨
    P ← ⌽⌾(2⊸↑)⍟h ∾⟜((¬h)⊏⍉off≍dim)
    (Path·∾("M "∾𝕨)∾¨Num∘P)¨ 𝕩
  }
  dist ← (s⊏dim)(-⌊⊢)tpos-s⊏off
  Filter ← ≤⟜dist/¨⊢
  to ← 9.5‿¯6 + ⌽off+dim×0‿1
  Vals ← { "text-anchor=end" Ge⍟𝕨 (Pos 𝕨⌽⋈⟜(𝕨⊑to))⊸Text¨´ 𝕩 }
  ⟨
    "stroke-width=0.3|stroke=#555" Ge orient Lines¨ 1 Filter tpos
    "font-size=11px" Ge s Vals¨ tpos ⋈¨○(¯0.01⊸Filter) ttext
  ⟩
}

_inRange ← {(⌈⊸(⊣+↕∘¬˜)⟜⌊´ (-⊸⋈1e¯10)+⊢)⌾(𝔽⁼)}
GetTicks ← {
  0𝕊𝕩: # Linear
    dist ← {(⊑∘⍋⟜𝕩-1˙)⊸⊑ 1‿2‿5 × ⌊⌾(10⋆⁼⊢) 𝕩} 6 ÷˜ -˜´ 𝕩
    dist⊸×_inRange 𝕩;
  1𝕊𝕩: # Log
    p ← ⟨⋈1, 1‿2‿5, ∧1.5‿7∾1+↕5, ∧1.2‿1.5‿2.5∾1+↕9⟩
    i ← 0⌈1-˜ ⊑ (≠¨p) ⍋ 12 ÷ -˜´ 10⋆⁼𝕩
    (1≥-˜´∘⍋)◶⊣‿⊢⟜𝕩 (i⊑p) (⥊×⌜˜) (10⋆⊢)_inRange 𝕩÷10‿1
}

# Name info
GetColors ← {
  nam ← ⋈"BQN"
  col ← ⋈"#2b7067"
  ce  ← ⟨"#e41a1c","#377eb8","#4daf4a","#984ea3"
         "#ff7f00","#ffff33","#a65628","#f781bf"⟩
  ni ← nam ⊐ 𝕩
  ni +↩ (≠ce)|⊒⊸×ni=≠nam  # Cycle through extra colors
  ni ⊏ col∾ce
}

ENum ← {∾⟜"e"⊸∾○Num´ (𝕩÷10⊸⋆)⊸((1<5e¯4+÷⟜10)◶⟨⋈,÷⟜10⊸⋈⟜(1⊸+)⟩)⌊10⋆⁼𝕩}
DispNum ← (2|1e¯9‿1e¯3‿1e4⊸⍋⌾<)◶Num‿ENum

Plot ⇐ { opts 𝕊 dat:
  ⟨title,x,y,⟨labels⟩⇐key⟩ ← opts
  order ← {⟨r⇐order⟩:r; ⟨⟨r⇐order⟩⇐key⟩:r; ⊢} opts
  BoundAxis ← ⊣ {⟨r⇐min⟩:r;¯∞}⊸⌈ {⟨r⇐max⟩:r;∞}⊸⌊
  col ← "stroke"⊸⋈¨ GetColors labels

  axes ← x‿y
  xcapt‿ycapt ← {𝕩.name}¨ axes
  splitx ← 1<≡xcapt
  alog ← {⟨r⇐log⟩:r; 1}¨ axes
  disp ← {⟨r⇐disp⟩:r; DispNum}¨ axes

  width ← 512
  off ← 60‿40 ⋄ end ← 20‿50
  dim ← width (⊣⋈×) 0.55
  out ← (-off)≍dim+off+end
  padb ← alog × padi ← 0‿20

  gr ← "stroke-width=2.6|font-size=14px|text-anchor=middle"
  ls ← "clip-path=url(#clip)|fill=none|stroke-linecap=round|stroke-linejoin=round"

  Log ← ⋆⁼⌾(alog⊸/) ({⟨R⇐Trans⟩:R; ⊢}⊑axes)⌾⊑
  dat ↩ 0‿0 ↓ Order dat
  xy ← <∘∾˘⍉dat
  fxy ← alog {1e¯9⊸∾⍟(0=≠)0⊸<⊸/𝕩}⍟⊣¨ axes ⊑⊸{⟨F⇐FilterMin⟩𝕊𝕩:F⊸/`𝕩;𝕩} xy
  bounds ← axes BoundAxis¨ (⌊´⋈⌈´)¨ fxy
  win ← -˜`¨ 0⌾(⊑1⊑⊢)⍟(¬1⊑alog) Log bounds
  ScaleI ← ¬⌾(1⊸⊑) ({𝕩÷˜𝕨-˜⊢}˝ ⍉>win)∘Log          # To [0,1]
  Scale ← padi + (dim-padb+padi) × ScaleI          # To pixels
  line ← (<≍˘)○Num´∘Scale˘ dat
  
  leg ← Legend {
    label ⇐ Order labels
    outer ⇐ dim
    place ⇐ (↕2‿2) ⊑∘⍒⊸⊑˜○⥊ (⌊´0⊸≤⊸/)¨ ≍˘⟜¬ ≤⟜(÷4)⊸/{𝔽⋈¬⊸𝔽}´ ScaleI xy
    width ⇐ (2<⌈´≠¨label)⊑60‿134 ⋄ spacing ⇐ 18 ⋄ pad ⇐ 6
    Samples ⇐ col ≍⊸Path⟜(∾"M h"∾¨Num)¨ (8∾∾⟜22)¨
  }

  ∾ ∾⟜(@+10)¨ (⥊out) SVG gr Ge ⟨
    Clip 0‿0≍dim
    Background out
    ⟨
      ((TSize 18)∾Pos⟨width÷2,¯19⟩) Text title
      { ¬splitx ? xcapt Text˜ Pos 0‿32+dim×0.5‿1
      ; P ← {0‿𝕨+dim×𝕩‿1}
        xc←xcapt Text˜⟜Pos¨ 32 P¨ 0.25‿0.75
        xc∾<"stroke-width=1|stroke=#555" At⊸Path ∾"M v"∾¨Num (18 P 0.5)∾22
      }
      ycapt Text˜ "transform"‿"rotate(-90)"∾Pos 0‿42-˜⌽dim×0‿¯0.5
    ⟩
    Tick {
      off⇐0‿0 ⋄ dim⇐dim
      orient⇐"vh"
      RoundDown ← {(⊑∘⍋⟜𝕩-1˙)⊸⊑1‿2‿5×⌊⌾(10⋆⁼⊢)𝕩}
      tval ← axes {⟨r⇐ticks⟩𝕊𝕩:r; 𝕩}¨ alog GetTicks⟜∧¨ Scale⁼0⋈¨dim
      tpos ⇐ Scale ticks ← (⍷∧⊑xy) {𝕨⌾⊑𝕩}⍟(10≥≠∘⊣) tval
      ttext ⇐ disp {𝕎⚇0𝕩}¨ {splitx?x.max-⍟(÷⟜2⊸<)¨⌾⊑𝕩;𝕩} ticks
    }
    leg.back
    ls Ge col ≍⊸Path⟜('M'⌾⊑∘∾·⥊ "L "∾¨⎉1⊢)¨○((0<≠¨line)⊸/) line
    Outline 0‿0≍dim
    leg.main 
  ⟩
}
