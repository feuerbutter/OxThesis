% ociamthesis
% 
% Originally by Keith A. Gillow (gillow@maths.ox.ac.uk), 1997
% Modified by Sam Evans (sam@samuelevansresearch.org), 2007
% Modified by John McManigle (john@oxfordechoes.com), 2015
%
% This version Copyright (c) 2015-2017 John McManigle
%
% Broad permissions are granted to use, modify, and distribute this software
% as specified in the MIT License included in this distribution's LICENSE file.
%
%
%-------------------------- identification ---------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ociamthesis}[2015/04/30 Oxford thesis class]
%-------------------------- initial code -----------------------

% JEM: Defaults to one-side, but passing 'twoside' should set everything up for that
\LoadClass[openright,12pt]{report}

\newif\ifmc@nobind
\mc@nobindfalse

\DeclareOption{nobind}{\mc@nobindtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\setlength{\parskip}{0pt plus 1pt}
\setlength{\parfillskip}{0pt plus .7\textwidth}

% JEM: Lengths for single spacing (ie separate abstract, captions), front matter (abstract,
%   acknowledgements, table of contents, etc), and main body text.
\newlength{\singlebaselineskip}
\newlength{\frontmatterbaselineskip}
\newlength{\textbaselineskip}

\setlength{\singlebaselineskip}{\baselineskip}
\setlength{\frontmatterbaselineskip}{17pt plus1pt minus1pt}
\setlength{\textbaselineskip}{22pt plus2pt}

\newcommand{\submittedtext}{{A thesis submitted for the degree of}}
\usepackage{varwidth}
\newcommand{\originalitytext}{%
   \rule[-2mm]{1pt}{7mm}\hspace{-1pt}%
   \rule[-2mm]{7mm}{1pt}\hspace{-1pt}%
   \rule[-2mm]{1pt}{7mm}\hspace{-7mm}%
   \rule[5mm]{7mm}{1pt}\hspace{1em}%
   \begin{varwidth}{\textwidth}I hereby certify that this is entirely\\my own work unless otherwise stated.\end{varwidth}}

%
% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

% The year and term the degree will be officially conferred
\def\degreedate#1{\gdef\@degreedate{#1}}
% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}
% The name of your Oxford college (eg Christ Church, Pembroke)
\def\college#1{\gdef\@college{#1}}
% Your candidate number (ie for master's submissions)
\def\candidateno#1{\gdef\@candidateno{#1}}
% Your word count (for master's submissions)
\def\wordcount#1{\gdef\@wordcount{#1}}
\newif\ifmasterssubmission
% adds candidate number and word count in place of name and college
\masterssubmissionfalse


%
% CRESTS
%

\def\crest{{\includegraphics{figures/beltcrest.pdf}}}


%
% Define text area of page and margin offsets
%

\ifmc@nobind
\usepackage[includehead,hmargin={3.1cm, 3.1cm}, vmargin={2.5cm,2.7cm}, headsep=.8cm,footskip=1.2cm]{geometry}
\else
\usepackage[includehead,hmargin={3.6cm, 2.6cm}, vmargin={2.5cm,2.7cm}, headsep=.8cm,footskip=1.2cm]{geometry}
\fi

\usepackage{xcolor}
\usepackage{graphicx} 

\usepackage{fancyhdr}
\setlength{\headheight}{15pt}
\fancyhf{} % clear the header and footers
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter. #1}{\thechapter. #1}}
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}} 
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LO]{\emph{\leftmark}} 
\fancyhead[RE]{\emph{\rightmark}} 
\fancyhead[RO,LE]{\emph{\thepage}}

\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\emph{\thepage}}}

% JEM fix header on cleared pages for openright
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
   \hbox{}
   \fancyhead[RE,LO]{}
   \newpage
   \if@twocolumn\hbox{}\newpage
   \fi
   \fancyhead[LO]{\emph{\leftmark}} 
   \fancyhead[RE]{\emph{\rightmark}} 
   \fi\fi}


\usepackage{microtype}
\usepackage{nicefrac}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{textcomp}

