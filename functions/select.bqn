# Select function ⊏

types   ← •Import "../params/numtype.bqn"
scales  ← •Import "../measure/scale.bqn"
bench2d ← {basename⇐"select"} •Import "common/bench2d.bqn"

Bench ← {
  input‿Measure ⇐ ext‿plotname ← 𝕩
  name ⇐ "select-"∾ext

  result ⇐ ({⟨r⇐denom⟩:⟨{denom⇐r}⟩;⟨⟩}𝕩) •Import "../params/ns_v.bqn"
  params ⇐ ⟨{⟨r⇐types⟩:r;types}𝕩⟩

  plotOpts ⇐ {
    title ⇐ plotname
    x ⇐ input
    y ⇐ result
    key ⇐ ⊑params
  }
}

BenchXLen ← { ext 𝕊 xmax‿XScale‿wdesc‿Wlen:
  ext⇐
  plotname ⇐ "Selecting "‿wdesc‿" elements with ⊏"
  input ⇐ {
    name ⇐ "Right argument length"
    max ⇐ xmax
    range ⇐ XScale max
  }
  denom ⇐ "selection"
  Measure ⇐ { 𝕊 ⟨type⟩:
    len ⇐ Wlen type
    TimeParams ⇐ {
      Ind ← (⟨𝕩⟩•Import"../measure/gen.bqn").Rand
      ⟨⊏, len Ind 𝕩˙, type.GetGen𝕩⟩
    }
  }
}

leading ← Bench¨ ⟨
  "many" BenchXLen ⟨1e6, 13‿7⊸scales.E16, "1e6",1e6⟩
  "few"  BenchXLen ⟨1e3,      scales.E13, "16KB of",{(2⋆3+14)÷𝕩.size}⟩
  {
    ext ⇐ "permute"
    plotname ⇐ "Permuting a list with ⊏"
    input ⇐ {
      name ⇐ "Length"
      max ⇐ 1e6
      range ⇐ (•Import"../measure/scale.bqn").E23 max
    }
    Measure ⇐ { 𝕊 ⟨type⟩:
      TimeParams ⇐ { ⟨⊏, •rand.Deal𝕩˙, type.GetGen𝕩⟩ }
    }
  }
  {
    ext ⇐ "width"
    plotname ⇐ "Selecting 16KB of cells with ⊏"
    input ⇐ {
      name ⇐ "Cell width"
      max ⇐ 40
      range ⇐ 1+↕max
    }
    denom ⇐ "output element"
    Measure ⇐ { 𝕊 ⟨type⟩:
      l ← 1e3
      N ← ⌈((2⋆3+14)÷type.size)÷⊢
      Len ⇐ N×⊢
      TimeParams ⇐ {
        Ind ← (⟨𝕩⟩•Import"../measure/gen.bqn").Rand
        sh ← l‿𝕩
        ⟨⊏, (N 𝕩) Ind l˙, sh ⥊ (type.GetGen ×´sh){𝔽} ⟩
      }
    }
  }
⟩
leading ∾ "-cells-right"‿{𝔽⎉1}‿"⎉1"⊸Bench2d¨ ⟨
{
  plotname ⇐ "Permuting columns of rank 2 array with ⊏⎉1"
  result ⇐ ⟨{denom⇐"element"}⟩ •Import "../params/ns_v.bqn"
  ext⇐""
  params ⇐ ⟨types⟩
  GetTime ⇐ { mod 𝕊 ⟨type⟩: { ⟨⊏ _mod, •rand.Deal(⊢´𝕩)˙, type.GetGen𝕩⟩ } }
}
{
  plotname ⇐ "Selecting 5 columns of rank 2 array with ⊏⎉1"
  result ⇐ ⟨{denom⇐"output element"}⟩ •Import "../params/ns_v.bqn"
  ext⇐"res5"
  params ⇐ ⟨types⟩
  GetLen ⇐ 5×⊣
  GetTime ⇐ { mod 𝕊 ⟨type⟩: { ⟨⊏ _mod, 5•rand.Range(⊢´𝕩)˙, type.GetGen𝕩⟩ } }
}
⟩
