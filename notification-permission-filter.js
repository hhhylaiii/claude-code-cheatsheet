#!/usr/bin/env node
/**
 * Notification Permission Filter Hook
 *
 * The Notification event fires for both idle (CC waiting for input) and
 * permission requests (tool needs approval). This script filters the payload
 * and only triggers a macOS notification for actual permission requests.
 *
 * Hook type: Notification
 */

'use strict';

const { spawnSync } = require('child_process');

const PERMISSION_KEYWORDS = [
  'permission', 'approve', 'approval', 'allow',
  'tool use', 'wants to run', 'requires your', 'authorize',
  'bash', 'read', 'write', 'edit'
];

function isPermissionRequest(input) {
  // Check if there's an explicit type field
  if (input.type && typeof input.type === 'string') {
    const t = input.type.toLowerCase();
    if (t.includes('permission') || t.includes('approval')) return true;
    if (t === 'idle' || t === 'waiting' || t === 'complete') return false;
  }

  // Fall back to keyword scan of the full payload
  const text = JSON.stringify(input).toLowerCase();
  return PERMISSION_KEYWORDS.some(kw => text.includes(kw));
}

function notifyMacOS(title, body) {
  const safeBody = body.replace(/\\/g, '').replace(/"/g, '“');
  const safeTitle = title.replace(/\\/g, '').replace(/"/g, '“');
  const script = `display notification "${safeBody}" with title "${safeTitle}"`;
  spawnSync('osascript', ['-e', script], { stdio: 'ignore', timeout: 5000 });
}

function run(raw) {
  try {
    const input = JSON.parse(raw || '{}');
    if (isPermissionRequest(input)) {
      notifyMacOS('Claude Code', 'Your approval is needed!');
    }
  } catch (_err) {
    // silent fail — never block the notification event
  }
  return raw;
}

module.exports = { run };

if (require.main === module) {
  let data = '';
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', chunk => { data += chunk; });
  process.stdin.on('end', () => {
    const output = run(data);
    if (output) process.stdout.write(output);
  });
}