\usepackage{longtable} 
	% Allows tables to span multiple pages (this package must be called before hyperref)

\usepackage[font=small,labelfont=bf]{caption} 
	% Nicer captions

\usepackage{multicol,multirow,array} 
	% Used to make multiple columns for the indices and for creating columns that span multiple rows in tables

\usepackage{rotating} 
	% To allow tables in landscape mode

\usepackage{booktabs} 
	% For better looking tables

\usepackage{pdfpages} 
	% Allows multi-page pdfs to be inserted as graphics

\usepackage{xfrac}

%\usepackage{enumerate} 
	% Allows different numbering styles for Lists
	% to use:
	% \begin{enumerate}[x] 
		% \item text 
	% \end{enumerate} 
	% where x is:
	% A	uppercase letters (as produced by \Alph)
	% a	lowercase letters (as produced by \alph)
	% I	uppercase roman numerals (as produced by \Roman)
	% i	lowercase roman numerals (as produced by \roman)
	% 1	arabic numbers (as produced by \arabic)
	
% JEM the following package allows changing spacing in lists (for acknowledgements)
\usepackage{enumitem}

% JEM the following allows table columns aligned by decimal point
\usepackage{dcolumn}
\newcolumntype{d}[3]{D{.}{\cdot}{#1} }

\usepackage{appendix} 
	% For helping format appendicies
\usepackage{notoccite} 
	% To format the bibliography	


\usepackage[colorlinks=false,pdfpagelabels]{hyperref} 
	% for linking between references, figures, TOC, etc in the pdf document

\usepackage[nohints,tight]{minitoc} 
	\setcounter{minitocdepth}{2} 
	% Generates mini tables of contents per chapter
	
% JEM: The following fixes minitoc to not be multiple-spaced.
\let\oldmtc@verse\mtc@verse
\renewcommand{\mtc@verse}[1]{\oldmtc@verse{#1}\setlength{\baselineskip}{\z@}}


%
% Environments
%

% This macro define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}


%define title page layout

\renewcommand{\maketitle}{%
\begin{alwayssingle}\null
    \renewcommand{\footnotesize}{\small}
    \renewcommand{\footnoterule}{\relax}
    \thispagestyle{empty}
\ifmasterssubmission
  \begin{center}
  \vspace*{-3ex}
    { \LARGE {\bfseries {\@title}} \par}
{\large \vspace*{25mm} {\crest \par} \vspace*{20mm}}
    {{\Large Candidate no.\ \@candidateno} \par}
{\large \vspace*{1ex}
    {Word count: {\@wordcount} \par}
\vspace*{4ex}
    {{\submittedtext} \par}
\vspace*{1ex}
    {\it {\@degree} \par}
\vspace*{6ex}
	{{\originalitytext} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}
\else
  \begin{center}
    { \LARGE {\bfseries {\@title}} \par}
{\large \vspace*{30mm} {\crest \par} \vspace*{25mm}}
    {{\Large \@author} \par}
{\large \vspace*{1ex}
    {{\@college} \par}
\vspace*{1ex}
    {University of Oxford \par}
\vspace*{20mm}
    {{\submittedtext} \par}
\vspace*{1ex}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}
\fi
  \vfill\null
\end{alwayssingle}}



% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.

\newenvironment{dedication}
{\begin{alwayssingle}
  \thispagestyle{empty}
  \vspace*{\fill} \begin{center}}
{\end{center}\vspace*{\fill}\vspace*{\fill} \end{alwayssingle}}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}%
{   \begin{alwayssingle}\chapter*{Acknowledgements}
    \thispagestyle{empty}
	\pagestyle{empty}
	\setlength{\baselineskip}{\frontmatterbaselineskip}
}
{\end{alwayssingle}}


%ABSTRACT
%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.

\renewenvironment{abstract}%
{   \begin{alwayssingle}\chapter*{Abstract}
    \thispagestyle{empty}
    \pagestyle{empty}
   \setlength{\baselineskip}{\frontmatterbaselineskip}}
{\end{alwayssingle}}

%The abstractseparate environment is for running of a page with the abstract
%on including title and author etc as required to be handed in separately

\newenvironment{abstractseparate} {\newgeometry{margin=3.3cm}\thispagestyle{empty}\begin{alwayssingle}
 \begin{center}
    {\Large \bfseries \@title \par}
\ifmasterssubmission
    {{\large \vspace*{3ex} Candidate no.\ \@candidateno} \par}
\else
    {{\large \vspace*{2ex} \@author} \par}
\fi
{\large \vspace*{1ex}
\ifmasterssubmission
    {Thesis word count: {\@wordcount} \par}
\else
    {{\@college} \par}
    {University of Oxford \par}
\fi
\vspace*{1ex}
    {{\it \submittedtext} \par}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate} \par}
\vfill
  {\Large \bfseries  Abstract}
  \end{center}
\vspace{1ex}
   \setlength{\baselineskip}{\z@}}
{\vfill\end{alwayssingle}\restoregeometry}


%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).
%
% Edited by JEM

\newenvironment{romanpages}
{\cleardoublepage\setlength{\baselineskip}{\frontmatterbaselineskip}\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\cleardoublepage\setcounter{page}{1}\renewcommand{\thepage}{\arabic{page}}}


%Figure placement on page
%
%This is to help prevent too many figures on their own pages.  I got it from:
% http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/LatexTips.html#captfont

\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}


