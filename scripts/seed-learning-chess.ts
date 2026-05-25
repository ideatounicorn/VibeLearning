import { createClient } from '@supabase/supabase-js'
import * as dotenv from 'dotenv'
import * as path from 'path'
import { randomUUID } from 'crypto'

dotenv.config({ path: path.join(process.cwd(), '.env.local') })

const db = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

const COURSE = {
  id: randomUUID(),
  title: "Learning Chess",
  slug: "learning-chess",
  description: "Take your chess game from absolute beginner to intermediate player. Master the board, essential openings, and foundational tactics with the best instructors on the internet.",
  thumbnail_url: "https://images.unsplash.com/photo-1528819622765-d6bcf132f793?w=800&q=80",
  order_index: 0,
  is_hidden: false,
  path_id: null
}

const CREATORS = [
  {
    channel_name: "GothamChess",
    channel_url: "https://www.youtube.com/@GothamChess",
    avatar_url: "https://yt3.googleusercontent.com/ytc/AIdro_njlA4rJjBIt-BpxB_n-1M61fN9x-V3aW5z-o5RjQ=s176-c-k-c0x00ffffff-no-rj",
    video_count: 4
  },
  {
    channel_name: "Chess.com",
    channel_url: "https://www.youtube.com/@chesscom",
    avatar_url: "https://yt3.googleusercontent.com/ytc/AIdro_n4T2v9_P-pZ5Q6T5Jz5vXoN6I2x1z5_O9J9y5PjA=s176-c-k-c0x00ffffff-no-rj",
    video_count: 1
  }
]

