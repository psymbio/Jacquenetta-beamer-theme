# URW Classico for `pdflatex`

A step-by-step guide to installing **URW Classico** system-wide and configuring it for use with `pdflatex`.

## Requirements

* Linux
* TeX Live
* `pdflatex`
* A copy of the URW Classico font package

---

## 1. Get the Font Package

Place the complete `classico` font package somewhere on your system.

For example:

```text
Jacquenetta-beamer-theme/
└── classico/
```

The package should contain the necessary font files:

```text
classico/
├── enc/
├── latex/
├── map/
├── tfm/
├── type1/
├── vf/
└── ...
```

The important file types are:

* `.sty` — LaTeX package files
* `.fd` — font definition files
* `.pfb` — Type 1 font files
* `.tfm` — font metric files
* `.vf` — virtual font files
* `.enc` — encoding files
* `.map` — font mapping file

---

## 2. Copy the Font Files

Navigate to the `classico` directory:

```bash
cd /path/to/Jacquenetta-beamer-theme/classico
```

Create the required TeX directories and copy the files:

### LaTeX package files

```bash
sudo mkdir -p /usr/share/texmf/tex/latex/classico
sudo cp latex/*.sty /usr/share/texmf/tex/latex/classico/
sudo cp latex/*.fd /usr/share/texmf/tex/latex/classico/
```

### Type 1 fonts

```bash
sudo mkdir -p /usr/share/texmf/fonts/type1/urw/classico
sudo cp type1/*.pfb /usr/share/texmf/fonts/type1/urw/classico/
```

### Font metrics

```bash
sudo mkdir -p /usr/share/texmf/fonts/tfm/urw/classico
sudo cp tfm/*.tfm /usr/share/texmf/fonts/tfm/urw/classico/
```

### Virtual fonts

```bash
sudo mkdir -p /usr/share/texmf/fonts/vf/urw/classico
sudo cp vf/*.vf /usr/share/texmf/fonts/vf/urw/classico/
```

### Encoding files

```bash
sudo mkdir -p /usr/share/texmf/fonts/enc/urw/classico
sudo cp enc/*.enc /usr/share/texmf/fonts/enc/urw/classico/
```

### Font map

```bash
sudo mkdir -p /usr/share/texmf/fonts/map/pdftex/classico
sudo cp map/classico.map /usr/share/texmf/fonts/map/pdftex/classico/
```

---

## 3. Update TeX's Font Databases

Run:

```bash
sudo texhash
sudo updmap-sys
```

This makes the newly installed fonts available to TeX and `pdftex`.

---

## 4. Create the Font Definition Files

Depending on the version of the Classico package, the original `.fd` files may reference font names that do not match the installed font files.

The following definitions provide a working configuration for `pdflatex`.

### `T1URWClassico.fd`

Create:

```bash
sudo tee /usr/share/texmf/tex/latex/classico/T1URWClassico.fd > /dev/null << 'EOF'
\ProvidesFile{T1URWClassico.fd}[2026/08/14 Font definitions for URW Classico]

\DeclareFontFamily{T1}{URWClassico}{}

% Regular
\DeclareFontShape{T1}{URWClassico}{m}{n}{<-> URWClassico-Regular-tlf-t1}{}
\DeclareFontShape{T1}{URWClassico}{m}{it}{<-> URWClassico-Italic-tlf-t1}{}
\DeclareFontShape{T1}{URWClassico}{m}{sl}{<-> URWClassico-Italic-tlf-t1}{}

% Bold
\DeclareFontShape{T1}{URWClassico}{b}{n}{<-> URWClassico-Bold-tlf-t1}{}
\DeclareFontShape{T1}{URWClassico}{b}{it}{<-> URWClassico-BoldItalic-tlf-t1}{}
\DeclareFontShape{T1}{URWClassico}{b}{sl}{<-> URWClassico-BoldItalic-tlf-t1}{}

% Bold extended (alias to bold)
\DeclareFontShape{T1}{URWClassico}{bx}{n}{<-> ssub * URWClassico/b/n}{}
\DeclareFontShape{T1}{URWClassico}{bx}{it}{<-> ssub * URWClassico/b/it}{}
\DeclareFontShape{T1}{URWClassico}{bx}{sl}{<-> ssub * URWClassico/b/sl}{}

\endinput
EOF
```

### `OT1URWClassico.fd`

Create:

