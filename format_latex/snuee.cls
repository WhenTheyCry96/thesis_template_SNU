%%
%%
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{snuee}
              [2022/06/10 v2.1 Standard SNU EE document class]
% 2010/10 Added "korean" option - jdj
% 2022/06 Updated latex Class file by SH Park

% \documentclass에 대한 옵션 필드 설정
% Usage: \documentclass[degree]{class_file_name}
% degree는 두 가지 선택가능 master, doctor
\newif\if@Doctor
\DeclareOption{doctor} {\@Doctortrue}
\DeclareOption{master} {\@Doctorfalse}

% korean... 설정 된 경우 국문 논문임.
\newif\if@Korean
\DeclareOption{korean} {\@Koreantrue}
\DeclareOption{english} {\@Koreanfalse}


\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{doctor}
\ProcessOptions

% base class: report class 사용
% report class에 대한 설명은 latex 관련 book에서 참고가능
\LoadClass[11pt,b5paper,onecolumn,oneside]{report}

\usepackage{epsfig}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{ifthen}
\usepackage{times}
\usepackage{chngpage}

\usepackage[intoc]{nomencl} % Updated
\makenomenclature           %

\if@Korean
	\usepackage{tocloft}
	\usepackage[hangul]{kotex}
\else
	\usepackage{kotex}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage[titles]{tocloft}
\newlength{\mylen}
\renewcommand{\cftfigpresnum}{\figurename\enspace}
%\renewcommand{\cftfigaftersnum}{: }
\settowidth{\mylen}{\cftfigpresnum\cftfigaftersnum}
\addtolength{\cftfignumwidth}{\mylen}

\renewcommand{\cfttabpresnum}{\tablename\enspace}
%\renewcommand{\cfttabaftersnum}{: }
\settowidth{\mylen}{\cfttabpresnum\cfttabaftersnum}
\addtolength{\cfttabnumwidth}{\mylen} % add the extra space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginEnvironment{subappendices}{%
\chapter*{Appendices}
\addcontentsline{toc}{chapter}{Appendices}
\counterwithin{figure}{section}
\counterwithin{table}{section}
}

% End of subappendices environment
\AtEndEnvironment{subappendices}{%
\counterwithout{figure}{section}
\counterwithout{table}{section}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\paperwidth}  {182mm}
\setlength{\paperheight} {257mm}

% 페이지여백 설정
\addtolength{\hoffset}    {-1in}
\addtolength{\voffset}  {-1in}
\setlength{\topmargin}      {30mm}
\setlength{\headheight} {0mm}
\setlength{\headsep}    {0mm}

\setlength{\marginparwidth} {0mm}
\setlength{\marginparsep}   {0mm}

\setlength{\oddsidemargin}  {25mm}
\setlength{\textwidth}      {132mm}
\setlength{\textheight} {197mm}
\setlength{\footskip}       {20mm}
\if@Korean
	\setlength{\textheight} {187mm}
	\setlength{\footskip}   {10mm}
\fi

% \title 명령어 재설정
% 한글, 영어 두 종류의 타이틀을 모두 넣는다.
% Usage: \title[korean]{Korean_Title}
% Usage: \title[english]{English_Title}

% renew related strings if Korean.
\if@Korean
	% very dirty and inconsistant... kscntformat sometimes does not work,
	% so I overrided them with renewcommand.
	\kscntformat{chapter}{제~}{~장}
	\kscntformat{section}{\arabic{chapter}.}{}
	\renewcommand\thesubsection{\arabic{chapter}.\arabic{section}.\arabic{subsection}}

	\ksnamedef{abstractname}{초록}
	\ksnamedef{contentsname}{목차}
	\ksnamedef{listtablename}{표 목차}
	\ksnamedef{listfigurename}{그림 목차}

	% for table of contents
	% need tocloft package
	\renewcommand\cftfigpresnum{그림 }
	\addtolength\cftfignumwidth{2.3em}
	\renewcommand\cfttabpresnum{표 }
	\addtolength\cfttabnumwidth{2.3em}
\fi

\renewcommand{\title}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorTitle}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngTitle}{#2}}{}%
}
\@onlypreamble{\title}

