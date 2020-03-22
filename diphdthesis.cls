% diphdthesis.cls
%
% A LaTeX2e document class for writing PhD theses in the Department of
% Informatics and Telecommunications (DI&T) of the National and Kapodistrian
% University of Athens (NKUA).
%
% Copyright (c) 2014, 2015 Charalampos S. Nikolaou <charnik@di.uoa.gr>
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt.
%
% This work consists of the following files:
% diphdthesis.cls
%		This document class file
%
% sample.tex
%		A sample document demonstrating the use of this class file
%
% assets/
%		A directory containing three colored versions of the official emblem of
%		the National and Kapodistrian University of Athens.
%
% fonts/
%		A directory containing the Arial family TrueType fonts. The directory
%		also includes a README file with instructions on installing the fonts
%		in your system (assuming Unix-based).

% Document Class Options
%
% inscr
% 		If present, then a page with the inscription provided via the command
% 		\inscription{} is printed.
%
% ack
%		If present, then a page with the acknowledgements provided via the
%		command \acksEn{} is printed.
%
% preface
%		If present, then a preface page is included just before the
%		introductory chapter. The content of this page is controled via the
%		command \preface{}.
%
% lop
%		If present, then a page with the list of puclications will be included.
%

% Document Versions
%
% Version 1.1, 2015/11/06
%		Updated document class so as to be compatible with the template file
%		regarding the appearance of headers/footers and appendix names. Require
%		also package `longtable' for being used for abbreviations/acronyms.
%
% Version 1.0, 2014/12/08
%		Initial attempt at creating the first class file for LaTeX Theses in
%		DI&T, NKUA.

% Known Issues
%
% * Chapter titles are not appearing in capital letters in the ToC, although
%   in other places this has been taken care of for good. Thus, one is enforced
%   to type chapter titles in capital letters, so as to be compatible with the
%   requirements of the department.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{diphdthesis}[2015/11/06 v1.1 LaTeX class for PhD Theses
submitted to the Department of Informatics and Telecommunications of the
National and Kapodistrian University of Athens (by Charalampos Nikolaou
<charnik@di.uoa.gr>)]

%
% Declare and initialize global ifs
% (set by passing options to this document class)
%

% controls the inclusion of the inscription page
\newif\ifinscriptionpage
\inscriptionpagefalse

% controls inclusion of acknowledgement page
\newif\ifackpage
\ackpagefalse

% controls inclusion of the list of publications page
\newif\ifloppage
\loppagefalse

% controls inclusion of the preface page
\newif\ifprefacepage
\prefacepagefalse

%
% Declare and initialize internal ifs (not set by document class options)
%
\newif\ifenglishfrontpage
\englishfrontpagefalse

\newif\ifenglishcommitteepage
\englishcommitteepagefalse

% marks whether the appendices have started
% (used later for setting an appropriate naming scheme for the appendix title)
\newif\ifappendixstarted
\appendixstartedfalse

%
% Check passed options
%
\DeclareOption{inscr}{
  \inscriptionpagetrue
}
\DeclareOption{ack}{
  \ackpagetrue
}
\DeclareOption{preface}{
  \prefacepagetrue
}
\DeclareOption{lop}{
  \loppagetrue
}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[12pt,twoside,openright]{book}

%
% Required packages and configuration
%
\RequirePackage[a4paper,
top=2cm,bottom=2cm,bindingoffset=0.5cm,left=2cm,right=2cm,
headheight=15pt,headsep=1.25cm,footskip=1.25cm,
includehead,includefoot]{geometry} % add option showframe=true for debugging
\RequirePackage{fancyhdr}
\RequirePackage[final]{graphicx}
\RequirePackage{sectsty}   % needed for formatting chapter headings
\RequirePackage{textcase}  % needed for forcing capital letters (in chapters)
%\usepackage[notlof,notlot,nottoc,notlop]{tocbibind}
%\RequirePackage{tocloft}  % needed for making chapter titles upper case
\RequirePackage{etoolbox}  % needed for patchcmd
\RequirePackage{tabularx}  % needed for tabular* environment
\RequirePackage{longtable} % needed for splitting big tables across pages

%(e.g., abbreviations)
%\RequirePackage[toc,page,titletoc]{appendix} % needed for configuring
%%appendices

%
% Add Greek support
%
\usepackage{amsmath}
\usepackage{ifxetex}
\ifxetex
    % XeLaTeX
    % \usepackage{xgreek}
    \usepackage{fontspec}
    \defaultfontfeatures{Mapping=tex-text}
    \setmainfont[ExternalLocation=fonts/arial/fonts/,Ligatures={Common,TeX},BoldFont=Arial-Bold.ttf,ItalicFont=Arial-Italic.ttf,BoldItalicFont=Arial-Bold-Italic.ttf]{Arial.ttf}
    \setsansfont[ExternalLocation=fonts/arial/fonts/,Mapping=tex-text,Scale=MatchLowercase,Ligatures={Common,TeX},BoldFont=Arial-Bold.ttf,ItalicFont=Arial-Italic.ttf,BoldItalicFont=Arial-Bold-Italic.ttf]{Arial.ttf}%
    \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
    \setmonofont[Mapping=no-mapping]{Liberation Mono}
    \newfontfamily\lstmonofont[Scale=0.80,Mapping=no-mapping]{Liberation Mono}
    % \setmainfont[Mapping=tex-text]{Linux Libertine O}
    % \setmainfont[Ligatures={Common,TeX}]{Arial}
    % \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
    % \setsansfont[Mapping=tex-text,Scale=MatchLowercase]{Arial}
    \newfontfamily{\greekfont}{Linux Libertine O}   % CMU Serif
    \newfontfamily{\greekfontsf}{Linux Libertine O} % CMU Sans Serif
    \usepackage{polyglossia}
    \setdefaultlanguage{english}
    \setotherlanguage{greek}
    \usepackage{unicode-math}
    \usepackage{amsthm}
    \usepackage{latexsym}
    \usepackage{csquotes}
    % \setmainfont{XITS}
    % \setmathfont{XITS Math}
\else
    % default: pdfLaTeX
    \usepackage{minted}
    \usepackage{amssymb,amsmath,latexsym,amsthm}
    \usepackage[LGR,T1]{fontenc}
    \usepackage[utf8]{inputenc}
    \usepackage{lmodern}
    \usepackage[greek,english]{babel}
    \usepackage{csquotes}
\fi

\usepackage[normalem]{ulem}
\newcommand{\gr}{\selectlanguage{greek}}
\newcommand{\en}{\selectlanguage{english}}

%
% Set font mamily Aria
%
% \setmainfont[Ligatures={Common,TeX}]{Arial} % the passed option was needed for
%                                             % correctly rendering double quotes
% \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
% \setsansfont[Mapping=tex-text,Scale=MatchLowercase]{Arial}

%\ifglossaryInPreamble
%\RequirePackage[toc,section=chapter,numberedsection=false,nonumberlist]{glossaries}
%\else
% \RequirePackage[toc,section,numberedsection=nolabel,nonumberlist]{glossaries}
%\fi
%\makeglossaries

%
% Commands for first, middle, and last name (greek and english versions)
%
\providecommand{\authorFirstGr}[1]{\gdef\@authorFirstGr{{\gr #1}}}
\providecommand{\authorFirstAbrGr}[1]{\gdef\@authorFirstAbrGr{{\gr #1}}}
\providecommand{\authorMiddleGr}[1]{\gdef\@authorMiddleGr{{\gr #1}}}
\providecommand{\authorLastGr}[1]{\gdef\@authorLastGr{{\gr #1}}}
\providecommand{\authorFirstEn}[1]{\gdef\@authorFirstEn{#1}}
\providecommand{\authorFirstAbrEn}[1]{\gdef\@authorFirstAbrEn{#1}}
\providecommand{\authorMiddleEn}[1]{\gdef\@authorMiddleEn{#1}}
\providecommand{\authorLastEn}[1]{\gdef\@authorLastEn{#1}}

%
% Commands for the title of the thesis (greek and english versions)
%
\providecommand{\titleGr}[1]{\gdef\@titleGr{{\gr #1}}}
\providecommand{\titleEn}[1]{\gdef\@titleEn{#1}}

%
% Commands for the date of the writing of the thesis (Month followed by Year)
% [provide greek and english versions]
%
\providecommand{\dateGr}[1]{\gdef\@dateGr{{\gr #1}}}
\providecommand{\dateEn}[1]{\gdef\@dateEn{#1}}


%
% Commands for advisor
%
\providecommand{\advisorGr}[1]{\gdef\@advisorGr{{\gr #1}}}
\providecommand{\advisorRankGr}[1]{\gdef\@advisorRankGr{{\gr #1}}}
\providecommand{\advisorOrgGr}[1]{\gdef\@advisorOrgGr{{\gr #1}}}
\providecommand{\advisorEn}[1]{\gdef\@advisorEn{#1}}
\providecommand{\advisorRankEn}[1]{\gdef\@advisorRankEn{#1}}
\providecommand{\advisorOrgEn}[1]{\gdef\@advisorOrgEn{#1}}

%
% Commands for the 1st member of the advisory board
%
\newcommand{\boardOneGr}{\advisorGr}
\newcommand{\boardOneRankGr}{\advisorRankGr}
\newcommand{\boardOneOrgGr}{\advisorOrgGr}
\newcommand{\boardOneEn}{\advisorEn}
\newcommand{\boardOneRankEn}{\advisorRankEn}
\newcommand{\boardOneOrgEn}{\advisorOrgEn}

%
% Commands for the 2nd member of the examination board
%
\providecommand{\boardTwoGr}[1]{\gdef\@boardTwoGr{{\gr #1}}}
\providecommand{\boardTwoRankGr}[1]{\gdef\@boardTwoRankGr{{\gr #1}}}
\providecommand{\boardTwoOrgGr}[1]{\gdef\@boardTwoOrgGr{{\gr #1}}}
\providecommand{\boardTwoEn}[1]{\gdef\@boardTwoEn{#1}}
\providecommand{\boardTwoRankEn}[1]{\gdef\@boardTwoRankEn{#1}}
\providecommand{\boardTwoOrgEn}[1]{\gdef\@boardTwoOrgEn{#1}}

%
% Commands for the 3rd member of the examination board
%
\providecommand{\boardThreeGr}[1]{\gdef\@boardThreeGr{{\gr #1}}}
\providecommand{\boardThreeRankGr}[1]{\gdef\@boardThreeRankGr{{\gr #1}}}
\providecommand{\boardThreeOrgGr}[1]{\gdef\@boardThreeOrgGr{{\gr #1}}}
\providecommand{\boardThreeEn}[1]{\gdef\@boardThreeEn{#1}}
\providecommand{\boardThreeRankEn}[1]{\gdef\@boardThreeRankEn{#1}}
\providecommand{\boardThreeOrgEn}[1]{\gdef\@boardThreeOrgEn{#1}}

%
% Commands for the 1st member of the examination board
%
\newcommand{\examOneGr}{\advisorGr}
\newcommand{\examOneRankGr}{\advisorRankGr}
\newcommand{\examOneOrgGr}{\advisorOrgGr}
\newcommand{\examOneEn}{\advisorEn}
\newcommand{\examOneRankEn}{\advisorRankEn}
\newcommand{\examOneOrgEn}{\advisorOrgEn}

%
% Commands for the 2nd member of the examination board
%
\newcommand{\examTwogr}{\boardTwoGr}
\newcommand{\examTwoRankGr}{\boardTwoRankGr}
\newcommand{\examTwoOrgGr}{\boardTwoOrgGr}
\newcommand{\examTwoEn}{\boardTwoEn}
\newcommand{\examTwoRankEn}{\boardTwoRankEn}
\newcommand{\examTwoOrgEn}{\boardTwoOrgEn}

%
% Commands for the 3rd member of the examination board
%
\newcommand{\examThreeGr}{\boardThreeGr}
\newcommand{\examThreeRankGr}{\boardThreeRankGr}
\newcommand{\examThreeOrgGr}{\boardThreeOrgGr}
\newcommand{\examThreeEn}{\boardThreeEn}
\newcommand{\examThreeRankEn}{\boardThreeRankEn}
\newcommand{\examThreeOrgEn}{\boardThreeOrgEn}

%
% Commands for the 4th member of the examination board
%
\providecommand{\examFourGr}[1]{\gdef\@examFourGr{{\gr #1}}}
\providecommand{\examFourRankGr}[1]{\gdef\@examFourRankGr{{\gr #1}}}
\providecommand{\examFourOrgGr}[1]{\gdef\@examFourOrgGr{{\gr #1}}}
\providecommand{\examFourEn}[1]{\gdef\@examFourEn{#1}}
\providecommand{\examFourRankEn}[1]{\gdef\@examFourRankEn{#1}}
\providecommand{\examFourOrgEn}[1]{\gdef\@examFourOrgEn{#1}}

%
% Commands for the 5th member of the examination board
%
\providecommand{\examFiveGr}[1]{\gdef\@examFiveGr{{\gr #1}}}
\providecommand{\examFiveRankGr}[1]{\gdef\@examFiveRankGr{{\gr #1}}}
\providecommand{\examFiveOrgGr}[1]{\gdef\@examFiveOrgGr{{\gr #1}}}
\providecommand{\examFiveEn}[1]{\gdef\@examFiveEn{#1}}
\providecommand{\examFiveRankEn}[1]{\gdef\@examFiveRankEn{#1}}
\providecommand{\examFiveOrgEn}[1]{\gdef\@examFiveOrgEn{#1}}

%
% Commands for the 6th member of the examination board
%
\providecommand{\examSixGr}[1]{\gdef\@examSixGr{{\gr #1}}}
\providecommand{\examSixRankGr}[1]{\gdef\@examSixRankGr{{\gr #1}}}
\providecommand{\examSixOrgGr}[1]{\gdef\@examSixOrgGr{{\gr #1}}}
\providecommand{\examSixEn}[1]{\gdef\@examSixEn{#1}}
\providecommand{\examSixRankEn}[1]{\gdef\@examSixRankEn{#1}}
\providecommand{\examSixOrgEn}[1]{\gdef\@examSixOrgEn{#1}}

%
% Commands for the 7th member of the examination board
%
\providecommand{\examSevenGr}[1]{\gdef\@examSevenGr{{\gr #1}}}
\providecommand{\examSevenRankGr}[1]{\gdef\@examSevenRankGr{{\gr #1}}}
\providecommand{\examSevenOrgGr}[1]{\gdef\@examSevenOrgGr{{\gr #1}}}
\providecommand{\examSevenEn}[1]{\gdef\@examSevenEn{#1}}
\providecommand{\examSevenRankEn}[1]{\gdef\@examSevenRankEn{#1}}
\providecommand{\examSevenOrgEn}[1]{\gdef\@examSevenOrgEn{#1}}

%
% Commands for setting up the dates for the examination
%
\providecommand{\examinationDateGr}[1]{\gdef\@examinationDateGr{{\gr #1}}}
\providecommand{\examinationDateEn}[1]{\gdef\@examinationDateEn{#1}}

%
% Commands for setting up abstract (greek and english versions), ack (english
% version), synopsis (greek version only), incsriptionEn (english version
%only), and prefaceEn (english version only) pages
%
\providecommand{\abstractEn}[1]{\gdef\@abstractEn{#1}}
\providecommand{\abstractGr}[1]{\gdef\@abstractGr{{\gr #1}}}
\providecommand{\synopsisGr}[1]{\gdef\@synopsisGr{{\gr #1}}}
\providecommand{\acksEn}[1]{\gdef\@acksEn{#1}}
\providecommand{\inscriptionEn}[1]{\gdef\@inscriptionEn{%
\vspace*{0.2\textheight}
\begin{flushright}
#1
\end{flushright}
}}
\providecommand{\prefaceEn}[1]{\gdef\@prefaceEn{#1}}

%
% Commands for Subject Area and Keywords fields
% (greek and english versions)
%
\providecommand{\subjectAreaGr}[1]{\gdef\@subjectAreaGr{{\gr #1}}}
\providecommand{\subjectAreaEn}[1]{\gdef\@subjectAreaEn{#1}}
\providecommand{\keywordsGr}[1]{\gdef\@keywordsGr{#1}}
\providecommand{\keywordsEn}[1]{\gdef\@keywordsEn{#1}}

%
% Command for specifiying the file containing the publications
% in the context of the PhD.
%
\providecommand{\lopfile}[1]{\newcites{lop}{List of
publications}\gdef\@lopfileinternal{#1}}

%
% Command for starting a new unumbered chapter (ToC'ed) for
% holding the table of abbreviations and acronyms. The table
% should be set by the user.
%
\providecommand{\abbreviations}{
  \chapter*{ABBREVIATIONS - ACRONYMS}
  \addcontentsline{toc}{chapter}{ABBREVIATIONS - ACRONYMS}
}

%
% Front page (greek and english versions)
%
\def\@frontpage{
\begin{center}
\includegraphics{assets/athena-black}
\end{center}
\begin{minipage}[t]{\textwidth}
    \begin{center}
      {\large \bfseries
      \ifenglishfrontpage
      	NATIONAL AND KAPODISTRIAN UNIVERSITY OF ATHENS
      \else {\gr
        ΕΘΝΙΚΟ ΚΑΙ ΚΑΠΟΔΙΣΤΡΙΑΚΟ ΠΑΝΕΠΙΣΤΗΜΙΟ ΑΘΗΝΩΝ }
      \fi
      }
      \linebreak

      {\bfseries
      \ifenglishfrontpage
      	SCHOOL OF SCIENCES \\ DEPARTMENT OF INFORMATICS AND TELECOMMUNICATIONS
      \else
        {\gr
        ΣΧΟΛΗ ΘΕΤΙΚΩΝ ΕΠΙΣΤΗΜΩΝ \\ ΤΜΗΜΑ  ΠΛΗΡΟΦΟΡΙΚΗΣ ΚΑΙ ΤΗΛΕΠΙΚΟΙΝΩΝΙΩΝ
        }
      \fi
      }
      \linebreak

      {\bfseries
      \ifenglishfrontpage
        PROGRAM OF POSTGRADUATE STUDIES
      \else
        {\gr ΠΡΟΓΡΑΜΜΑ  ΜΕΤΑΠΤΥΧΙΑΚΩΝ ΣΠΟΥΔΩΝ }
      \fi}
      \linebreak\linebreak\linebreak
      \linebreak\linebreak\linebreak

      {\bfseries
      \ifenglishfrontpage
      	PhD THESIS
      \else
        {\gr ΔΙΔΑΚΤΟΡΙΚΗ ΔΙΑΤΡΙΒΗ }
      \fi}
      \linebreak\linebreak\linebreak

      {\Large \bfseries
      \ifenglishfrontpage
      	\@titleEn
      \else
      	\@titleGr
      \fi}
      \linebreak\linebreak\linebreak

      {\bfseries
      \ifenglishfrontpage
	  	\@authorFirstEn{} \@authorMiddleEn{} \@authorLastEn
	  \else
	  	\@authorFirstGr{} \@authorMiddleGr{} \@authorLastGr
	  \fi}
    \end{center}
\end{minipage}
    \vfill
    \begin{center}
    {\bfseries
     \ifenglishfrontpage
     	ATHENS
     \else
        {\gr ΑΘΗΝΑ }
     \fi
    }
    \linebreak

    {\bfseries
     \ifenglishfrontpage
     	\@dateEn
     \else
     	\@dateGr
     \fi
     }
    \end{center}
    \clearpage

    \newpage\null\newpage
}

%
% Committee page (greek and english versions)
%
\def\@committeepage{
\begin{center}
{\bfseries
\ifenglishcommitteepage
	PhD THESIS
\else
	{\gr ΔΙΔΑΚΤΟΡΙΚΗ ΔΙΑΤΡΙΒΗ }
\fi
}
\linebreak

{
\ifenglishcommitteepage
	\@titleEn
\else
	\@titleGr
\fi
}
\linebreak

{\bfseries
\ifenglishcommitteepage
	\@authorFirstEn{} \@authorMiddleEn{} \@authorLastEn
\else
	\@authorFirstGr{} \@authorMiddleGr{} \@authorLastGr
\fi
}
\linebreak\linebreak
\end{center}

{
\ifenglishcommitteepage%
    {\bfseries SUPERVISOR: \@advisorEn{}}, \@advisorRankEn{}
    \@advisorOrgEn{}\\
\else
    {\bfseries \gr ΕΠΙΒΛΕΠΩΝ ΚΑΘΗΓΗΤΗΣ: \@advisorGr{}}, \@advisorRankGr{}
	\@advisorOrgGr{}\\
\fi
}
%\linebreak\linebreak
%\linebreak

{
\ifenglishcommitteepage
	{\bfseries THREE-MEMBER ADVISORY COMMITTEE:}
\else
	{\bfseries \gr ΤΡΙΜΕΛΗΣ ΕΠΙΤΡΟΠΗ ΠΑΡΑΚΟΛΟΥΘΗΣΗΣ:}
\fi
}

{
\ifenglishcommitteepage
\hspace{2cm}{\bfseries \@advisorEn{}}, \@advisorRankEn{} \@advisorOrgEn{}

\hspace{2cm}{\bfseries \@boardTwoEn{}}, \@boardTwoRankEn{} \@boardTwoOrgEn{}

\hspace{2cm}{\bfseries \@boardThreeEn{}}, \@boardThreeRankEn{}
\@boardThreeOrgEn{}\\
\else
\hspace{2cm}{\bfseries \@advisorGr{}}, \@advisorRankGr{} \@advisorOrgGr{}

\hspace{2cm}{\bfseries \@boardTwoGr{}}, \@boardTwoRankGr{} \@boardTwoOrgGr{}

\hspace{2cm}{\bfseries \@boardThreeGr{}}, \@boardThreeRankGr{}
\@boardThreeOrgGr{}\\
\fi
}

\begin{center}
{\bfseries
\ifenglishcommitteepage
	SEVEN-MEMBER EXAMINATION COMMITTEE
\else
	{\gr ΕΠΤΑΜΕΛΗΣ ΕΞΕΤΑΣΤΙΚΗ ΕΠΙΤΡΟΠΗ}
\fi
}
\end{center}

{\bfseries
  \centering
  \begin{tabular*}{\textwidth}{p{0.5\textwidth}@{\hskip 1.5cm}p{0.4\textwidth}}
    & \\[0.5cm]
    \ifenglishcommitteepage
    \@advisorEn{}, \newline \@advisorRankEn{} \@advisorOrgEn{}
    &
    \@boardTwoEn{}, \newline \@boardTwoRankEn{} \@boardTwoOrgEn{}
    \\[1cm]
    \@boardThreeEn{}, \newline \@boardThreeRankEn{} \@boardThreeOrgEn{}
    &
    \@examFourEn{}, \newline \@examFourRankEn{} \@examFourOrgEn{}
    \\[1cm]
    \@examFiveEn{}, \newline \@examFiveRankEn{} \@examFiveOrgEn{}
    &
    \@examSixEn{}, \newline \@examSixRankEn{} \@examSixOrgEn{}
    \\[1cm]
    \@examSevenEn{}, \newline \@examSevenRankEn{} \@examSevenOrgEn{}
    \\
    \else
    \@advisorGr{}, \newline \@advisorRankGr{} \@advisorOrgGr{}
    &
    \@boardTwoGr{}, \newline \@boardTwoRankGr{} \@boardTwoOrgGr{}
    \\[1cm]
    \@boardThreeGr{}, \newline \@boardThreeRankGr{} \@boardThreeOrgGr{}
    &
    \@examFourGr{}, \newline \@examFourRankGr{} \@examFourOrgGr{}
    \\[1cm]
    \@examFiveGr{}, \newline \@examFiveRankGr{} \@examFiveOrgGr{}
    &
    \@examSixGr{}, \newline \@examSixRankGr{} \@examSixOrgGr{}
    \\[1cm]
    \@examSevenGr{}, \newline \@examSevenRankGr{} \@examSevenOrgGr{}
    \\
    \fi
  \end{tabular*}
}


\vfill
\begin{center}
{\bfseries
\ifenglishcommitteepage
	Examination Date: \@examinationDateEn
\else
	{\gr Ημερομηνία Εξέτασης}: \@examinationDateGr
\fi
}
\end{center}
\clearpage
\newpage\null\newpage
}

%
% Abstract (english version)
%
\def\@absEn{
  \chapter*{Abstract}
  \thispagestyle{empty}
  \@abstractEn{}
  \vfill

  {\bfseries SUBJECT AREA}: \@subjectAreaEn\\

  {\bfseries KEYWORDS}: \@keywordsEn
}

%
% Abstract (greek version)
%
\def\@absGr{
  {\gr
    \chapter*{ΠΕΡΙΛΗΨΗ}
    \thispagestyle{empty}
    \@abstractGr{}
    \vfill

    {\bfseries ΘΕΜΑΤΙΚΗ ΠΕΡΙΟΧΗ}: \@subjectAreaGr\\

    {\bfseries ΛΕΞΕΙΣ ΚΛΕΙΔΙΑ}: \@keywordsGr

    \clearpage
  }
}

%
% Greek synopsis of the thesis
%
\def\@synopsis{
  {\gr
    \chapter*{ΣΥΝΟΠΤΙΚΗ ΠΑΡΟΥΣΙΑΣΗ ΤΗΣ ΔΙΔΑΚΤΟΡΙΚΗΣ ΔΙΑΤΡΙΒΗΣ}
    \thispagestyle{empty}
    \@synopsisGr{}
  }
    \clearpage
}

%
% Inscription page (optional)
%
% Enable it by passing option ``inscr'' to the document class.
%
\def\@inscr{
  \cleardoublepage
  \@inscriptionEn{}
  \clearpage
}

%
% Acknowledgements (optional)
%
% Enable it by passing option ``ack'' to the document class.
%
\def\@acks{
  \chapter*{Acknowledgments}
  \thispagestyle{empty}
  \@acksEn{}
  \clearpage
}

%
% Preface page (optional)
%
% Enable it by passing option ``preface'' to the document class.
%
% Check the following page that gives a definition among the uses of Prologue,
% Foreword, and Preface:
%http://iankingsleyauthor.blogspot.de/2013/03/defined-prologue-epilogue-foreword.html.
%
\def\@preface{
  \chapter*{Preface}
  \thispagestyle{empty}
  \@prefaceEn{}
  \clearpage
}

%
% List of publications (optional)
%
% Enable it by passing option ``lop'' to the document class.
%
\def\@listofpubs{
  \bibliographystylelop{unsrt}
  \bibliographylop{\@lopfileinternal}
  \thispagestyle{empty}
  \clearpage
}

%
% Configure the frontmatter page
%
\renewcommand{\frontmatter}{
    \pagestyle{empty}

    % frontpage - english version
    \englishfrontpagetrue
    \@frontpage

    % frontpage - greek version
    \englishfrontpagefalse
    \@frontpage

    % examination committe page - english version
    \englishcommitteepagetrue
    \@committeepage

    % examination committe page - greek version
    \englishcommitteepagefalse
    \@committeepage

    % abstract (english and greek version)
    \@absEn
    \@absGr

    % acknowledgements (english version only, OPTIONAL)
    \ifackpage
    	\@acks
    \fi

    % list of publications (english version only, OPTIONAL)
    \ifloppage
       	\@listofpubs
    \fi

    % thesis synopsis (greek version only, OPTIONAL)
    \@synopsis
    \ifinscriptionpage
       	\@inscr
    \fi

    % table of contents
    % add TOC as bookmark
    \addtocontents{toc}{\protect{\pdfbookmark[0]{CONTENTS}{toc}}}
    \tableofcontents

    % list of figures
    %\listoffigures
    %\thispagestyle{empty}
    \cleardoublepage
    \begingroup
    \makeatletter
    \let\ps@plain\ps@empty
    \makeatother

    \pagestyle{empty}
    \listoffigures
    \cleardoublepage
    \endgroup

    % % list of tables
    % \listoftables
    % \thispagestyle{empty}

    % preface page (english version only, OPTIONAL)
    % \ifprefacepage
    %     \@preface
    % \fi

    % Prepare things for the rest of the document
    \clearpage
    \thispagestyle{empty}
}

%
% Configure the mainmatter and backmatter pages
%
\renewcommand{\mainmatter}{
	% just set the style of the pages to be fancy
    \pagestyle{fancy}
}
\renewcommand{\backmatter}{
	% just set the style of the pages to be fancy
    \pagestyle{fancy}

    % and also, make the empty page style permanent, since
    % when a \chapter command is invoked, the command
    % \thispagestyle{plain} is invoked
    % (thanks to http://tex.stackexchange.com/a/19741)
    %\patchcmd{\chapter}{plain}{empty}{}{}
}

%
% Configure chapter printing and alignment (centered)
%
\def\@makechapterhead#1{%
  %\vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \interlinepenalty\@M
    \ifappendixstarted
       \large \centering \bfseries APPENDIX \thechapter. \MakeTextUppercase{#1}
    \else
	   \large \centering \bfseries \thechapter. \MakeTextUppercase{#1}
    \fi
    \par\nobreak
    \vskip 20\p@
  }}

\chaptertitlefont{\vspace*{-2.38cm} \large \centering \MakeTextUppercase}
\sectionfont{\normalsize}
\subsectionfont{\normalsize}
\subsubsectionfont{\normalsize}
\paragraphfont{\normalsize}
\subparagraphfont{\normalsize}

% use capital letters for chapters in the ToC as well
% TODO

%
% Rename Bibliography to References
%
\renewcommand{\bibname}{REFERENCES}

%
% Set ToC depth
%
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{3}

%
% No indentation for paragraphs
%
\setlength{\parindent}{0pt}

%
% Paragraph spacing should be
%
\setlength{\parskip}{6pt}

%
% Line spacing should be one line
%
\linespread{1}

%
% Configure header and footer
%
%\pagestyle{fancy}
\fancyhf{}
\fancyhead[LEO]{{\footnotesize \@titleEn{}}}
\fancyfoot[C]{{\footnotesize \thepage}}
\fancyfoot[LE,RO]{{\footnotesize \@authorFirstAbrEn{} \@authorLastEn{}}}

% needed redefinition, because commands like \chapter call
% \thispagestyle{plain} automatically
\fancypagestyle{plain} {
  \fancyhf{}
  \fancyhead[LO]{{\footnotesize \@titleEn{}}}
  \fancyfoot[C]{{\footnotesize \thepage}}
  \fancyfoot[LE,RO]{{\footnotesize \@authorFirstAbrEn{} \@authorLastEn{}}}
}
\renewcommand{\headrulewidth}{0pt}

%
% Configure the first page of ToC to have an empty pagestyle
% (thanks to http://tex.stackexchange.com/a/5789)
%
\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}}