```bash
sudo tee /usr/share/texmf/tex/latex/classico/OT1URWClassico.fd > /dev/null << 'EOF'
\ProvidesFile{OT1URWClassico.fd}[2026/08/14 Font definitions for URW Classico]

\DeclareFontFamily{OT1}{URWClassico}{}

% Regular
\DeclareFontShape{OT1}{URWClassico}{m}{n}{<-> URWClassico-Regular-tlf-t1}{}
\DeclareFontShape{OT1}{URWClassico}{m}{it}{<-> URWClassico-Italic-tlf-t1}{}
\DeclareFontShape{OT1}{URWClassico}{m}{sl}{<-> URWClassico-Italic-tlf-t1}{}

% Bold
\DeclareFontShape{OT1}{URWClassico}{b}{n}{<-> URWClassico-Bold-tlf-t1}{}
\DeclareFontShape{OT1}{URWClassico}{b}{it}{<-> URWClassico-BoldItalic-tlf-t1}{}
\DeclareFontShape{OT1}{URWClassico}{b}{sl}{<-> URWClassico-BoldItalic-tlf-t1}{}

% Bold extended (alias to bold)
\DeclareFontShape{OT1}{URWClassico}{bx}{n}{<-> ssub * URWClassico/b/n}{}
\DeclareFontShape{OT1}{URWClassico}{bx}{it}{<-> ssub * URWClassico/b/it}{}
\DeclareFontShape{OT1}{URWClassico}{bx}{sl}{<-> ssub * URWClassico/b/sl}{}

\endinput
EOF
```

Update the TeX database again:

```bash
sudo texhash
```

---

## 5. Verify the Installation

You can check whether TeX can find the package:

```bash
kpsewhich classico.sty
```

Check the font definition:

```bash
kpsewhich T1URWClassico.fd
```

Check that the font files are available:

```bash
kpsewhich URWClassico-Regular-tlf-t1.tfm
```

If these commands return paths under `/usr/share/texmf/`, the installation is being detected.

---

## 6. Test with `pdflatex`

Create a test document:

```bash
cat > small.tex << 'EOF'
\documentclass{article}

\usepackage[T1]{fontenc}
\usepackage{textcomp}
\usepackage{xcolor}

\renewcommand{\sfdefault}{URWClassico}
\renewcommand{\familydefault}{\sfdefault}

\color{black}

\begin{document}

\section{URW Classico Test}

This text should be in URW Classico.

\textbf{This is bold.}

\textit{This is italic.}

\end{document}
EOF
```

Compile:

```bash
pdflatex small.tex
```

Then inspect the fonts embedded in the PDF:

```bash
pdffonts small.pdf
```

You should see entries similar to:

```text
UUCXDS+URWClassico-Bold       Type 1   Custom   yes yes yes
NSOMJX+URWClassico-Regular    Type 1   Custom   yes yes yes
UIXICH+URWClassico-Italic     Type 1   Custom   yes yes yes
```

The exact prefix will vary because PDF font subsetting generates different names.

---

# Using URW Classico in Beamer

Once the font is installed, it can be used in a Beamer font theme.

Create:

```text
beamerfontthemeJacquenetta.sty
```

with:

```latex
% ----------------------------------------------------------
% beamerfontthemeJacquenetta.sty
% URW Classico font theme
% ----------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{beamerfontthemeJacquenetta}%
  [2026/04/06 v1.0 Jacquenetta font theme]

\mode<presentation>

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{anyfontsize}
\RequirePackage{setspace}
\RequirePackage{textcomp}
\RequirePackage{xcolor}

% ----------------------------------------------------------
% URW Classico
% ----------------------------------------------------------

\renewcommand{\sfdefault}{URWClassico}
\renewcommand{\familydefault}{\sfdefault}

\color{black}

\RequirePackage{amsmath,amssymb}

% ----------------------------------------------------------
% Remove bold from Beamer elements
% ----------------------------------------------------------

\setbeamerfont{title}{series=\mdseries}
\setbeamerfont{subtitle}{series=\mdseries}
\setbeamerfont{frametitle}{series=\mdseries}
\setbeamerfont{author}{series=\mdseries}
\setbeamerfont{institute}{series=\mdseries}
\setbeamerfont{date}{series=\mdseries}
\setbeamerfont{block title}{series=\mdseries}
\setbeamerfont{block body}{series=\mdseries}
\setbeamerfont{itemize/enumerate body}{series=\mdseries}
\setbeamerfont{itemize/enumerate subbody}{series=\mdseries}
\setbeamerfont{footnote}{series=\mdseries}
\setbeamerfont{section in toc}{series=\mdseries}
\setbeamerfont{subsection in toc}{series=\mdseries}
\setbeamerfont{description item}{series=\mdseries}
\setbeamerfont{caption}{series=\mdseries}
\setbeamerfont{framesubtitle}{series=\mdseries}

% ----------------------------------------------------------
% Disable microtype expansion/tracking
% ----------------------------------------------------------

\RequirePackage{microtype}

\microtypesetup{expansion=false}
\microtypesetup{tracking=false}

% ----------------------------------------------------------
% Normal line spacing
% ----------------------------------------------------------

\setstretch{1}

% ----------------------------------------------------------
% Disable bold globally
% ----------------------------------------------------------

\let\origtextbf\textbf
\renewcommand\textbf[1]{\origtextbf{\mdseries #1}}

\renewcommand{\bfseries}{}
\renewcommand{\bf}{}

\mode<all>

\endinput
```

