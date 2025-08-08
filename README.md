# Description
UI program for the spatial registration (mapping) of two fluorescence microscopy frequency channels based on one or two TIF files containing fiducials (e.g., beads) visible in both channels.

Unlike earlier software, bead mapping is fully automated here, with no manual clicking on bead pairs required.

Includes a version of dftregistration.m for the initial rough translation-based registration between channels; credit to Manuel Guizar-Sicairos, Samuel T. Thurman, and James R. Fienup, "Efficient subpixel image registration algorithms," Opt. Lett. 33) 156-158 (2008).

# Instructions
1. If not already installed: install Matlab and the following toolboxes: image processing, optimization, statistics + machine learning.
2. Clone repository to your local drive.
3. In Matlab, add the repository and subfolders to your Matlab path (using the Set Path button).
4. Open BeadMapperSimple.mlapp in Matlab and follow the on-screen instructions.

<img width="1027" height="722" alt="image" src="https://github.com/user-attachments/assets/6cedb1c8-d92b-4943-bcbe-9a8d4c0ad3b9" />
