// Cap-curated video dive: one video, TV-framed, then recap + quiz.
// Language tuned so an 8-year-old gets it.

export const GIT_100S_DIVE = {
  slug: 'git-100s',
  title: 'Git in 100 seconds',
  topicLabel: 'GitHub · Dive 2 of 5',

  video: {
    youtubeId: 'hwP7WQkmECE', // Fireship — Git Explained in 100 Seconds
    title: 'Git Explained in 100 Seconds',
    creator: 'Fireship',
    duration: '1:33',
    pickedFrom: 47, // "Cap watched 47 git videos so you don't have to"
    difficulty: 1, // 1-5
    whyThisOne:
      'The shortest, clearest one on the whole internet. No filler. By the end you’ll know what git really is — not just the commands.',
    skillsAfter: [
      { emoji: '⏱️', label: 'What git really is' },
      { emoji: '🌿', label: 'Why branches matter' },
      { emoji: '☁️', label: 'How code reaches the team' },
    ],
    watchFor: [
      'The word "snapshot" — that’s the whole idea',
      'The Y-shape when branches split',
      '`push` vs `pull` — direction matters',
    ],
  },

  intro: {
    eyebrow: 'Cap curated',
    headline: 'I found you the perfect video.',
    sub: 'Git, the whole thing, in 100 seconds. Watch with me — I’ll be right next to you.',
    placard: 'I found this for you ✦',
    capySays:
      'Out of 47 git videos, this is the one. Watch it once. Then we’ll see if it stuck. You don’t need to take notes — I will.',
  },

  watch: {
    placard: 'Cap is watching with you',
    capyHints: [
      'Listen for the word "snapshot." That’s the whole idea.',
      'When you see the Y-shape — that’s a branch splitting.',
      'Don’t worry about the commands. I’ll explain those after.',
    ],
    cta: 'I watched it →',
  },

  recap: {
    eyebrow: 'What you just saw',
    headline: 'Five things to keep.',
    sub: 'If you forget everything else, keep these.',
    cards: [
      {
        emoji: '⏱️',
        title: 'Git is a save button with memory',
        body: 'Every `commit` is like taking a photo of your code. You can flip back through the album any time.',
        color: '#FFB58A',
      },
      {
        emoji: '🌿',
        title: 'Branches are "what if" copies',
        body: 'Want to try something risky? Make a branch. Your `main` stays safe. Merge back when it works.',
        color: '#A8E6CF',
      },
      {
        emoji: '☁️',
        title: '`push` goes up. `pull` comes down.',
        body: '`push` = send your work to the team. `pull` = grab their latest. `clone` = your very first download.',
        color: '#C084FC',
      },
      {
        emoji: '⚠️',
        title: 'Two people, one line = conflict',
        body: 'When two people change the same line, git stops and asks *you* which one wins. That’s all a conflict is.',
        color: '#F5E1A4',
      },
      {
        emoji: '🤝',
        title: 'GitHub is git, but social',
        body: 'Git lives on your laptop. GitHub is the meeting room where your branches go to be reviewed and shipped.',
        color: '#c8ff00',
      },
    ],
    capySays:
      'These five sentences ARE git. Every command is just a tool for one of these ideas.',
  },

  quiz: {
    eyebrow: 'Quick check',
    questions: [
      {
        q: 'Pick the best one-liner for what git is.',
        options: [
          { label: 'A cloud service that hosts your website', correct: false, why: 'That’s a host like Vercel. Git is something you run on *your own* computer to keep track of changes.' },
          { label: 'A save button with memory — every save is a photo you can flip back to', correct: true, why: 'Yes. That’s the whole idea. Each commit is a snapshot. The history is your photo album.' },
          { label: 'A programming language', correct: false, why: 'Git doesn’t run your code. It only watches it change. Like Track Changes in Google Docs, but for whole folders.' },
        ],
      },
      {
        q: 'You make a `commit`. What just happened?',
        options: [
          { label: 'You took a labeled snapshot of all your changes', correct: true, why: 'Right. A commit = snapshot + a message saying what you did. It’s the smallest unit of git history.' },
          { label: 'Your changes are now on GitHub', correct: false, why: 'Not yet. A commit lives on your laptop only — until you `push`.' },
          { label: 'Your file was saved to disk', correct: false, why: 'Saving and committing are different. You save many times. You commit when a chunk of work feels "done enough" to label.' },
        ],
      },
      {
        q: 'Your teammate added new code. You want it. Which command?',
        options: [
          { label: '`git push`', correct: false, why: '`push` sends *yours* to them. Wrong direction.' },
          { label: '`git pull`', correct: true, why: 'Yes. `pull` brings their latest down to your machine. Think of it like opening your mailbox.' },
          { label: '`git clone`', correct: false, why: 'That’s only for your *first* download of a brand-new repo. After that, it’s `pull`.' },
        ],
      },
      {
        q: 'You and a friend both edited the same line. What happens?',
        options: [
          { label: 'Git silently keeps the newer change', correct: false, why: 'Git refuses to guess. It would rather stop and ask you than lose someone’s work.' },
          { label: 'A merge conflict — git asks you to choose which line stays', correct: true, why: 'Exactly. A conflict isn’t a bug. It’s git protecting both versions until *you* decide.' },
          { label: 'The whole project breaks', correct: false, why: 'Nothing breaks. The conflict only lives in your local copy until you fix it.' },
        ],
      },
      {
        q: 'Why make a "feature branch" instead of just editing `main`?',
        options: [
          { label: 'Branches make git faster', correct: false, why: 'Speed is the same. The real reason is *safety + review*.' },
          { label: 'You can try things without breaking `main`, and your team can review before it’s merged', correct: true, why: 'Yes. Branches give you a safe sandbox + a natural moment for a Pull Request. `main` stays shippable.' },
          { label: 'It’s legally required', correct: false, why: 'It’s a strong convention but not a law. Some tiny solo repos commit straight to `main`.' },
        ],
      },
    ],
  },

  pride: {
    headline: 'You can now actually explain git.',
    body: 'Most people who use git daily can’t do this. You just did.',
    skills: [
      'Explain git to a friend in one sentence',
      'Know what a commit, branch, push, pull and conflict actually are',
      'Tell why teams use feature branches and PRs',
    ],
  },

  quit: {
    headline: 'Wait — already?',
    body: 'You’re part way through. Cap will lose his place.',
    stay: 'Keep learning',
    leave: 'Quit anyway',
  },
}
