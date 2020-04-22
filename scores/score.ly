% The /scores folder contains your scores. Use one file per final score and name them
% in an intuitive way. For a string quartet you might have 5 files here:
% score.ly, violin1.ly, violin2.ly, viola.ly, cello.ly
% Each of those files defines the score (or possibly book) for the respective instrument
% while score.ly defines the full score.
%
% The actual music should be defined in the music folder and included here.
\version "2.20.0"

\include "pdq/pdq.ily" % Use the PDQ layout

\include "music/violin.ly"

\header {
  title = "My LilyPond Project"
  composer = "Your name here"
  opus = "op.42"
  instrument = "Full Score"
}

\score {
  \layout {
    \scoreLayout
  }
  % Include our notes here. The staves are created as part of the score/part.
  \new Staff = "Violin" \with {
    instrumentName = "Violin"
    shortInstrumentName = "Vl."
  } \ViolinNotes
}