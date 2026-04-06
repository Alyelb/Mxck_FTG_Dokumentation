# MXCK FTG – Projektarbeit Dokumentation

**Analyse und Evaluation des Follow-the-Gap-Algorithmus zur autonomen Hindernisvermeidung auf einem Jetson-Nano-basierten MXCarkit**

> Projektarbeit | Fachbereich MNI – Informatik | WS 2025/2026  
> Technische Hochschule Mittelhessen, Friedberg  
> Betreuer: Prof. Dr. Benedikt Lattke

---

## Autoren

| Name | Matrikelnummer |
|---|---|
| Aly Elbermawy | 5335848 |
| Omar Elalami | 5379642 |
| Zakaria El-aboudi | 5223183 |

---

## Kurzfassung

Diese Projektarbeit dokumentiert die Entwicklung, Integration und experimentelle Evaluation eines reaktiven, LiDAR-basierten Hindernisvermeidungssystems für das **MXCarkit** – ein miniaturisiertes autonomes Fahrzeug auf Basis des NVIDIA Jetson Nano.

Als Planungsalgorithmus wurde eine modifizierte CTU-Variante des **Follow-the-Gap-Algorithmus (FTG)** eingesetzt, der aus den Rohdaten eines RPLIDAR A1/A2-Sensors eine sichere Fahrtrichtung berechnet. Der entwickelte ROS 2-Stack umfasst sieben spezialisierte Pakete für Wahrnehmung, Planung, Adaption und Steuerung.

**Schlüsselwörter:** Follow-the-Gap · ROS 2 · LiDAR · Autonomes Fahren · Jetson Nano · MXCarkit · Hinderniserkennung · Ackermann-Steuerung

---

## Projektübersicht

### Hardware

| Eigenschaft | Wert |
|---|---|
| Fahrzeugbreite | > 30 cm |
| Fahrzeuglänge | > 50 cm |
| Antrieb | Bürstenloser Elektromotor |
| Motorcontroller | VESC (Vedder Electronic Speed Controller) |
| Lenkung | Ackermann-Geometrie |
| Recheneinheit | NVIDIA Jetson Nano (Quad-core ARM Cortex-A57 + 128-core Maxwell-GPU) |
| LiDAR-Sensor | RPLIDAR A1/A2 (360°, ≈ 11 Hz, ≈ 1800 Punkte/Umdrehung) |
| Betriebssystem | Ubuntu 18.04 (L4T) |
| Middleware | ROS 2 (Foxy / Humble) |

### Software-Architektur

Die gesamte Softwareumgebung läuft in Docker-Containern auf dem Jetson Nano:

| Container | ROS 2-Version | Inhalt |
|---|---|---|
| `mxck2_control` | Humble | Fahrzeugsteuerung, VESC-Treiber, LiDAR-Treiber |
| `mxck2_development` | Foxy | Entwicklungsumgebung, FTG-Stack |
| `mxck2_lidar` | Humble | Alternativer LiDAR-Treiber |

### Follow-the-Gap-Algorithmus (CTU-Variante)

Der FTG-Algorithmus ist ein reaktives Planungsverfahren, das ohne globale Karte auskommt und in Echtzeit eine kollisionsfreie Fahrtrichtung berechnet:

1. **Hindernisse identifizieren** – LiDAR-Messstrahlen werden in kreisförmige Hindernisse umgewandelt (`obstacle_substitution_node`)
2. **Lücken konstruieren** – Zwischen benachbarten Hindernissen werden freie Winkelbereiche (Gaps) ermittelt
3. **Beste Lücke wählen** – Die breiteste passierbare Lücke wird ausgewählt
4. **Zielwinkel berechnen** – Das Fahrzeug wird zum Mittelpunkt der Lücke gesteuert

---

## Inhalt dieses Repositories

```
Mxck_FTG_Dokumentation/
└── Projektarbeit_MXCK_FTG/
    ├── main.tex                  # Hauptdokument (LaTeX)
    ├── images/
    │   └── thm.png               # THM-Logo
    └── chapters/
        ├── 01_grundlagen.tex     # Hardware, Software-Architektur, FTG-Grundlagen
        ├── 02_durchfuehrung.tex  # Implementierung und Experimente
        ├── 03_diskussion.tex     # Fehleranalyse und Diskussion
        └── 04_fazit.tex          # Fazit und Ausblick
```

### Kapitel im Überblick

| Kapitel | Inhalt |
|---|---|
| 1 – Grundlagen | MXCarkit-Hardware, ROS 2-Stack, FTG-Algorithmus |
| 2 – Durchführung | Implementierung der 7 ROS 2-Pakete, Experimente |
| 3 – Diskussion | Fehleranalyse (TF-Transformation, LiDAR-Kalibrierung) |
| 4 – Fazit & Ausblick | Erkenntnisse, Empfehlungen, geplante Erweiterungen |

---

## Dokument bauen

Voraussetzung: Eine LaTeX-Distribution mit den verwendeten Paketen (z. B. TeX Live).

```bash
cd Projektarbeit_MXCK_FTG
pdflatex main.tex
pdflatex main.tex   # zweimal für korrekte Verweise und Inhaltsverzeichnis
```

---

## Wesentliche Erkenntnisse

- **Kalibrierung ist entscheidend:** Der Parameter `front_center_deg` hat enormen Einfluss auf das Gesamtverhalten des Algorithmus.
- **TF-Infrastruktur ist nicht optional:** Das Fehlen der `base_link` → `laser`-Transformation war die tiefste Ursache des Systemversagens.
- **Hindernismodellierung beeinflusst Lückenbewertung:** Ein Sicherheitsradius von 0,01 m ist für ein Fahrzeug der Breite > 30 cm unzureichend.
- **Modularität erleichtert Debugging:** Dedizierte Debug-Topics ermöglichten eine systematische Fehlereingrenzung.

---

## Referenzen

- S. Sezer und M. Gokasan, *Novel obstacle avoidance algorithm for short range ultrasonic sensors*, Journal of the Franklin Institute, 2012.
- F1TENTH-Community, [F1TENTH Autonomous Racing – Follow the Gap Algorithm](https://f1tenth.readthedocs.io), 2023.
- Open Robotics, [ROS 2 Foxy Fitzroy – Offizielle Dokumentation](https://docs.ros.org/en/foxy/), 2020.
- W. Meisenheimer, [mxck2\_ws – MXCK2 ROS Workspace](https://github.com/william-mx/mxck2_ws), GitHub, 2024.