% JEM: VERSE, QUOTATION, and QUOTE must be single-spaced.
% These rename the internal commands for the \begin{...} and
% \end{...} environment commands.
\let\@ldquote=\quote
\let\@ldendquote=\endquote
\renewenvironment{quote}
   {\@ldquote\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendquote}

\let\@ldqttn=\quotation
\let\@ldendqttn=\endquotation
\renewenvironment{quotation}
   {\@ldqttn\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendqttn}

\let\@ldverse=\verse
\let\@ldendverse=\endverse
\renewenvironment{verse}
   {\@ldverse\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendverse}

% JEM: Stuff for List of Abbreviations (or Glossary or other list)
\usepackage{calc}
\newcommand{\t@cfill}{\cleaders\hbox{$\m@th \mkern\@dotsep mu . \mkern\@dotsep mu$}\hfill}
\newcommand{\abbrl@bel}[1]{\makebox[\labelwidth][l]{\textbf{#1}\ \t@cfill}}
\newenvironment{mclistof}[2]{%
   \chapter*{#1}%
   \addcontentsline{toc}{chapter}{#1}
   \begin{list}{}%
   {\renewcommand{\makelabel}{\abbrl@bel}%
    \setlength{\labelwidth}{#2}%
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\itemsep}{0pt}%
    \markboth{#1}{#1}%
   }}
   {\end{list}\mtcaddchapter}


\usepackage[grey,utopia]{quotchap} 
	% To put nice quotes at the beginning of the chapters

\usepackage[nottoc]{tocbibind}
	% Used for inserting the Bibliography, List of Figures, indices, etc into the table of contents.

% JEM: Allow flexible spacing after figures, to reduce other stretching
\setlength{\textfloatsep}{20pt plus15pt minus4pt}

% JEM: Fix paragraph spacing within quotes for multi-par quotes
\renewenvironment{savequote}[1][10cm]{%
\begin{lrbox}{\@quotebox}
\begin{minipage}[t]{#1}\footnotesize\slshape%
\setlength{\parskip}{6pt}}{%
\unskip\end{minipage}\end{lrbox}
\global\setbox\@quotebox\copy\@quotebox
\global\let\@printcites\@iprintcites
\ignorespacesafterend}
\renewcommand{\qauthor}[1]{\par
{\raggedleft\upshape #1\qquad\hbox{}\par}\bigskip}

% JEM: All of this is so that headers in these sections aren't uppercase
\let\@ldtoc\tableofcontents
\renewcommand*\tableofcontents{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldtoc}}
\let\@ldlof\listoffigures
\renewcommand*\listoffigures{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlof}}
\let\@ldlot\listoftables
\renewcommand*\listoftables{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlot}}
\let\@ldbib\bibliography
\renewcommand*\bibliography[1]{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldbib{#1}}}

% JEM: for crazy multi character set quotes and Unicode and all
\usepackage{lmodern}
\usepackage[LGR,TS1,T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[greek,latin,english]{babel}
\usepackage{csquotes}
\hyphenpenalty=500
\def\longs{{\fontencoding{TS1}\selectfont s}}

% JEM: for highlighting corrections
\newlength{\mccurrentbaselineskip}
\newlength{\mccurrentparskip}
\newlength{\mccurrentparindent}
\newif\ifcorrections
\newif\ifm@csection
\m@csectionfalse
\correctionsfalse

\colorlet{shadecolor}{blue!20}

\usepackage{framed}
\OuterFrameSep=-9pt
\newenvironment{mccorrection}
{\ifcorrections\if@nobreak\m@csectiontrue\fi\begin{shaded}\ifm@csection\noindent\ignorespaces\fi\fi}
{\ifcorrections\end{shaded}\m@csectionfalse\ifx\@captype\@undefined\@nobreakfalse\fi\fi}

\usepackage{soul}
\sethlcolor{shadecolor}
\newcommand{\mccorrect}[1]{\ifcorrections\hl{#1}\else#1\fi}


% JEM: adjust start-of-chapter spacing
\renewcommand{\chapterheadstartvskip}{\vspace*{40pt}}
\renewcommand{\chapterheadendvskip}{\vspace{30pt}}


% JEM: combine all of the commands you run before appendices start
\newcommand{\startappendices}
  {\appendix\adjustmtc\noappendicestocpagenum\addappheadtotoc\appendixpage}


\usepackage{subcaption}
\usepackage{braket}
\usepackage{tikz}
\usepackage{tikz-feynman}
\usepackage{CJKutf8}
% ------ units --------
\newcommand{\gevc}{\textrm{GeV}/c}
\newcommand{\mevc}{\textrm{MeV}/c}
\newcommand{\gev}{\textrm{GeV}}
\newcommand{\mev}{\textrm{MeV}}
\newcommand{\kev}{\textrm{keV}}
\newcommand{\ev}{\textrm{eV}}
\newcommand{\cm}{\textrm{cm}}
\newcommand{\m}{\textrm{m}}
\newcommand{\km}{\textrm{km}}
\newcommand{\mm}{\textrm{mm}}
\newcommand{\ns}{\textrm{ns}}


% ------ particles ------
\newcommand{\nue}{\nu_{\textrm{e}}}
\newcommand{\nuebar}{\bar{\nu_{\textrm{e}}}}
\newcommand{\numu}{\nu_{\mu}}
\newcommand{\numubar}{\bar{\nu_{\mu}}}
\newcommand{\p}{\textrm{p}}
\newcommand{\n}{\textrm{n}}
\newcommand{\pip}{\pi^+}
\newcommand{\pim}{\pi^-}
\newcommand{\piz}{\pi^0}
\newcommand{\piC}{\pi^{\pm}}
\newcommand{\deltapp}{\Delta^{++}}

% ------ Topologies -------
\newcommand{\cczpi}{\textrm{CC}0\pi}
\newcommand{\ccopi}{\textrm{CC}1\pi}
\newcommand{\ccopiop}{\textrm{CC}1\pi1\textrm{p}}
\newcommand{\numucczpi}{\nu_{\mu}\textrm{CC}0\pi}
\newcommand{\numucczpinp}{\nu_{\mu}\textrm{CC}0\pi N\textrm{p}}
\newcommand{\numuccopi}{\nu_{\mu}\textrm{CC}1\pi}
\newcommand{\numuccopinp}{\nu_{\mu}\textrm{CC}1\pi N\textrm{p}}
\newcommand{\numucczpiop}{\nu_{\mu}\textrm{CC}0\pi1\textrm{p}}
\newcommand{\numuccopiop}{\nu_{\mu}\textrm{CC}1\pi1\textrm{p}}
\newcommand{\numuccopipnp}{\nu_{\mu}\textrm{CC}1\pi^+ N\textrm{p}}
\newcommand{\numuccmpiznp}{\nu_{\mu}\textrm{CC}M\pi^0 N\textrm{p}}
\newcommand{\numucc}{\nu_{\mu}\textrm{CC}}


% ------ Variables -------
% --- TKI
\newcommand{\dat}{\delta\alpha_\textrm{T}}
\newcommand{\dphit}{\delta\phi_\textrm{T}}
\newcommand{\pn}{p_\textrm{N}}
\newcommand{\dpt}{\delta p_\textrm{T}}
\newcommand{\vecdpt}{\delta \vec{p}_\textrm{T}}
\newcommand{\dptx}{\delta p_\textrm{Tx}}
\newcommand{\dpty}{\delta p_\textrm{Ty}}
\newcommand{\dptt}{\delta p_\textrm{TT}}
\newcommand{\pt}{p_\textrm{T}}
\newcommand{\pmut}{p_{\mu}^T}
\newcommand{\dptmupi}{\delta p_{\textrm{T},\,\mu\&\pi}}

% --- COM
\newcommand{\psum}{p_{\textrm{sum}}}
\newcommand{\vecpsum}{\vec{p}_{\textrm{sum}}}
\newcommand{\esum}{E_{\textrm{sum}}}
\newcommand{\vecppicom}{\vec{p}_{\pi}^{(\textrm{COM})}}
\newcommand{\thetacom}{\theta_{\textrm{COM}}}
\newcommand{\ecom}{E_{\textrm{COM}}}
\newcommand{\thetaadt}{\theta_{\textrm{Adt}}}
\newcommand{\thetapidel}{\theta_{\pi\Delta}}
\newcommand{\thetaR}{\theta_{\pi\textrm{R}}}
\newcommand{\pdel}{p_{\Delta}}
\newcommand{\vecpdel}{\vec{p}_{\Delta}}

\newcommand{\plong}{p_{\textrm{long}}}

\newcommand{\mn}{M_{\textrm{N}}}

\newcommand{\chindf}{\chi^2/{\textrm{NDF}}}
% --- SPK
\newcommand{\pp}{p_\textrm{p}}
\newcommand{\ppr}{p_\textrm{p}}
\newcommand{\tpr}{\theta_\textrm{p}}
\newcommand{\thetap}{\theta_\textrm{p}}
\newcommand{\ep}{E_\textrm{p}}
\newcommand{\ppi}{p_{\pi}}
\newcommand{\tpi}{\theta_{\pi}}
\newcommand{\epi}{E_{\pi}}
\newcommand{\enu}{E_{\nu}}
\newcommand{\vecpp}{\vec{p}_\textrm{p}}
\newcommand{\vecppi}{\vec{p}_{\pi}}
\newcommand{\vecppp}{\vec{p}_\textrm{p}^{\prime}}
\newcommand{\vecppip}{\vec{p}_{\pi}^{\prime}}
\newcommand{\vecppirest}{\vec{p}_{\pi}^{(0)}}
\newcommand{\pnu}{p_{\nu}}
\newcommand{\pmu}{p_{\mu}}
\newcommand{\vecpnu}{\vec{p}_{\nu}}
\newcommand{\vecpl}{\vec{p}_{l}}
\newcommand{\vecpmu}{\vec{p}_{\mu}}
\newcommand{\mdeldec}{m_{\Delta}^{(0)}}
\newcommand{\mdel}{m_{\Delta}}


\newcommand{\tmupi}{\theta_{\mu\pi}}
\newcommand{\mmupi}{M_{\mu\pi}}

\newcommand{\dedx}{\,\textrm{d}E/\,\textrm{d}x}

% ------ Parameters -------
\newcommand{\MA}{M_{\textrm{A}}}
\newcommand{\dcp}{\delta_\textrm{CP}}
\newcommand{\umas}{U_{\alpha}}
\newcommand{\uae}{U_{e}}
\newcommand{\uam}{U_{\mu}}


\newcommand{\cpimfp}{S_\lambda^{\pi^{\pm}}}
\newcommand{\pizmfp}{S_\lambda^{\pi^{0}}}
\newcommand{\picex}{S_\textrm{CEX}^{\pi}}
\newcommand{\piinel}{S_\textrm{INEL}^{\pi}}
\newcommand{\cpiabs}{S_\textrm{ABS}^{\pi^{\pm}}}
\newcommand{\pizabs}{S_\textrm{ABS}^{\pi^0}}
\newcommand{\pipiprod}{S_\textrm{PIPD}^{\pi}}
\newcommand{\nmfp}{S_\lambda^\textrm{N}}
\newcommand{\ncex}{S_\textrm{CEX}^\textrm{N}}
\newcommand{\ninel}{S_\textrm{INEL}^\textrm{N}}
\newcommand{\nabs}{S_\textrm{ABS}^\textrm{N}}
\newcommand{\npiprod}{S_\textrm{PIPD}^\textrm{N}}

\newcommand{\srcfr}{R_\textrm{SRC}}
\newcommand{\nurmec}{E_\textrm{RM}^\textrm{C}}

% ------ PMNS ------------
\newcommand{\totwo}{\theta_{12}}
\newcommand{\tothr}{\theta_{13}}
\newcommand{\ttthr}{\theta_{23}}
\newcommand{\delmtwoo}{\Delta m^2_{21}}
\newcommand{\delmthro}{|\Delta m^2_{31}|}
\newcommand{\delmthrt}{\Delta m^2_{32}}

% ------ Tuning samples ------
\newcommand{\ttkzpi}{T2K-$0\pi$\xspace}
\newcommand{\ttkpip}{T2K-$\pi^{+}$\xspace}

\newcommand{\minzpi}{MINERvA-$0\pi$\xspace}
\newcommand{\minpiz}{MINERvA-$\pi^{0}$\xspace}

% ------ Coding ------------
\newcommand{\genie}{\texttt{GENIE}}
% -- tunes
\newcommand{\blue}[1]{\color{blue}#1\color{black}}
\newcommand{\geighteen}{\texttt{G18\_10a\_02\_11b}}
\newcommand{\newtune}{\texttt{G24\_20i\_00\_000}\xspace}
\newcommand{\restunefull}{\texttt{G24\_20i\_06\_22c}\xspace}
\newcommand{\restunefsi}{\texttt{G24\_20i\_FSIParaOnly\_partial}\xspace}
\newcommand{\alttune}{\texttt{G24\_20i\_fullpara\_alt}\xspace}

\newcommand{\gZero}{\texttt{G24-0}\xspace}
\newcommand{\gC}{\texttt{G24-c}\xspace}
\newcommand{\gT}{\texttt{G24-t}\xspace}

\newcommand{\geoa}{\texttt{G18-01a}}
\newcommand{\getwoa}{\texttt{G18-02a}}
\newcommand{\geta}{\texttt{G18-10a}}
\newcommand{\getb}{\texttt{G18-10b}}


% ------ Latex utils --------
% \newcommand{\blue}[1]{\textcolor{blue}{#1}}
\newcommand{\code}[1]{\texttt{#1}}
% \newcommand{\deg}{\ensuremath{^\circ}}
% \newcommand{\degree}{^\circ}
\newcommand{\tick}{\checkmark}

\newcommand{\sgfigwid}{0.6}
\newcommand{\dbfigwid}{0.45}
\newcommand{\trfigwid}{0.3}

% ------ tuning specific ------
\newcommand{\redpar}{\texttt{RedPar}\xspace}
\newcommand{\allpar}{\texttt{AllPar}\xspace}
\newcommand{\cbRedPar}{\texttt{Combi-Best-\redpar}\xspace}
\newcommand{\cbAllPar}{\texttt{Combi-Best-\allpar}\xspace}
\newcommand{\cSuper}{\texttt{Combi-Super}\xspace}

\newcommand{\sfcfg}{SF-CFG\xspace}