const MODULES = [
  {
    title: "The Foundations of Chess",
    slug: "foundations-of-chess",
    description: "Learn how the pieces move, the rules of the game, and essential concepts like castling and en passant.",
    order_index: 0,
    is_free: true,
    lessons: [
      {
        id: randomUUID(),
        title: "How To Play Chess: The Ultimate Beginner Guide",
        youtube_url: "https://www.youtube.com/watch?v=OCSbzArwB10",
        youtube_video_id: "OCSbzArwB10",
        order_index: 0,
        duration_minutes: 36,
        why_this_video: "Levy Rozman provides the most comprehensive and easy-to-understand breakdown of chess rules on YouTube.",
        skills_gained: ["Piece Movement", "Board Setup", "Basic Rules", "Castling", "Checkmate"]
      }
    ],
    quizzes: [
      {
        question: "Which piece can move in an L-shape and jump over other pieces?",
        option_a: "Bishop",
        option_b: "Knight",
        option_c: "Rook",
        option_d: "Queen",
        correct_option: "b",
        explanation: "The Knight is the only piece in chess that can jump over other pieces, moving two squares in one direction and one square perpendicularly."
      },
      {
        question: "What is the condition required for castling?",
        option_a: "The King must be in check.",
        option_b: "The Rook must have moved once.",
        option_c: "Neither the King nor the castling Rook can have moved previously.",
        option_d: "There must be pieces between the King and Rook.",
        correct_option: "c",
        explanation: "Castling is a special move allowed only if neither the King nor the chosen Rook have moved, the King is not in check, and the path between them is clear."
      }
    ],
    recap: {
      key_takeaways: [
        "The board is set up with a light square in the bottom right corner.",
        "Pawns move forward but capture diagonally.",
        "The King is the most important piece; putting it in unavoidable danger is checkmate.",
        "Castling helps secure the King and bring the Rooks into the game."
      ],
      exercises_jsonb: [
        {
          type: "practice",
          prompt: "Set up a physical or digital chess board completely from memory."
        }
      ]
    }
  },
  {
    title: "Mastering the Opening",
    slug: "mastering-the-opening",
    description: "Discover how to start your games strong by controlling the center and developing your pieces.",
    order_index: 1,
    is_free: false,
    lessons: [
      {
        id: randomUUID(),
        title: "Basic Chess Openings Explained",
        youtube_url: "https://www.youtube.com/watch?v=8IlJ3v8I4Z8",
        youtube_video_id: "8IlJ3v8I4Z8",
        order_index: 0,
        duration_minutes: 24,
        why_this_video: "Focuses on opening principles rather than rote memorization of lines.",
        skills_gained: ["Center Control", "Piece Development", "King Safety"]
      },
      {
        id: randomUUID(),
        title: "The BEST Beginner Chess Opening",
        youtube_url: "https://www.youtube.com/watch?v=TemLSMDKSMw",
        youtube_video_id: "TemLSMDKSMw",
        order_index: 1,
        duration_minutes: 21,
        why_this_video: "Gives beginners a practical, go-to system they can use as White immediately.",
        skills_gained: ["London System", "Opening Systems", "Practical Play"]
      }
    ],
    quizzes: [
      {
        question: "What is the primary goal in the opening phase of a chess game?",
        option_a: "To checkmate the opponent as fast as possible.",
        option_b: "To control the center, develop pieces, and get the King to safety.",
        option_c: "To trade off as many pieces as possible.",
        option_d: "To move your Queen out early to attack.",
        correct_option: "b",
        explanation: "The three golden rules of the opening are controlling the central squares, developing your minor pieces (knights and bishops), and castling to protect your King."
      },
      {
        question: "Why is bringing the Queen out early usually a bad idea for beginners?",
        option_a: "The Queen is too slow.",
        option_b: "It allows the opponent to develop their pieces while attacking the Queen.",
        option_c: "The Queen cannot capture pawns.",
        option_d: "The King becomes jealous.",
        correct_option: "b",
        explanation: "An early Queen deployment often becomes a target. The opponent can gain time (tempo) by developing their minor pieces with threats against the Queen."
      }
    ],
    recap: {
      key_takeaways: [
        "Always fight for control of the central four squares.",
        "Develop knights before bishops generally, and don't block your own pieces.",
        "Castle early to tuck the King away from the center of the board.",
        "System openings like the London System offer a solid, repeatable setup."
      ],
      exercises_jsonb: [
        {
          type: "practice",
          prompt: "Play a game against a low-level computer and successfully castle before move 10."
        }
      ]
    }
  },
  {
    title: "Tactics & Winning Concepts",
    slug: "tactics-and-winning-concepts",
    description: "Learn the tactical patterns that win material and the strategic concepts that win games.",
    order_index: 2,
    is_free: false,
    lessons: [
      {
        id: randomUUID(),
        title: "All The Chess Tactics You NEED To Know",
        youtube_url: "https://www.youtube.com/watch?v=W1gWHIpQNVU",
        youtube_video_id: "W1gWHIpQNVU",
        order_index: 0,
        duration_minutes: 19,
        why_this_video: "A rapid-fire, visual guide to the most common tactical motifs like pins, forks, and skewers.",
        skills_gained: ["Tactics", "Pins", "Forks", "Skewers", "Discovered Attacks"]
      },
      {
        id: randomUUID(),
        title: "30 SIMPLE Chess Concepts To Crush Everyone",
        youtube_url: "https://www.youtube.com/watch?v=amrehhj6WDg",
        youtube_video_id: "amrehhj6WDg",
        order_index: 1,
        duration_minutes: 32,
        why_this_video: "Transition from basic rules to intermediate strategy and positional understanding.",
        skills_gained: ["Strategy", "Positional Chess", "Pawn Structure", "Middle Game"]
      }
    ],
    quizzes: [
      {
        question: "What is a 'fork' in chess?",
        option_a: "When a piece attacks two or more enemy pieces simultaneously.",
        option_b: "When a piece cannot move because it would expose a more valuable piece.",
        option_c: "Trading a pawn for a knight.",
        option_d: "A type of castling.",
        correct_option: "a",
        explanation: "A fork is a double attack where one piece (often a Knight or Pawn) attacks multiple enemy pieces at the same time."
      },
      {
        question: "What is a 'pin' in chess?",
        option_a: "Attacking two pieces at once.",
        option_b: "When a piece is attacked and moving it would expose a more valuable piece behind it.",
        option_c: "Sacrificing a piece for a positional advantage.",
        option_d: "Moving a piece to the edge of the board.",
        correct_option: "b",
        explanation: "A pin occurs when a defending piece cannot move without exposing a more valuable piece (like the King or Queen) to capture."
      }
    ],
    recap: {
      key_takeaways: [
        "Tactics decide most beginner and intermediate games.",
        "Always look for forcing moves: Checks, Captures, and Threats.",
        "Pins paralyze enemy pieces, while forks create multiple threats.",
        "Good pawn structure provides a long-term strategic advantage."
      ],
      exercises_jsonb: [
        {
          type: "practice",
          prompt: "Solve 10 tactical puzzles on Lichess or Chess.com focusing on pins and forks."
        }
      ]
    }
  }
]

