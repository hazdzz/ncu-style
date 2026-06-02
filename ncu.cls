% Class declarations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ncu}
\LoadClassWithOptions{article}

% Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[top=2.25cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{microtype}
\RequirePackage{placeins}
\RequirePackage{hyphenat}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage[latin, english]{babel}
\RequirePackage{lipsum}
\RequirePackage{etoolbox}

\DisableLigatures[f]{family=sf*} 

% Math %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{mathtools}

% Graphics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage{subcaption}

% Tables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{booktabs}
\RequirePackage{nicematrix}
\RequirePackage{multirow}
\RequirePackage{bm}
\RequirePackage{threeparttable}
\newcommand{\nm}[1]{#1}

% Colorful stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[most]{tcolorbox}
\RequirePackage{xcolor}
\definecolor{ncublue}{HTML}{00609A}
\definecolor{ncufg}{HTML}{1C2B33}
\definecolor{ncubg}{HTML}{F5F5F5}

% References %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{hyperref}
\RequirePackage[noabbrev,nameinlink]{cleveref}
\hypersetup{
  colorlinks,
  linkcolor=ncublue,
  citecolor=ncublue,
  urlcolor=ncublue,
  bookmarksdepth=3
}

\RequirePackage[round,authoryear]{natbib}
\def\bibfont{\small}

% Section and caption format %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}
% Heading text uses IBM Plex Sans (\sffamily\bfseries), while the heading
% math mode uses the IBM Plex Serif "plexserif" math version.
\titleformat{\paragraph}[runin]{\normalfont\bfseries\sffamily}{}{0pt}{}
\titlespacing*{\paragraph}{0pt}{1.25mm}{1em}
\titleformat*{\section}{\mathversion{plexserif}\Large\sffamily\bfseries}
\titleformat*{\subsection}{\mathversion{plexserif}\large\sffamily\bfseries}
\titleformat*{\subsubsection}{\mathversion{plexserif}\normalsize\sffamily\bfseries}
% Make \textbf always use IBM Plex Sans bold (used, for example, in captions).
\DeclareTextFontCommand{\textbf}{\bfseries\sffamily}

\newcommand{\subsubsubsection}[1]{\paragraph{#1}\mbox{}\\}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\textbf{#1 #2}} #3}
\captionsetup{singlelinecheck=false,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% Fonts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Body text uses Latin Modern (lmodern); IBM Plex Sans is the sans family
% used by titles and headings; IBM Plex Mono is the monospace family used by
% code and URLs.
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[scale=0.92, semibold]{plex-sans}
\RequirePackage[scale=0.92]{plex-mono}

% Load IBM Plex Serif only to obtain its NFSS family for the math version.
% plex-serif sets \rmdefault to the IBM Plex Serif family, so we save the
% current body roman default first, capture the IBM Plex Serif family, and
% then restore the body roman font (Latin Modern) afterwards.
\let\ncubodyrmdefault\rmdefault
\RequirePackage[scale=0.92]{plex-serif}
\edef\ncuplexseriffamily{\rmdefault}
\let\rmdefault\ncubodyrmdefault

% Math version for the title and the headings: IBM Plex Serif %%%%%%%%%%%%%%%%%
% This math version is activated only inside the title and the section
% headings, so the body math keeps the default Latin Modern fonts.
\DeclareMathVersion{plexserif}
% Variable letters a-z and A-Z use the IBM Plex Serif italic shape.
\SetSymbolFont{letters}{plexserif}{T1}{\ncuplexseriffamily}{\bfdefault}{it}
% Digits and upright operators use the IBM Plex Serif upright shape.
\SetSymbolFont{operators}{plexserif}{T1}{\ncuplexseriffamily}{\bfdefault}{n}

% Authors, affiliations, infos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\addtolist[5][]{
  \begingroup
    \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi
    \let\protect\@unexpandable@protect 
    \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
  \endgroup
}

\newcommand\authorlist{}
\newcommand\authorformat[2][]{{\sffamily \bfseries #2$^{#1}$}}
\renewcommand\author[2][]{\addtolist[#1]{#2}{\authorlist}{\authorformat}{, }}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\normalsize $^{#1}$#2}}
\newcommand\affiliation[2][]{\addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{, }}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\small $^{#1}$#2}}
\newcommand\contribution[2][]{\addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand\ncudatalist{}
\newcommand\ncudataformat[2][]{{\small {\sffamily \bfseries #1:} #2}}
\newcommand\ncudata[2][]{\addtolist[#1]{#2}{\ncudatalist}{\ncudataformat}{\par}}

\renewcommand{\abstract}[1]{\def\abstractlist{{\color{ncufg} #1}}}
\AtBeginDocument{\urlstyle{tt}}
\newcommand{\code}[1]{\texttt{#1}}
\newcommand{\codeurl}[1]{\href{#1}{\nolinkurl{#1}}}
\newcommand{\email}[1]{\href{mailto:#1}{\nolinkurl{#1}}}

\renewcommand\date[1]{\ncudata[Date]{#1}}
\newcommand\correspondence[1]{\ncudata[Correspondence]{#1}}
\newcommand\codelink[1]{\ncudata[Code]{\codeurl{#1}}}
\newcommand\preprintformat[2][]{{\small\sffamily\bfseries #2}}
\newcommand\preprint[1]{\addtolist{#1}{\ncudatalist}{\preprintformat}{\par}}

% Title text uses IBM Plex Sans (\sffamily\bfseries), while the title math
% mode uses the IBM Plex Serif "plexserif" math version.
\renewcommand{\title}[1]{\newcommand{\titlelist}{{\mathversion{plexserif}\huge\sffamily\bfseries #1}}}

\newcommand{\beginappendix}{\appendix{\huge\sffamily\bfseries Appendix\par}}

% Titlebox %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mymaketitle}{%
  \tcbset{enhanced,frame hidden}
  \tcbset{left=0.5cm}
  \tcbset{right=0.5cm}
  \tcbset{top=0.5cm}
  \tcbset{bottom=0.5cm}
  \tcbset{arc=10pt}
  \tcbset{colback=ncubg}
  \tcbset{before skip=0pt}
  \tcbset{grow to left by=1.5pt}
  \tcbset{grow to right by=1.5pt}
  \tcbset{
    overlay={\node[
        anchor=south east,
        at= (frame.south east),
        xshift=-0.30cm,
        yshift=-0.12cm] {\includegraphics[width=2.2cm]{assets/logo_ncu.pdf}};}
  }
  
  \begin{tcolorbox}
    \setlength{\parindent}{0cm}
    \setlength{\parskip}{0.5cm}
    {
      \setlength{\parskip}{0cm}
      \raggedright
      \nohyphens
      %
      {
        \setstretch{1.618}
        \titlelist\par
      }
      \vskip 0.2cm
      %
      \authorlist\par
      \vskip 0.2cm
      %
      \affiliationlist\par
      %
      \contributionlist\par
    }
    %
    \abstractlist\par
    %
    \vskip 0.5cm
    %
    {
      \setlength{\parskip}{0cm}
      \ifdefempty{\ncudatalist}{\vspace*{0.65cm}}{\ncudatalist\par}
    }
  \end{tcolorbox}
  \tcbset{reset}
  \FloatBarrier
}

\if@twocolumn%
\renewcommand{\maketitle}{
\twocolumn[%
  \mymaketitle
  \vskip 0.38cm
]
}%
\else%
\renewcommand{\maketitle}{
  \mymaketitle
}%
\fi
