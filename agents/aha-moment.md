# Agent: Aha Moment Optimization

The aha moment is when a user passes their first quiz and feels real progress. Currently the quiz completion screen is functional but doesn't maximize the "this is working" feeling that drives upgrade conversion. Fix that. Also add a soft upgrade nudge at the right moment — after the user has earned it, not before.

## File: `src/components/quiz/QuizClient.tsx`

Read the full file before making changes. The `finished` state (line 35) controls the end screen. The `finalPassed` and `finalXP` values are available.

### On quiz PASS (`finalPassed === true`)
The completion screen needs to feel like a win. Add:

1. A large animated XP number: `+150 XP` in green, animates counting up from 0
2. A progress statement: `"Module [N] of [total] complete"` — you'll need to pass `moduleIndex` and `totalModules` as props from the page
3. A streak nudge: `"Day [N] streak 🔥"` — fetch from existing streak data or pass as prop
4. Keep the "Next module →" button as the primary CTA
5. Add a soft secondary CTA below the next button — only show if user is on their 2nd module pass (first time they'd hit the paywall on module 3):

```
Enjoying the path? Unlock all [22] modules for $29/month →
```

This link goes to `/upgrade`. Do NOT show this on the first quiz pass. Only after module 2.

### On quiz FAIL (`finalPassed === false`)
Keep encouragement. Do not show upgrade CTA here — the user doesn't feel good yet.

### Props to add
```ts
interface Props {
  // existing props...
  moduleIndex: number      // 1-based position in course
  totalModules: number
  streakCount: number
  isLastFreeModule: boolean  // true when moduleIndex === 2
}
```

Pass these from `src/app/quiz/[moduleId]/page.tsx` — read that file to find where QuizClient is rendered and pass the new props from the existing DB query data.

## File: `src/components/learn/LessonPlayer.tsx`

Read the full file. Find where the lesson completes / "next" button is shown.

Add a subtle banner ONLY when `isPro === false` AND the user is on their last free lesson (module 2, last lesson). Banner text:

```
You're about to finish your free preview. Unlock the full path for $29/month.
```

Style it like a `pill-green` or amber bar at the bottom of the player — non-blocking, dismissible with an X.

## Done when
- Quiz pass screen shows animated XP, module progress, streak
- Upgrade nudge appears only after module 2 pass (not before)
- Lesson player shows non-blocking banner on last free lesson
- Quiz fail screen has no upgrade CTA