---

## Quick Installation

For an existing Classico package, the essential installation sequence is:

```bash
cd /path/to/Jacquenetta-beamer-theme/classico

sudo mkdir -p /usr/share/texmf/tex/latex/classico
sudo cp latex/*.sty latex/*.fd /usr/share/texmf/tex/latex/classico/

sudo mkdir -p /usr/share/texmf/fonts/type1/urw/classico
sudo cp type1/*.pfb /usr/share/texmf/fonts/type1/urw/classico/

sudo mkdir -p /usr/share/texmf/fonts/tfm/urw/classico
sudo cp tfm/*.tfm /usr/share/texmf/fonts/tfm/urw/classico/

sudo mkdir -p /usr/share/texmf/fonts/vf/urw/classico
sudo cp vf/*.vf /usr/share/texmf/fonts/vf/urw/classico/

sudo mkdir -p /usr/share/texmf/fonts/enc/urw/classico
sudo cp enc/*.enc /usr/share/texmf/fonts/enc/urw/classico/

sudo mkdir -p /usr/share/texmf/fonts/map/pdftex/classico
sudo cp map/classico.map /usr/share/texmf/fonts/map/pdftex/classico/

sudo texhash
sudo updmap-sys
```

Then create the corrected `.fd` files described above and run:

```bash
sudo texhash
```

Finally:

```bash
pdflatex small.tex
pdffonts small.pdf
```

---

## Troubleshooting

### `Font ... not found`

Check whether TeX can locate the font:

```bash
kpsewhich URWClassico-Regular-tlf-t1.tfm
```

If nothing is returned, verify that the `.tfm` files were copied correctly:

```bash
find /usr/share/texmf/fonts/tfm/urw/classico -type f
```

Then run:

```bash
sudo texhash
sudo updmap-sys
```

### `I can't find file ... .pfb`

Check the Type 1 files:

```bash
find /usr/share/texmf/fonts/type1/urw/classico -type f
```

Then refresh the font map:

```bash
sudo updmap-sys
```

### `Font shape ... undefined`

Check the relevant `.fd` file:

```bash
kpsewhich T1URWClassico.fd
```

Make sure it contains the `URWClassico` font definitions shown above.

---

## Installation Checklist

* [ ] Copy `.sty` and `.fd` files
* [ ] Copy `.pfb` Type 1 fonts
* [ ] Copy `.tfm` metric files
* [ ] Copy `.vf` virtual fonts
* [ ] Copy `.enc` encoding files
* [ ] Copy `classico.map`
* [ ] Run `sudo texhash`
* [ ] Run `sudo updmap-sys`
* [ ] Create corrected `.fd` files if necessary
* [ ] Run `sudo texhash` again
* [ ] Compile a test document with `pdflatex`
* [ ] Verify embedded fonts with `pdffonts`

## Result

You should now have **URW Classico working with `pdflatex`**, including:

* **Font:** URW Classico
* **Font family:** `URWClassico`
* **Compiler:** `pdflatex`
* **Format:** Type 1
* **Bold:** Can be disabled through the Beamer theme
* **Line spacing:** Normal
* **Beamer:** Supported

The installation is system-wide under `/usr/share/texmf/`, so the font can be used by other LaTeX projects as well.