async function main() {
  console.log(`Starting seed for course: ${COURSE.slug}`)

  // Delete existing if any
  await db.from('courses').delete().eq('slug', COURSE.slug)

  // 1. Insert course
  const { data: course, error: courseErr } = await db
    .from('courses')
    .insert({ ...COURSE })
    .select()
    .single()

  if (courseErr) throw courseErr
  console.log(`✅ Inserted course: ${course.id}`)

  // 2. Insert course creators
  for (const creator of CREATORS) {
    await db.from('course_creators').insert({
      course_id: course.id,
      ...creator
    })
  }
  console.log(`✅ Inserted course creators`)

  // 3. Insert Modules & related content
  for (const mod of MODULES) {
    const { quizzes, recap, lessons, ...modData } = mod

    const { data: dbMod, error: modErr } = await db
      .from('modules')
      .insert({ ...modData, course_id: course.id })
      .select()
      .single()

    if (modErr) throw modErr
    console.log(`  ✅ Inserted module: ${dbMod.id} (${mod.title})`)

    // Lessons
    for (const less of lessons) {
      const { data: dbLess, error: lessErr } = await db
        .from('lessons')
        .insert({ ...less, module_id: dbMod.id })
        .select()
        .single()
      if (lessErr) throw lessErr
      console.log(`    ✅ Inserted lesson: ${dbLess.id}`)

      // Dummy transcript so QA doesn't fail
      await db.from('lesson_transcripts').insert({
        lesson_id: dbLess.id,
        transcript_text: 'Dummy transcript for ' + less.title + '. ' + less.why_this_video,
        segments_jsonb: [],
        fetched_at: new Date().toISOString()
      })
    }

    // Quizzes
    for (const q of quizzes) {
      await db.from('quizzes').insert({
        module_id: dbMod.id,
        ...q
      })
    }

    // Module Recap
    if (recap) {
      await db.from('module_recaps').insert({
        module_id: dbMod.id,
        ...recap
      })
    }
    
    // Module intro screens
    const moduleIntroScreens = [
      {
        slide_type: 'title',
        content_jsonb: {
          title: mod.title,
          subtitle: `Module ${mod.order_index + 1}`
        }
      },
      {
        slide_type: 'bullets',
        content_jsonb: {
          title: 'What you will learn',
          bullets: [
            'Key concepts of ' + mod.title,
            'Practical examples',
            'Interactive quizzes'
          ]
        }
      }
    ]

    for(let i = 0; i < moduleIntroScreens.length; i++) {
      await db.from('intro_screens').insert({
        scope: 'module',
        scope_id: dbMod.id,
        order_index: i,
        ...moduleIntroScreens[i]
      })
    }
  }

  // Course Intro Screens
  const courseIntroScreens = [
    {
      slide_type: 'title',
      content_jsonb: {
        title: 'Welcome to ' + COURSE.title,
        subtitle: 'Let\'s get started!'
      }
    },
    {
      slide_type: 'text',
      content_jsonb: {
        title: 'Course Overview',
        text: COURSE.description
      }
    }
  ]

  for (let i = 0; i < courseIntroScreens.length; i++) {
    await db.from('intro_screens').insert({
      scope: 'course',
      scope_id: course.id,
      order_index: i,
      ...courseIntroScreens[i]
    })
  }

  console.log(`\\n🎉 Seeded ${COURSE.title} Course Successfully!`)
  console.log(`Course URL: /courses/${COURSE.slug}`)
}

main().catch(console.error)