% 저자 정보
\renewcommand{\author}[2][korean]{%
    \ifthenelse{\equal{#1}{korean}}{\newcommand{\@KorAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@EngAuthor}{#2}}{}%
    \ifthenelse{\equal{#1}{nospace}}{\newcommand{\@AuthorNS}{#2}}{}%
    }
\@onlypreamble{\author}

% 지도교수 정보
\newcommand{\adviser}[1]{\newcommand{\@adviser}{#1}}
\@onlypreamble{\adviser}

% 논문 제출일
\newcommand{\submissiondeadline}[1]{%
    \newcommand{\@SubmissionYear}{#1}
}
\@onlypreamble{\submissiondeadline}

% 논문 심사일
\newcommand{\examinationdate}[1]{%
    \newcommand{\@ExamYear}{#1}
}
\@onlypreamble{\examinationdate}

% 졸업년월
% 두가지 style에 대해서 모두 작성한다.
% Usage: \gradyear[style1]{FEBRYARY 2008}
% Usage: \gradyear[style2]{2008년 2월}
% 제시한 style1, style2의 형식에 꼭 맞춰야 함.
%
\newcommand{\gradyear}[2][english]{%
    \ifthenelse{\equal{#1}{english}}{\newcommand{\@GradYearEng}{#2}}{}%
    \ifthenelse{\equal{#1}{korean} }{\newcommand{\@GradYearKor}{#2}}{}%
}
\@onlypreamble{\gradyear}


\AtBeginDocument{%
    \makecover%
    \makeinnercover%
    \makeapproval%
    }
\AtEndDocument{}

% 외표지 작성
\newcommand{\makecover}{%
            \thispagestyle{empty}
            %\changetext{}{10mm}{-5mm}{}{}
%           \noindent
            \begin{center}
                \Large
				\if@Korean
					\if@Doctor
						공학박사학위논문 \\
					\else
						공학석사학위논문 \\
					\fi
				\else
					\if@Doctor
						Ph.D. DISSERTATION \\
					\else
						M.S. THESIS \\
					\fi
				\fi
                \vspace*{2cm}
                \fontsize {22pt}{26pt}
                \selectfont
				\if@Korean
					\@KorTitle\ \\
				\else
					\@EngTitle\ \\
				\fi
                \vspace*{1cm}
                \fontsize {16pt}{19pt}
                \selectfont
				\if@Korean
					\@EngTitle\ \\
				\else
					\@KorTitle\ \\
				\fi

				\if@Korean\else
					\vspace*{2cm}
					\Large
					BY\\
					\vspace*{1cm}
					\@EngAuthor \\
				\fi
            \vfill
            \end{center}
                \begin{minipage}[t][60mm][b]{\textwidth}
                    \begin{center}
                    \Large
					\if@Korean
						\@GradYearKor \\
					\else
						\@GradYearEng \\
					\fi
                    \addvspace{4cm}
                    \Large
					\if@Korean
						{
							\fontsize {16pt}{24pt}
							\selectfont
							서울대학교 대학원\\
						}
						\vspace{2mm}
						{	% FIXME
							\fontsize {14pt}{16pt}
							\selectfont
							전기·정보공학부 \\
						}
						{	
							\fontsize {16pt}{24pt}
							\selectfont
							\@KorAuthor \\
						}
					\else % FIXME
						DEPARTMENT OF ELECTRICAL AND COMPUTER ENGINEERING\\
						COLLEGE OF ENGINEERING \\
						SEOUL NATIONAL UNIVERSITY \\
					\fi
                    \end{center}
                \end{minipage}
            \newpage
            }

%내표지 작성
% The same as "outer" cover.
\newcommand{\makeinnercover}{%
	\makecover
}

%인준지 작성
\newcommand{\makeapproval}{%
            \thispagestyle{empty}
            %\changetext{10mm}{-10mm}{5mm}{}{}
            \noindent
            \begin{center}
                \fontsize {22pt}{22pt}
                \selectfont
				\if@Korean
					\@KorTitle \\
				\else
					\@EngTitle \\
				\fi
                \vspace{1cm}
                \fontsize {16pt}{16pt}
                \selectfont
				\if@Korean
					\@EngTitle \\
				\else
					\@KorTitle \\
				\fi
                \vspace{1cm}
                \Large
                지도교수 \@adviser\\
                \vspace{2mm}
                \fontsize {16pt}{16pt}
                \selectfont
                \if@Doctor
                    이 논문을 공학박사 학위논문으로 제출함\\
                \else
                    이 논문을 공학석사 학위논문으로 제출함\\
                \fi
                \vspace{5mm}
                \Large
                \@GradYearKor\\
                \vspace{10mm}
                \fontsize {16pt}{16pt}
                \selectfont
                서울대학교 대학원\\
                \vspace{5mm}
                \Large
                전기·정보공학부\\
                \vspace {5mm}
                \fontsize{16pt}{16pt}
                \selectfont
                \@KorAuthor \\
                \vspace{1cm}
                \fontsize{16pt}{16pt}
                \selectfont
                \if@Doctor
                \@AuthorNS의 공학박사 학위 논문을 인준함\\
                \else
                \@AuthorNS의 공학석사 학위 논문을 인준함\\
                \fi
                \vspace{5mm}
                \Large
                \@GradYearKor\\
                 \vfill
            \end{center}
            \begin{minipage}[t][20mm][b]{\textwidth}
                \begin{center}
                \if@Doctor
                    \Large
                    위~~원~~장:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(인)}\\
                    부위원장:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(인)}\\
                    위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(인)}\\
                    위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(인)}\\
                    위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(인)}\\
                \else
                    \Large
                    위~~원~~장:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
                    부위원장:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
                    위~~~~~~~~원:~~\underline{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}\\
                \fi
                \end{center}
            \end{minipage}
            \newpage
            %\changetext{-15mm}{}{}{}{}
            }

%chapter 설정
\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\thispagestyle{plain}
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{\@chapapp\space\thechapter.}%
		\if@Korean
			\addcontentsline{toc}{chapter}{\numberline{제~\thechapter~장} #1}
		\else
			\addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\if@twocolumn
		\@topnewpage[\@makechapterhead{#2}]%
	\else
		\@makechapterhead{#2}%
		\@afterheading%
	\fi
}
\def\@makechapterhead#1{%
	\if@Korean\else
		\vspace*{50\p@}
	\fi
	{\parindent\z@
	 \fontsize{16pt}{20pt}
	 \selectfont
	 \bfseries
	 \if@Korean
	 	{
			\centering
			\fontsize{16pt}{20pt}
			\selectfont
			제~\thechapter~장~#1
			\par
		}
	 \else
		{Chapter \thechapter \hspace{1ex}
		\vskip 40\p@
		\fontsize{16pt}{20pt}
		\selectfont
		} #1\par
	\fi
	}
	\vskip 40\p@
}
\def\@schapter#1{%
	\if@twocolumn
		\@topnewpage[\@makeschapterhead{#1}]%
	\else
		\@makeschapterhead{#1}%
		\@afterheading
	\fi}
\def\@makeschapterhead#1{
	\if@Korean\else
		\vspace*{50\p@}
	\fi
	{\centering \parindent\z@
	\fontsize{22pt}{26pt}
	\selectfont
	\bfseries #1\par}
	\vskip 40\p@
}

%% Abstract
\newcounter{pagemarker}
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}}
\renewenvironment{abstract}{%
    \pagenumbering{roman}
    \pagestyle{plain}%
    \newcommand{\@tempbreak}{}
    \let\@tempbreak\linebreak
    \renewcommand{\linebreak}{\ }
    \newlength{\@thesisinfowidth}
    \setlength{\@thesisinfowidth}{\textwidth}
    \addtolength{\@thesisinfowidth}{-20mm}
    %\noindent
    \begin{center}
    \fontsize {22pt}{22pt}
    \selectfont
    \textbf{\abstractname} \\
    \end{center}
    \vspace{20\p@}
    \addcontentsline{toc}{chapter}{\abstractname}
}{  \setcounter{pagemarker}{\value{page}}
    \addtocounter{pagemarker}{1}
    \newpage \pagenumbering{arabic}
    \let\linebreak\@tempbreak
}

%%
%% 목차
%%
\newcommand{\makelists}{%
	\if@Korean
		\tableofcontents
		\clearpage
		\listoftables
		\clearpage
		\listoffigures
		\clearpage
	\else
		\pagenumbering{roman}
		\tableofcontents
		\listoftables
		\listoffigures
		\listofnomen
        %\printnomenclature %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		\clearpage
		\pagenumbering{arabic}
	\fi
}

% Typesetting for toc, tot, tof
\if@Korean
	% TOC
    \setlength{\cftbeforetoctitleskip}{0pt}
	\renewcommand{\cftaftertoctitle}{\hfill}
	\renewcommand{\cfttoctitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
	% LOF
    \setlength{\cftbeforeloftitleskip}{0pt}
	\renewcommand{\cftafterloftitle}{\hfill}
	\renewcommand{\cftloftitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
	% LOT
    \setlength{\cftbeforelottitleskip}{0pt}
	\renewcommand{\cftafterlottitle}{\hfill}
	\renewcommand{\cftlottitlefont}
	{
		\hfill\bfseries
		\fontsize{22pt}{26pt}
		\selectfont
	}
\fi

\if@Korean\else
\renewcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\contentsname}
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
    \pagenumbering{arabic}
}
\fi

%%
%% \listoftables 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\if@Korean\else
\renewcommand\listoftables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\listtablename}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
    \pagenumbering{arabic}
}
\fi

%%
%% \listoffigures 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\if@Korean\else
\renewcommand\listoffigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
    \pagenumbering{roman}
    \setcounter{page}{\value{pagemarker}}
    \addcontentsline{toc}{chapter}{\listfigurename}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
    \pagenumbering{arabic}
}
\fi

\if@Korean\else
\newcommand\listofnomen{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \pagenumbering{roman}
	\setcounter{page}{\value{pagemarker}}
	\printnomenclature
	\@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \newpage \setcounter{pagemarker}{\value{page}}
	\clearpage
    \pagenumbering{arabic}
}
\fi

%%
%% 국문초록
%%
\newenvironment{summary}{%
	\if@Korean
		\chapter*{ABSTRACT}
		\addcontentsline{toc}{chapter}{ABSTRACT}
	\else
		\chapter*{초 록}
		\addcontentsline{toc}{chapter}{Abstract (In Korean)}
	\fi
    %\setlength{\parindent}{0pt}
    \indent
}

\newcommand{\acknowledgement}{%
    \vspace{-1cm}
	\if@Korean
		\chapter*{감사의 글}
		\addcontentsline{toc}{chapter}{감사의 글}
	\else
		\chapter*{ACKNOWLEGEMENT}
		\addcontentsline{toc}{chapter}{Acknowlegement}
	\fi
    \pagestyle{empty}
    \indent
}
