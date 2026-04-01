#!/usr/bin/env bash
# Claude Code status line script
# Layout: Context [bar] XX% | Usage [bar] XX% (Xh Xm / 5h) | [bar] XX% (Xd Xh / 7d)

input=$(cat)
now=$(date +%s)

# ---------------------------------------------------------------------------
# Helper: build a progress bar (10 chars wide) from a percentage (0-100)
# Usage: make_bar <percentage>
# ---------------------------------------------------------------------------
make_bar() {
  local pct="$1"
  local filled empty bar i
  filled=$(echo "$pct" | awk '{v=int($1/10 + 0.5); if(v>10) v=10; print v}')
  empty=$((10 - filled))
  bar=""
  for i in $(seq 1 "$filled"); do bar="${bar}█"; done
  for i in $(seq 1 "$empty");  do bar="${bar}░"; done
  printf "%s" "$bar"
}

# ---------------------------------------------------------------------------
# Helper: format elapsed seconds into "Xh Xm" (for 5-hour window)
# ---------------------------------------------------------------------------
fmt_hm() {
  local secs="$1"
  local h m
  h=$(( secs / 3600 ))
  m=$(( (secs % 3600) / 60 ))
  printf "%dh %dm" "$h" "$m"
}

# ---------------------------------------------------------------------------
# Helper: format elapsed seconds into "Xd Xh" (for 7-day window)
# ---------------------------------------------------------------------------
fmt_dh() {
  local secs="$1"
  local d h
  d=$(( secs / 86400 ))
  h=$(( (secs % 86400) / 3600 ))
  printf "%dd %dh" "$d" "$h"
}

# ---------------------------------------------------------------------------
# Context window
# ---------------------------------------------------------------------------
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$used_pct" ]; then
  bar=$(make_bar "$used_pct")
  pct_int=$(printf "%.0f" "$used_pct")
  ctx_part=$(printf "\033[36mContext [%s] %d%%\033[0m" "$bar" "$pct_int")
else
  ctx_part=$(printf "\033[36mContext [░░░░░░░░░░] 0%%\033[0m")
fi

# ---------------------------------------------------------------------------
# 5-hour rate limit
# ---------------------------------------------------------------------------
five_pct=$(echo "$input"    | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input"  | jq -r '.rate_limits.five_hour.resets_at // empty')

if [ -n "$five_pct" ] && [ -n "$five_reset" ]; then
  bar=$(make_bar "$five_pct")
  pct_int=$(printf "%.0f" "$five_pct")
  window=18000  # 5 hours in seconds
  remaining=$(( five_reset - now ))
  [ "$remaining" -lt 0 ] && remaining=0
  elapsed=$(( window - remaining ))
  [ "$elapsed" -lt 0 ] && elapsed=0
  elapsed_fmt=$(fmt_hm "$elapsed")
  five_part=$(printf "\033[33mUsage [%s] %d%% (%s / 5h)\033[0m" "$bar" "$pct_int" "$elapsed_fmt")
else
  five_part=$(printf "\033[33mUsage [░░░░░░░░░░] --%%\033[0m")
fi

# ---------------------------------------------------------------------------
# 7-day rate limit
# ---------------------------------------------------------------------------
week_pct=$(echo "$input"    | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_reset=$(echo "$input"  | jq -r '.rate_limits.seven_day.resets_at // empty')

if [ -n "$week_pct" ] && [ -n "$week_reset" ]; then
  bar=$(make_bar "$week_pct")
  pct_int=$(printf "%.0f" "$week_pct")
  window=604800  # 7 days in seconds
  remaining=$(( week_reset - now ))
  [ "$remaining" -lt 0 ] && remaining=0
  elapsed=$(( window - remaining ))
  [ "$elapsed" -lt 0 ] && elapsed=0
  elapsed_fmt=$(fmt_dh "$elapsed")
  week_part=$(printf "\033[33m[%s] %d%% (%s / 7d)\033[0m" "$bar" "$pct_int" "$elapsed_fmt")
else
  week_part=$(printf "\033[33m[░░░░░░░░░░] --%%\033[0m")
fi

# ---------------------------------------------------------------------------
# Assemble
# ---------------------------------------------------------------------------
printf "%s | %s | %s\n" "$ctx_part" "$five_part" "$week_part"
