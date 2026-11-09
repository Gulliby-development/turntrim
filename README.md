<p align="center"><img src="docs/logo.svg" width="96" alt="" /></p>

# turntrim

[![CI](https://github.com/Gulliby-development/turntrim/actions/workflows/ci.yml/badge.svg)](https://github.com/Gulliby-development/turntrim/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

turntrim is a small offline command-line tool for people who prepare, inspect, or automate chat transcripts in a terminal, script, or CI job. It reads token counts supplied with each turn; it does not call a model, count tokens, use the network, or depend on a clock. Runtime requirements are R 4.1 or newer and base R, on Windows, macOS, and Linux. The test and lint tools are development dependencies, not runtime dependencies.

## Usage

From the repository directory, run a command as `Rscript exec/turntrim.R COMMAND`, providing the transcript on standard input. In the POSIX shell examples below, `turntrim` stands for this shell function:

```sh
turntrim() { Rscript exec/turntrim.R "$@"; }
```

The command synopsis is:

```text
usage: turntrim check
       turntrim share
       turntrim fit --budget N [--keep-last K]
       turntrim drop --budget N [--keep-last K]
       turntrim chunks --max N
       turntrim cost --price-in P --price-out Q
```

`check` validates a transcript; `share` totals tokens by role; `fit` marks turns kept or dropped to fit a budget; `drop` lists dropped turn numbers; `chunks` groups turns into bounded contiguous pieces; and `cost` estimates price from token counts and supplied prices.

The first word selects a command and is case-sensitive. The first word `help`, `-h`, or `--help` prints the synopsis, and `--version` prints `turntrim 0.1.0`; these forms ignore any following words. With no command, the synopsis is written to standard error. Any other first word, including an empty word, is an unknown command.

Options may appear in either order after the command. `fit` and `drop` require `--budget N` and optionally accept `--keep-last K`; the latter defaults to 0. `chunks` requires `--max N`. `cost` requires both `--price-in P` and `--price-out Q`. `check` and `share` accept no options. There is no `--option=value` form. Values are unsigned decimal whole numbers without leading zeroes (except the value 0): budget and max are 1–9999999, keep-last is 0–40, and each price is 0–100000. Each option consumes the next word as its value, even if that word looks like an option.

Arguments are validated left to right. A word not starting with a hyphen, or exactly `-`, is an unexpected argument; a hyphen-prefixed word other than the five recognized option names is an unknown option. For a recognized option, validation checks whether it is valid for the command, repeated, missing its value, or has a bad value, in that order. The first invalid word wins. Afterward, missing required options are reported in the synopsis order: budget, max, then price-in and price-out. The command line is validated before any transcript is read. Standard input is read only for a valid use of one of the six commands; help, version, and invalid command lines do not read it.

## Transcript

Each non-skipped line contains `ROLE TOKENS` or `ROLE TOKENS pin`. Roles are exactly `system`, `user`, `assistant`, and `tool`; token counts are decimal whole numbers from 1 through 999999, with no sign or leading zero. The optional third word must be exactly `pin`. A system turn or pinned turn is fixed; other turns are free.

Input is split at line feeds. A final line without a line feed still counts, while empty input has no lines. One carriage return at the end of each line is removed. Spaces and tabs separate words and are trimmed at line ends. Lines containing only spaces and tabs, and lines whose first word starts with `#`, are skipped. Skipped lines count toward the 40-physical-line maximum but are not turns. More than 40 lines is rejected before any other transcript error. Otherwise lines are checked in order: word count, role, token count, then optional flag. A transcript with no turns is rejected. Error line numbers refer to physical lines, including skipped lines; turn numbers refer only to parsed turns.

## Output

Successful commands write their report to standard output and nothing to standard error. Counts use singular nouns only for 1 (for example, `1 turn` and `0 tokens`).

- `check` prints `ok, N turns, T tokens`, with the turn count and token sum.
- `share` prints one row for each role present, ordered system, user, assistant, tool, as `ROLE TOKENS PERCENT%`, followed by `total T`. Percentages have one decimal place and use integer half-up rounding.
- `fit` prints `N keep` or `N drop` for each turn in order, then `kept A of M turns, T tokens`. Fixed turns always stay. If fixed turns exceed the budget, fitting fails. Next, the last K free turns are protected (all free turns if fewer than K); if fixed and protected turns together exceed the budget, fitting fails. Remaining free turns are considered newest first. If one does not fit, it and every older free turn are dropped; the scan stops, so a smaller older turn is not reconsidered.
- `drop` uses the same decision and refusal rules as `fit`, but prints dropped turn numbers in increasing order on one line, or `none` if nothing is dropped.
- `chunks` greedily groups consecutive turns until adding the next would exceed the maximum, then starts another chunk. It prints each chunk's number, turn range (or single turn), and token total, followed by the chunk count. A turn larger than the maximum causes failure before any chunk report is printed.
- `cost` treats tokens from assistant turns as output and all other tokens as input. Prices are whole US cents per million tokens. It prints input and output token counts, then cost in dollars with exactly six digits after the decimal point. The total cost is rounded half up to millionths of a dollar.

## Examples

The following POSIX shell examples are run from the repository directory after defining the `turntrim` shell function shown above:

```text
$ printf 'system 50\nuser 120\nassistant 300\nuser 80\nassistant 250\n' | turntrim fit --budget 400
1 keep
2 drop
3 drop
4 keep
5 keep
kept 3 of 5 turns, 380 tokens
$ printf 'user 100\nassistant 200\ntool 50\n' | turntrim share; printf 'user 5\ntool 6\nuser 7\n' | turntrim chunks --max 12
user 100 28.6%
assistant 200 57.1%
tool 50 14.3%
total 350
chunk 1: turns 1-2, 11 tokens
chunk 2: turn 3, 7 tokens
2 chunks
$ printf 'user 1000\nassistant 500\n' | turntrim cost --price-in 300 --price-out 1500; printf 'user 5\nassistant 6\n' | turntrim drop --budget 6
input 1000 tokens
output 500 tokens
cost $0.010500
1
$ printf 'user 5\nbot 6\n' | turntrim check 2>&1; printf 'user 5\n' | turntrim fit 2>&1
turntrim: line 2: bad role bot
turntrim: missing --budget
```

## Errors

Exit status 0 means success, 1 means a transcript or command error, and 2 means a command-line error. On success, output is on standard output and standard error is empty. On failure, standard output is empty and the error is written to standard error as one line ending in a line feed. The exception is a missing command: it prints the usage synopsis to standard error and exits 2. Validation order is command line, then the entire transcript, then command behavior, so an earlier-stage error takes precedence.

Command-line errors use these exact messages:

- `turntrim: unknown command WORD`
- `turntrim: unexpected argument WORD`
- `turntrim: unknown option WORD`
- `turntrim: option OPTION is not valid for COMMAND`
- `turntrim: given twice: OPTION`
- `turntrim: missing value for OPTION`
- `turntrim: bad value for OPTION`
- `turntrim: missing OPTION`

Transcript errors use these exact messages:

- `turntrim: input is too long (max 40 lines)`
- `turntrim: line N: expected ROLE TOKENS [pin]`
- `turntrim: line N: bad role WORD`
- `turntrim: line N: bad tokens WORD`
- `turntrim: line N: bad flag WORD`
- `turntrim: no turns`

Command errors use these exact messages:

- `turntrim: fixed turns need F tokens, budget is B`
- `turntrim: last K turns do not fit: need X tokens, budget is B`
- `turntrim: turn N has T tokens, more than M`

For the message templates, WORD, OPTION, COMMAND, N, F, B, K, X, T, and M are replaced by the relevant word, option, command, line/turn number, or count.

## Development

Run the automated tests and lint checks from the repository directory:

```sh
Rscript -e 'testthat::test_local()'
Rscript -e 'lintr::lint_package()'
```

testthat and lintr are development tools; turntrim's runtime uses base R only.

---

Built with [BAKED](https://github.com/Gulliby-development/baked), an open-source coding agent (bench round R101).
