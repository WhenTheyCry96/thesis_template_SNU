# Ph.D. Thesis Disseration Template

## Seoul National University 
### (default: Electrical and Computer Engineering) updated by [SH Park](https://www.linkedin.com/in/seong-hyeon-park-884296160/)

This version is the updated version of $\LaTeX$ format provided by [SNU ECE](https://ee.snu.ac.kr/community/notice/academic?bm=v&bbsidx=48811)

## What's Different?

## Updates, Aug. 2022:
### 1. Nomenclature Page Generation
You have to compile the tex file with makeindex as follows:
    
    makeindex -s nomencl.ist -t "파일명.nlg" -o "파일명.nls" "파일명.nlo"
   <p align="center">
     <img src="README_nomen.png" width="800" />
   </p>

### 2. Table/Figure Name Generation
You can generate 'Table' (or 'Figure') in List of Tables (Figures) page. If you don't want to use this feature, comment the lines from 51 to 65 of [snuee.cls](./format_latex/snuee.cls) file.
   <p align="center">
     <img src="README_figuretable_name.png" width="800" />
   </p>

### 3. Beautiful Appendix Generation
You can generate $beautiful$ appendix in ToC (Table of Contents) and main-text as follows:
   <p align="center">
     <img src="README_appendix.png" width="800" />
   </p>

### 4. Overleaf Compatibility
You have to select 2021 or the older TeX Live version (IDK why ㅠㅠ). If you're using [Overleaf](https://www.overleaf.com/), just compiling with pdfLaTeX will generate the beautiful pdf file without setting makeindex for nomenclature generation.
   <p align="center">
     <img src="README_overleaf_texlive2021.png" width="800" />
   </p>

