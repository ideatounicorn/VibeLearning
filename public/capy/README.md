# Capy — VibeLearn mascot art

Drop nano-banana-pro generated PNGs in this folder. The `<Capy />` React component auto-picks them up.

## Required poses

| File | When it appears | Recommended pose |
|---|---|---|
| `hi.png` | Default — greetings, intros, narration | Friendly head-tilt, eye contact, paw raised |
| `thinking.png` | When user reading dense content, before a quiz | Paw on chin, slight side glance, soft squint |
| `celebrating.png` | Done stage, correct answer, completion | Arms up / leap pose, eyes wide, mouth grin |
| `oops.png` | Wrong answer, gentle correction | Sheepish, paw scratching head |

## Design spec

- **Style:** sticker — bold outline, flat fill with soft inner gradient, 1–2px grain. NOT photoreal. NOT cute-3D-render.
- **Palette:** warm beige body (#D4A574), darker brown extremities, neon-green #c8ff00 accent (collar / sweatband / single prop).
- **Background:** TRANSPARENT PNG. No backdrop, no shadow plate.
- **Size:** 512×512 minimum, square crop, character fills ~80% of canvas.
- **Mood:** confident, calm, slightly nerdy. Think: "your friend who reads ArXiv for fun."

## Nano-banana prompt template

```
Sticker-style illustration of a capybara named Cap, [POSE DESCRIPTION].
Bold black outline, flat color fill with subtle inner gradient and light grain texture.
Warm beige fur (#D4A574), brown extremities, single neon green (#c8ff00) accent (collar tag or sweatband).
Transparent background. Square 512x512. Character fills 80% of canvas.
Friendly, confident, calm, slightly nerdy. NOT 3D-rendered. NOT photoreal. Mobile sticker aesthetic.
```

Variants — append to template:

- `hi.png`: "head slightly tilted, one paw raised in friendly wave, soft smile, looking directly at camera"
- `thinking.png`: "paw resting on chin, eyes glancing up and to the side, slight squint, mouth flat"
- `celebrating.png`: "both arms raised in victory, eyes wide and bright, open-mouth grin, leaping slightly"
- `oops.png`: "one paw scratching back of head, sheepish closed-mouth smile, eyes slightly closed"
