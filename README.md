# Mxck – Follow the Gap: Projektdokumentation

This repository contains the **LaTeX documentation** for the *Mxck Follow the Gap* project.
The project implements a reactive obstacle-avoidance strategy using the
**Follow-the-Gap (FTG) algorithm** on an F1TENTH 1:10 scale autonomous vehicle.

---

## Project Overview

| Item | Details |
|------|---------|
| Vehicle | F1TENTH (Traxxas Slash 4×4, 1:10 scale) |
| Compute | NVIDIA Jetson Nano |
| Sensor  | Hokuyo UST-10LX (270° LiDAR) |
| Software | ROS 2 Foxy on Ubuntu 20.04 |
| Algorithm | Follow-the-Gap (FTG) |

The goal was to drive the vehicle autonomously around an indoor obstacle course.
While the simulator results were promising, a full collision-free run on the real
hardware could not be achieved within the project timeframe.
The documentation covers the algorithm, implementation, test results, and lessons
learned.

---

## Repository Structure

```
.
├── Makefile                        # Build the PDF
├── src/
│   ├── main.tex                    # Root LaTeX document
│   ├── references.bib              # BibTeX bibliography
│   ├── images/                     # Figures (add your own)
│   └── chapters/
│       ├── 01_einleitung.tex       # Introduction
│       ├── 02_systemaufbau.tex     # System setup (hardware & software)
│       ├── 03_algorithmus.tex      # FTG algorithm description
│       ├── 04_implementierung.tex  # ROS 2 implementation & source code
│       ├── 05_ergebnisse.tex       # Results & evaluation
│       └── 06_fazit.tex            # Conclusion & future work
└── build/                          # Generated build artefacts (gitignored)
```

---

## Building the PDF

### Prerequisites

Install a TeX distribution that includes `pdflatex` and `bibtex`:

```bash
# Debian / Ubuntu
sudo apt install texlive-full

# macOS (Homebrew)
brew install --cask mactex
```

### Compile

```bash
make          # produces Mxck_FTG_Dokumentation.pdf
make clean    # remove build artefacts
make view     # compile and open the PDF
```

The PDF is written to **`Mxck_FTG_Dokumentation.pdf`** in the repository root.

---

## Adding Figures

Place your image files inside `src/images/` and reference them in the relevant
chapter with `\includegraphics[width=\linewidth]{filename}` (omit the extension).
The placeholder figure environments in the chapters already show where to insert
images.

---

## Language

The documentation is written in **German** (with English technical terms where
appropriate), matching the project's academic context.
