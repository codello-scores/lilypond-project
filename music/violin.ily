% The music folder contains the actual musical expressions. The files in this folder
% should not actually print anything but instead define variables that can be used in
% a score.
\version "2.20.0"

ViolinNotes = \relative c' {
  \clef treble \key c \major \time 4/4
  \tempo "Andante"
  c d e f |
  g a b c |
  \bar "|."
}